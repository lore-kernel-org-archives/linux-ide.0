From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [git patches] libata fixes
Date: Thu, 31 May 2007 16:31:57 +0800
Message-ID: <465E87FD.1070102@tw.ibm.com>
References: <20070525220307.GA2914@havoc.gtf.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:34154 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbXEaIcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 May 2007 04:32:31 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4V8WIvL013217
	for <linux-ide@vger.kernel.org>; Thu, 31 May 2007 04:32:18 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4V8WDxW243522
	for <linux-ide@vger.kernel.org>; Thu, 31 May 2007 02:32:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4V8WDMZ001239
	for <linux-ide@vger.kernel.org>; Thu, 31 May 2007 02:32:13 -0600
In-Reply-To: <20070525220307.GA2914@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> And a few trivial documentation patches.
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/ata/libata-scsi.c  |    5 ++-
>  drivers/ata/pata_artop.c   |    2 +-
>  drivers/ata/pata_hpt37x.c  |   27 ++++++++++---------------
>  drivers/ata/pata_it821x.c  |    3 +-
>  drivers/ata/pata_scc.c     |   46 ++++++++++++++++++++++++++-----------------
>  drivers/ata/pata_via.c     |    9 ++++---
>  drivers/ata/sata_mv.c      |   44 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/sata_promise.c |    2 +-
>  drivers/ata/sata_sis.c     |    2 +-
>  drivers/ata/sata_via.c     |    3 ++
>  10 files changed, 98 insertions(+), 45 deletions(-)
> 
> Alan Cox (2):
>       pata: Trivia
>       pata_hpt37x: Further improvements based on the IDE updates and vendor drivers
> 
> Jeff Garzik (4):
>       [libata] sata_promise: fix flags typo
>       [libata] sata_mv: add TODO list
>       [libata] Fix decoding of 6-byte commands
>       [libata] sata_via, pata_via: Add PCI IDs.
> 
> Tony Breeds (1):
>       Fix build failure for drivers/ata/pata_scc.c
> 
> Uwe Koziolek (1):
>       libata: sata_sis fixes
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 242c43e..b3900cf 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1050,14 +1050,15 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
>  static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
>  {
>  	u64 lba = 0;
> -	u32 len = 0;
> +	u32 len;
>  
>  	VPRINTK("six-byte command\n");
>  
> +	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
>  	lba |= ((u64)cdb[2]) << 8;
>  	lba |= ((u64)cdb[3]);
>  
> -	len |= ((u32)cdb[4]);
> +	len = cdb[4];
>  
>  	*plba = lba;
>  	*plen = len;

Oops, I overlooked the MSB bits. :(
Thanks for catching this.
--
albert

