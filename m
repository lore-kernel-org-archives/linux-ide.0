From: Paul Jakma <paul@clubi.ie>
Subject: Re: [PATCH] fix sata_sil quirk
Date: Wed, 23 Jun 2004 04:24:49 +0100 (IST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org>
References: <40D89509.6010502@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hibernia.jakma.org ([212.17.55.49]:14473 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266092AbUFWDZE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 23:25:04 -0400
In-Reply-To: <40D89509.6010502@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Ricky Beam <jfbeam@bluetronic.net>, Linux Kernel <linux-kernel@vger.kernel.org>

On Tue, 22 Jun 2004, Jeff Garzik wrote:

> Here's my suggested fix...  good catch Ricky.
>
> Yes, unfortunately performance will be dog slow.
>
> Silicon Image 311x is fully SATA compliant -- but it's the only controller 
> that sends odd-sized packets to the SATA device.  That causes no end of 
> problems, including the thing that SIL_QUIRK_MOD15WRITE attempts to work 
> around.

As an extra data point, i have:

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
   Type:   Direct-Access                    ANSI SCSI revision: 05

# lspci  | grep Sil
00:09.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
Technology Inc) Silicon Image Serial ATARaid Controller [ CMD/Sil
3112/3112A ] (rev 02)
00:0a.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
Technology Inc) Silicon Image Serial ATARaid Controller
[ CMD/Sil 3112/3112A ] (rev 02)

# modinfo sata_sil
author:         Jeff Garzik
description:    low-level driver for Silicon Image SATA controller
license:        GPL
vermagic:       2.6.6-1.397.root K6 REGPARM gcc-3.3

And am not having (touch wood) any stability problems using these 
disks with linux md RAID1 and RAID5. Though, they're in a K6-II 350, 
so performance is slow anyway. (i get about 25MB/s absolute max 
reading from a RAID-5 array).

  > 	 Jeff

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
A bird in the hand makes it awfully hard to blow your nose.
