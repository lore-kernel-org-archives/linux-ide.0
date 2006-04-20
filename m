From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil: write corruption on parallel access of two or more drives on same controller
Date: Thu, 20 Apr 2006 11:25:27 +0900
Message-ID: <20060420022527.GA3697@htj.dyndns.org>
References: <4446BE3C.7050902@priv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:9129 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbWDTCZT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Apr 2006 22:25:19 -0400
Received: by wproxy.gmail.com with SMTP id i2so16391wra
        for <linux-ide@vger.kernel.org>; Wed, 19 Apr 2006 19:25:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4446BE3C.7050902@priv.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus M?ller <mm@priv.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Thu, Apr 20, 2006 at 12:48:28AM +0200, Markus M?ller wrote:
> Hi sil_sata.c-Developers,
> 
> I've a problem accessing discs on my SIL 3114 controller: If I write
> to it and if during this any other access (= read or write) to a disc
> on same controller occures, there are write errors.
> 
> The kernel doesn't realise this at all, there is no message about
> that in dmesg or syslog.
> 
[--snip--]
> This problem doesn't occure with this sil controllers and sata
> hdds on a Neo2 Board with AMD64 from MSI so...
> 
> -> Maybe the SIL-Driver isn't useable with the NForce2 Chipset?!

This sounds like something is going wrong on the host bus.

> Please inculde me in answers as CC, cause I am currently
> not on the kernel mailing list.

I used to do the same but you don't have to ask for cc'ing.  It's the
way things are done here.  People are not supposed to trim cc-list
unless there are specific reasons.

Can you try the following patch?  Be careful, I've only compile-tested
it.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 509178c..b785e2b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4280,6 +4280,13 @@ inline unsigned int ata_host_intr (struc
 		/* before we do anything else, clear DMA-Start bit */
 		ap->ops->bmdma_stop(qc);
 
+		/* check host bus error */
+		if (host_stat & ATA_DMA_ERR) {
+			printk(KERN_ERR "ata%u: BMDMA host bus error\n",
+			       ap->id);
+			qc->err_mask |= AC_ERR_HOST_BUS;
+		}
+
 		/* fall through */
 
 	case ATA_PROT_ATAPI_NODATA:

