From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken between rc1 and rc3)]
Date: Wed, 23 Aug 2006 22:17:49 +0200
Message-ID: <m2fyfnciky.fsf@vador.mandriva.com>
References: <44D98E7E.3060208@pobox.com> <44E29AEF.8030606@gmail.com>
	<20060816051408.GI6371@htj.dyndns.org>
	<m2wt98bio1.fsf@vador.mandriva.com> <m2sljwbil7.fsf@vador.mandriva.com>
	<44E37BD4.8010709@pobox.com> <m23bbva9cs.fsf@vador.mandriva.com>
	<44E46E0E.4060703@gmail.com> <m2fyfv7a8s.fsf@vador.mandriva.com>
	<44EB32AD.1080305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:23049 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S965014AbWHWURv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Aug 2006 16:17:51 -0400
In-Reply-To: <44EB32AD.1080305@gmail.com> (Tejun Heo's message of "Wed, 23 Aug 2006 01:37:01 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

--=-=-=

Tejun Heo <htejun@gmail.com> writes:

> [cc'ing linux-ide]
> 
> (this is regarding vt6421 failing to detect devices on boot after EH udpate)
> 
> > I think I have (but I was so tired I won't 100% claim to).
> > I'll retest tonight.

The following one-liner on top of your previous patch fixed detecting
disks on vt6421 with 2.6.18-rc4-mm1 (sorry for the delay, I was
offline due to illness). (s!/scsi!/ata! b/c of alan changes in -mm)


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=work1.diff

fix detecting devices on vt6421 SATA controller
("ATA: abnormal status 0x7F on port 0xB007"):
--- drivers/ata/sata_via.c.tv6	2006-08-20 16:37:41.000000000 +0200
+++ drivers/ata/sata_via.c	2006-08-20 17:20:23.000000000 +0200
@@ -244,7 +244,7 @@
 
 static void vt6421_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, ata_std_prereset, NULL,
+	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
 				  sata_std_hardreset, ata_std_postreset);
 }
 

--=-=-=

 
> Can you please test two patches attached in this mail?  Just quick
> result will be enough.  If both don't work, I'll go ahead and create
> a third one - which emulates the old phy hardreset exactly as I did
> for softreset of vt6420.

I'll.

As, I've tested that using:
- ata_std_prereset + ata_std_softreset didn't work
- vt6420_prereset + ata_std_softreset worked
- vt6420_prereset w/o ata_std_softreset didn't work

I simple interdiff between your two patches makes me think the odds're
higher the second will succeed but you've done some extra changes
since your previous patch.
I'll you tell you more about this tomorrow.

--=-=-=--
