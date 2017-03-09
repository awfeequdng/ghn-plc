/*
 * nc-bit-loading-date.h
 *
 *  Created on: 24.09.2016
 *,,Author: tsokalo
 */

#ifndef GHN_PLC_BITLOADINGDATE_H_
#define GHN_PLC_BITLOADINGDATE_H_

#include <tuple>
#include <vector>
#include "ns3/plc-defs.h"

#include "ghn-plc-utilities.h"

#include "comparison.h"

//#define PER_BER_MAP_SIZE        500
#define MIN_PER_VAL     0.00001
#define MAX_PER_VAL     0.99

namespace ns3
{
namespace ghn
{
struct PbMapping
{
  PbMapping (double per_, CodingType ct, double ber, double per)
  {
    this->per_ = per_;
    this->ct = ct;
    this->ber = ber;
    this->per = per;
  }
  PbMapping&
  operator= (const PbMapping& other)
  {
    if (this != &other)
      {
        this->per_ = other.per_;
        this->ct = other.ct;
        this->ber = other.ber;
        this->per = other.per;
      }
    return *this;
  }
  double per_;
  CodingType ct;
  double ber;
  double per;
};

typedef std::map<CodingType, std::map<uint32_t, std::vector<PbMapping> > > PBMapping_t;

class PbMappingList
{
public:
  PbMappingList (){}

  virtual
  ~PbMappingList ();

  static PBMapping_t CreatePbMapping();


  static double
  get_per (double ber, uint32_t pkt_size, CodingType ct)
  {
    assert(m_pbMapping.find (ct) != m_pbMapping.end ());
    assert(m_pbMapping[ct].find (pkt_size) != m_pbMapping[ct].end ());

    auto min_ber = m_pbMapping[ct][pkt_size].begin ()->ber;
    auto max_ber = m_pbMapping[ct][pkt_size].at (m_pbMapping[ct][pkt_size].size () - 1).ber;
    if (ber < min_ber) return 0;
    if (ber > max_ber) return 1;

    for (auto pbm : m_pbMapping[ct][pkt_size])
      {
        if (ncr::geq (pbm.ber, ber))
          {
            return pbm.per;
          }
      }
    assert(0);
  }

  static double
  get_ber (double per, uint32_t pkt_size, CodingType ct)
  {
    assert(m_pbMapping.find (ct) != m_pbMapping.end ());
    assert(m_pbMapping[ct].find (pkt_size) != m_pbMapping[ct].end ());

    auto min_per = m_pbMapping[ct][pkt_size].begin ()->per;
    auto max_per = m_pbMapping[ct][pkt_size].at (m_pbMapping[ct][pkt_size].size () - 1).per;
    if (per < min_per) return 0;
    if (per > max_per) return 1;

    for (auto pbm : m_pbMapping[ct][pkt_size])
      {
        if (ncr::geq (pbm.per, per))
          {
            return pbm.ber;
          }
      }
    assert(0);
  }

private:

  static PBMapping_t m_pbMapping;
};
}
}
#endif /* GHN_PLC_BITLOADINGDATE_H_ */
