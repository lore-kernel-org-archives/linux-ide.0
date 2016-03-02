From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [report] sata_qstor.c: ancient pointer math bug
Date: Wed, 2 Mar 2016 12:44:58 +0300
Message-ID: <20160302094458.GA5213@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37588 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbcCBJpH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2016 04:45:07 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello Mark Lord matches,

The patch 1da177e4c3f4 from Apr 16, 2005, leads to the following static
checker warning:

	drivers/ata/sata_qstor.c:270 qs_fill_sg()
	warn: was expecting 4 bytes for 'prd'

drivers/ata/sata_qstor.c
   252  static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
   253  {
   254          struct scatterlist *sg;
   255          struct ata_port *ap = qc->ap;
   256          struct qs_port_priv *pp = ap->private_data;
   257          u8 *prd = pp->pkt + QS_CPB_BYTES;
   258          unsigned int si;
   259  
   260          for_each_sg(qc->sg, sg, qc->n_elem, si) {
   261                  u64 addr;
   262                  u32 len;
   263  
   264                  addr = sg_dma_address(sg);
   265                  *(__le64 *)prd = cpu_to_le64(addr);
   266                  prd += sizeof(u64);
   267  
   268                  len = sg_dma_len(sg);
   269                  *(__le32 *)prd = cpu_to_le32(len);
   270                  prd += sizeof(u64);

This is almost certainly a cut and paste bug where prd += sizeof(u32)
was intended.  Probably no one cares at this point though...

   271  
   272                  VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", si,
   273                                          (unsigned long long)addr, len);
   274          }
   275  
   276          return si;
   277  }

regards,
dan carpenter
