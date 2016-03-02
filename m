From: Mark Lord <kernel@start.ca>
Subject: Re: [report] sata_qstor.c: ancient pointer math bug
Date: Wed, 2 Mar 2016 09:30:40 -0500
Message-ID: <56D6F910.7000300@start.ca>
References: <20160302094458.GA5213@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:48660 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbcCBOoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Mar 2016 09:44:08 -0500
In-Reply-To: <20160302094458.GA5213@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org

On 16-03-02 04:44 AM, Dan Carpenter wrote:
..
> drivers/ata/sata_qstor.c
>     252  static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
>     253  {
>     254          struct scatterlist *sg;
>     255          struct ata_port *ap = qc->ap;
>     256          struct qs_port_priv *pp = ap->private_data;
>     257          u8 *prd = pp->pkt + QS_CPB_BYTES;
>     258          unsigned int si;
>     259
>     260          for_each_sg(qc->sg, sg, qc->n_elem, si) {
>     261                  u64 addr;
>     262                  u32 len;
>     263
>     264                  addr = sg_dma_address(sg);
>     265                  *(__le64 *)prd = cpu_to_le64(addr);
>     266                  prd += sizeof(u64);
>     267
>     268                  len = sg_dma_len(sg);
>     269                  *(__le32 *)prd = cpu_to_le32(len);
>     270                  prd += sizeof(u64);
>
> This is almost certainly a cut and paste bug where prd += sizeof(u32)
> was intended.  Probably no one cares at this point though...

No, the hardware really does want sizeof(u64) in both places above.
A PRD entry is 16 bytes in total.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
