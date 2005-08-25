From: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
Subject: sata_sil + UDMA CRC errors
Date: Thu, 25 Aug 2005 20:51:15 +0700
Message-ID: <1124977875.2949.10.camel@m00>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.isp.nsc.ru ([194.226.178.19]:21467 "EHLO ns.isp.nsc.ru")
	by vger.kernel.org with ESMTP id S964990AbVHYNvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2005 09:51:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com

Good time of the day.
I think this might be a bug in sata_sil driver.

I have ASUS K8N-DL board with onborad sil3114 controller. As support for
nVidia Nforce 2200 SATA is broken in current sata_nv driver, i have to
use sil3114. Kernel is 2.6.13-rc6 + "sata_sil Mod15Write
quirk workaround" patch of TeJun Heo. OS is Fedora4 x86_64

There are two SATA drives, Seagate 7200.7 160Gb and Samsung SP0812C
80Gb. 

Here is the problem: 
Any intensive read/write activity results in alot of UDMA CRC errors for both drives.
I am getting :
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
kernel messages. With the patch applied, error rate is significantly low
for Seagate drive; Samsung is still virtually unusable. 
I checked SMART attributes, and the count of  UDMA CRC errors is ~200
for Seagate and more than 1000 for Samsung. Every time i get new
"status=0x51" errors for any drive, number of UDMA CRC errors grow
accordingly. 

But there seems to be no problems under Windows. Even highest read/write
activity do not generate any new CRC errors. 

Sorry for bad english.

Best Regards,
Alexander Shaposhnikov


 









