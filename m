From: Tejun Heo <teheo@novell.com>
Subject: Re: sata_inic162x for help
Date: Sun, 10 May 2009 10:06:01 +0900
Message-ID: <4A062879.7090301@novell.com>
References: <4A04C04F.8030106@novell.com> <6529177.841681241588784941.JavaMail.coremail@bj163app14.163.com> <12087558.131021241843439832.JavaMail.coremail@bj163app14.163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39764 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbZEJBGJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 May 2009 21:06:09 -0400
In-Reply-To: <12087558.131021241843439832.JavaMail.coremail@bj163app14.163.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ivorhuang_hjd <ivorhuang_hjd@163.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

Hello,

ivorhuang_hjd wrote:
> hello Tejun,
> I am sorry for that and thank you for your reply.I should give you more
> information.
> 1.the sata IC is INI-SATA-1622B
> 2.the sata card can work at x86 (kernel linux 2.6.29.1 )
> 4. the sata card can work at powerpc freescale mpc8313erdb(kernel linux
> 2.6.23),I know it does not support LBA48.so I think this is not for the
> u-boot.
> 5.another sata card sis3512 can work at powerpc freescale mpc8313erdb
> (kernel linux 2.6.29.1)
> 6. the problem come out at powerpc freescale mpc8313erdb (kernel linux
> 2.6.29.1)

Hmm...

> [  825.618798] ata1: SATA max UDMA/133 mmio m4096@0x90000000
> <mailto:m4096@0x90000000> PORT 0x90000000 irq 17
> [  825.626224] ata2: SATA max UDMA/133 mmio m4096@0x90000000
> <mailto:m4096@0x90000000> PORT 0x90000040 irq 17
> [  825.982369] ata1: SATA link down (SStatus 0 SControl 300)
> [  826.494373] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  826.500610] err happen
> [  826.503026] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed,
> err_mask=0x80)
> [  831.990383] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  831.996613] err happen
> [  831.999040] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed,
> err_mask=0x80)
> [  832.006372] ata2: limiting SATA link speed to 1.5 Gbps
> [  837.486394] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  837.492624] err happen
> [  837.495051] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed,
> err_mask=0x80)
...
> *************************************************
> the "err happen" is what I printk at function
> inic_qc_fill_rtf(sata_inc162x.c 578 line).
> can you help me to fix this problem.

What is the attached device?  Does it work if you skip
INIT_DEV_PARAMS?  You can skip it by editing
libata-core.c::ata_dev_read_id() such that the if condition
enclosing... erggh... by applying the following patch.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 17c5d48..2d51b32 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2210,7 +2210,7 @@ retry:
 			goto retry;
 	}
 
-	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
+	if (0 && (flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
 		 * SRST RESET

-- 
tejun
