From: Tejun Heo <htejun@gmail.com>
Subject: Re: Re : sata_sil problems with SIL3512 controler on a ppc target
Date: Wed, 15 Nov 2006 21:59:46 +0900
Message-ID: <455B0F42.5030709@gmail.com>
References: <20061109103313.95820.qmail@web51414.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050304000107060704040302"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:60315 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S966831AbWKOM7w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 07:59:52 -0500
Received: by nz-out-0102.google.com with SMTP id l1so35552nzf
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 04:59:52 -0800 (PST)
In-Reply-To: <20061109103313.95820.qmail@web51414.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: snatcher snatcher <snatcher93@rocketmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050304000107060704040302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

snatcher snatcher wrote:
> By checking the old 2.4.20 driver used for this device, I've found
> the following lines :
> 
> #ifdef CONFIG_BUFFALO_PLATFORM
 > writel(0x10401554, mmio_base + 0x14c);
> writel(0x10401554, mmio_base + 0x1cc);
 > #endif in the sil_init_one function (in sata_sil.c)...
> 
> After some google searching, I've found this message from this
> mailing list : http://www.spinics.net/lists/linux-ide/msg00047.html 
> => It says that for SiI 3114 contoler, we need to force write
> 0x10401554 instead of 0x10401555 in sfis_cfg (SATA FIS reception
> config register). By looking in the source code of the latest
> version, it looks like my controler (Sil 3512) is set to apply this
> workaround too, but according to my boot log, it's not applying it
> (It should write "Applying R_ERR on DMA / activate FIS errata fix"
> just after the error about the PCI cache). I'll add some traces to
> understand what's happening and I'll tell you ... Sylver

Please apply the attached patch and report what happens.

-- 
tejun

--------------050304000107060704040302
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index f844a1f..5c34f75 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -593,8 +593,6 @@ static void sil_init_controller(struct p
 
 		for (i = 0, cnt = 0; i < n_ports; i++) {
 			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
-			if ((tmp & 0x3) != 0x01)
-				continue;
 			if (!cnt)
 				dev_printk(KERN_INFO, &pdev->dev,
 					   "Applying R_ERR on DMA activate "
diff --git a/include/linux/libata.h b/include/linux/libata.h

--------------050304000107060704040302--
