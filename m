From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: (libata) cdrom drive not detected in -mm series
Date: Tue, 12 Sep 2006 09:41:59 +0200
Message-ID: <450664C7.3000105@gmail.com>
References: <9bfa9ae0609111802o9131e8bg6c5d394ad87b16ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000009060807020903060601"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:30864 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964963AbWILHmU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Sep 2006 03:42:20 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1894196wxc
        for <linux-ide@vger.kernel.org>; Tue, 12 Sep 2006 00:42:20 -0700 (PDT)
In-Reply-To: <9bfa9ae0609111802o9131e8bg6c5d394ad87b16ea@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Nelson A. de Oliveira" <naoliv@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000009060807020903060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nelson A. de Oliveira wrote:
> Hi!
> 
> My USB CD-ROM drive (that is detected as a SCSI drive) is not being
> detected on the -mm series of the Kernel.

s/USB/SATA/, I presume.

[--snip--]
-ata2.00: ATAPI, max UDMA/33
-ata2.00: configured for UDMA/33
-  Vendor: HL-DT-ST  Model: CDRW/DVD GCC4244  Rev: B101
-  Type:   CD-ROM                             ANSI SCSI revision: 05

Argh... yet another PCS problem.  With whole -mm applied, does adding 
kernel parameter 'ata_piix.force_pcs=1' make any difference?

Please provide the following info.

* the result of 'lspci -nvvv'

* dmesg output with the attached patch applied (on top of -mm).

Thanks.

-- 
tejun

--------------000009060807020903060601
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 22b2dba..53a19fd 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -560,7 +560,7 @@ static unsigned int piix_sata_present_ma
 	u16 pcs;
 
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
-	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
+	printk(KERN_INFO "ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
 	for (i = 0; i < 2; i++) {
 		port = map[base + i];
@@ -571,7 +571,7 @@ static unsigned int piix_sata_present_ma
 			present_mask |= 1 << i;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+	printk(KERN_INFO "ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
 	return present_mask;

--------------000009060807020903060601--
