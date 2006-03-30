From: Bradford Arrington <brada@cadence.com>
Subject: ata_piix sata disk  timeout from the power adapter./batterry on
 T43p
Date: Wed, 29 Mar 2006 16:08:01 -0800
Message-ID: <20060329160801.40ec1408.brada@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isvw3.Cadence.COM ([158.140.2.61]:10475 "EHLO
	mx-sanjose2.Cadence.COM") by vger.kernel.org with ESMTP
	id S1751174AbWC3AI2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Mar 2006 19:08:28 -0500
Received: from MAILSJ1.global.cadence.com (localhost [127.0.0.1])
	by mx-sanjose2.Cadence.COM (8.12.9/8.12.9) with ESMTP id k2U08Lw4004047
	for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2006 16:08:21 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


 
I have a problem when I unplug the power adapter from a T43p laptop.
It is running Redhat 3 update 7.

Intel 82801FBM (ICH6M) SATA Controller.
 
ata1: command 0xca timeout, stat 0xd0 host_stat 0x24
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
Info fld=0x90c0d, Current sd08:02: sense key Aborted Command
Additional sense indicates Scsi parity error
 I/O error: dev 08:02, sector 384064
ATA: abnormal status 0xD0 on port 0x1F7
ATA: abnormal status 0xD0 on port 0x1F7
ATA: abnormal status 0xD0 on port 0x1F7
 
I have made some progress, it comes back after about 50 secs from an plug/unplug action without disk errors now.

What would cause the kernel to suspend the disk when it goes to battery power?
 
I would greatly appreciate any help on this problem, even if you just
point me in the right direction.
 
Thanks,
-Brad
