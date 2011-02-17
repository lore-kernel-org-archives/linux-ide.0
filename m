From: Steven Haigh <netwiz@crc.id.au>
Subject: sata-sil drive detection issues.
Date: Thu, 17 Feb 2011 14:16:04 +1100
Message-ID: <4D5C92F4.5000906@crc.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vm.crc.id.au ([203.56.246.92]:33704 "EHLO
	mail.vm.crc.id.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab1BQDtS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 22:49:18 -0500
Received: from [IPv6:2002:cb38:f71b:1:48c1:3e64:4c58:71cc] ([IPv6:2002:cb38:f71b:1:48c1:3e64:4c58:71cc])
	(authenticated bits=0)
	by mail.vm.crc.id.au (8.13.8/8.13.8) with ESMTP id p1H3FxHU001172
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2011 14:16:00 +1100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

Firstly, please CC me in all replies as I am not a member of this list.

I have been having an issue with quite a few of the fedora kernels in 
detecting drives on a sil3112 or sil3114 PCI card.

When plugging in a SATA drive (I'm using an external esata drive for 
this test), I see the following appear in dmesg:

[   74.664034] ata10: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xe
frozen
[   74.664208] ata10: SError: { PHYRdyChg CommWake }
[   74.664310] ata10: hard resetting link
[   80.416870] ata10: link is slow to respond, please be patient (ready=-19)
[   81.789464] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   81.789572] ata10.00: NODEV after polling detection
[   81.789593] ata10: EH complete

No device is detected.

This seems to occur if the drive is turned on after the machine is 
started, and when the system boots. I can see the drive in the card BIOS 
when the system starts if it is powered on after the drive has power.

So far, I have tried the following kernel versions:
2.6.32.26-174.2.xendom0.fc12.x86_64
2.6.35.10-71.fc14.x86_64
2.6.35.11-83.fc14.x86_64
2.6.38-0.rc4.git0.2.fc15.x86_64

If I move the internal SATA cable from the sil3112 or sil3114 card to 
the onboard SATA ports (detected as AHCI), then the drive is detected as 
it should and works perfectly.

I have a current bug open for Fedora at:
https://bugzilla.redhat.com/show_bug.cgi?id=677217

The sil3114 that is currently installed seemed to work perfectly using 
CentOS 5.5 kernel (based on 2.6.18) - I am going to try and install 
CentOS to a different LV to confirm this shortly.

Does anyone have any suggestions on this?

-- 
Steven Haigh

Email: netwiz@crc.id.au
Web: http://www.crc.id.au
Phone: (03) 9001 6090 - 0412 935 897
Fax: (03) 8338 0299
