From: Jon =?utf-8?b?S8OlcmU=?= Hellan <hellan@acm.org>
Subject: =?utf-8?b?c2F0YV9zaWwuYyw=?= 3512 and =?utf-8?b?U0lMX1FVSVJLX01PRDE1V1JJVEU=?=
Date: Wed, 22 Feb 2006 18:03:35 +0000 (UTC)
Message-ID: <loom.20060222T182150-518@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:7386 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750755AbWBVSUn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 13:20:43 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FBybL-0000Xr-9Y
	for linux-ide@vger.kernel.org; Wed, 22 Feb 2006 19:20:35 +0100
Received: from 158.38.145.115 ([158.38.145.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 19:20:35 +0100
Received: from hellan by 158.38.145.115 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 19:20:35 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My Shuttle SN85G4V2 with Silicon Image 3512 SATA controller has been locking up
frequently for a while. Console message:

ata1: command 0x35 timeout, stat 0x58 host_stat 0x61
ata1: status=0x58 { DriveReady SeekComplete DataRequest }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 57582833
Buffer I/O error on device sda6, logical block 3097255
lost page write due to I/O error on sda6
ATA: abnormal status 0x58 on port 0xF8802087
ATA: abnormal status 0x58 on port 0xF8802087

I have a Seagate ST3200822AS disk, which is on the blacklist in sata_sil.
In sil_pci_tbl in drivers/sata/sata_sil.c, I changed 3512 from sil_3112 to
sil_3112_m15w, enabling SIL_QUIRK_MOD15WRITE for my controller. With this, the
lockups are gone.

Looks like MOD15WRITE was turned off for the 3512 between 2.6.13 and 2.6.14.
This may have been a mistake, or else my system is unusually flaky. 

See also my Debian bug report
 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=353790

(I wrote there that I saw the lockups in the 2.6.8 kernel as well. Back then,
the blacklist affected my controller, but my disk drive didn't get on the
blacklist until 2.6.11).

Regards

Jon

