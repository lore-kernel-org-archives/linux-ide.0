From: Peter Valach <pvalach@gmx.net>
Subject: Seagate ST3200822AS SATA disk needs to be in sil_blacklist as well
Date: Sat, 27 Nov 2004 19:23:12 +0100
Message-ID: <20041127182312.GA9207@pp.pv2c.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:22708 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261294AbUK0SXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Nov 2004 13:23:14 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

I just want to inform you, that I managed to use my SATA disk for the
first time :) by adding this line into sil_blacklist in
linux/drivers/scsi/sata_sil.c:

 { "ST3200822AS",        SIL_QUIRK_MOD15WRITE },

For the record, it's an 200GB Seagate SATA disk and I'm the unfortunate
owner of a mainboard with integrated "Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3512" SATA controller. I use kernel 2.6.9. Just to
be sure I downloaded the 2.6.10-rc2 patch but it isn't there as well.

Please include this "patch" so other unfortunate ones like me can use
it ;).

Without this patch copying to this SATA disk on this controller freezes
the whole system after some time.

I wish you all the best and good luck in development.

Best,

Peter
<pvalach@gmx.net>

P.S. If you'd be so kind, please answer this: is it possible to control
the disk in some way except hdparm? Because hdparm offers only a few
options for SATA disks and I would really like to control the standby
mode at least ;). Thanks in advance.
