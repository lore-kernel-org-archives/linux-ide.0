From: Erik Mouw <erik@harddisk-recovery.com>
Subject: TASKFILE ioctl for libata?
Date: Wed, 15 Feb 2006 15:34:39 +0100
Message-ID: <20060215143439.GA17850@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:57681 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932454AbWBOOen (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 09:34:43 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Hdparm (6.3) needs the TASKFILE ioctl for the ATA security feature set
(security freeze, security unlock, etc.). I can't find it in Jeff's
libata-dev tree, is there somebody already working on it? Or is there a
workaround?

I've tried to identify (command 0xEC) the device through the TASKFILE
ioctl: it works on a PATA drive (/dev/hda), but with a SATA device
(/dev/sda) I get ENOTTY on the ioctl, so it appears that the TASKFILE
ioctl is indeed not (yet) implemented.

Any thoughts?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
