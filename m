From: Daniel Drake <dsd@gentoo.org>
Subject: Strange kernel messages using sata_sil under 2.6.7-rc1-mm1
Date: Fri, 28 May 2004 16:03:08 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40B754AC.4030607@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpc5-hitc2-5-0-cust152.lutn.cable.ntl.com ([82.0.115.152]:58023
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263079AbUE1Nt0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 May 2004 09:49:26 -0400
Received: from [192.168.0.2] (dsd [192.168.0.2])
	by zog.reactivated.net (Postfix) with ESMTP id D7BC426D853
	for <linux-ide@vger.kernel.org>; Fri, 28 May 2004 14:57:28 +0100 (BST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Earlier, I switched from 2.6.6-mm2 to 2.6.7-rc1-mm1.
I now get the following messages in dmesg, which I have not seen before:

FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 
0x20 0x00
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 
0x20 0x00

I get approximately one of these messages every 20 minutes.
Problem persists after a reboot.

grepping for "Raw sense data" suggests that this message comes from the SCSI 
layer. The only SCSI-like thing on my system is my SATA disk. It's a Seagate 
40GB IDE disk, connected via an IDE-SATA converter to a:

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology 
Inc) Silicon Image Serial ATARaid Controller [ CMD/Sil 3112/3112A ] (rev 02)

Despite these messages, the system seems to be running OK.

Is this a problem with the SATA implementation or should I report it to the 
SCSI developers? Any patches I should try reverting or adding?

Thanks,

Daniel
