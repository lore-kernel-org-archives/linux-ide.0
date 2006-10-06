From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis only recognizing primary drive in 2.6.18
Date: Fri, 06 Oct 2006 12:57:07 +0200
Message-ID: <45263683.408@gmx.net>
References: <20061006065816.GA5782@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40607 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751471AbWJFK5K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Oct 2006 06:57:10 -0400
In-Reply-To: <20061006065816.GA5782@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com

Hi Jim,

the sata_sis is running without slave support in the versions from
kernel.org. That is ok if you are using
a SiS964 and 965L chip. The SiS 965, SiS180 and SiS966 needs a slave
support.

The attached patch against 2.6.18 should help.

feedback, log and output of lspci -vvxxx are welcome.

regards
Uwe Koziolek
> My friend has a motherboard with a SIS182 chipset (1039:0182), with
> four ports on the motherboard.  BIOS sees it as two controllers,
> "IDE2" and "IDE3" with two ports apiece: "IDE2 Primary", "IDE2
> Secondary", etc.
>
> If we plug drives into both the IDE2 Primary and IDE2 Secondary ports,
> BIOS correctly sees and identifies both drives, and they're both
> visible to grub, but sata_sis only sees the primary drive.  The second
> drive just never shows up; no errors are reported.  This is with
--- a/drivers/scsi/sata_sis.c 2006-09-20 05:42:06.000000000 +0200
+++ b/drivers/scsi/sata_sis.c 2006-10-06 12:43:11.000000000 +0200
@@ -128,7 +128,7 @@

static struct ata_port_info sis_port_info = {
.sht = &sis_sht,
- .host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+ .host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS,
.pio_mask = 0x1f,
.mwdma_mask = 0x7,
.udma_mask = 0x7f,

