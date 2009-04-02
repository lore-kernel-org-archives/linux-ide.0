From: Thomas Jackowski <aXe@hadiko.de>
Subject: Errors on ICH10R with Seagate HDDs
Date: Thu, 02 Apr 2009 13:32:02 +0200
Message-ID: <49D4A232.3090504@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.rz.uni-karlsruhe.de ([129.13.185.218]:60775 "EHLO
	smtp2.rz.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZDBL4s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 07:56:48 -0400
Received: from postamt.hadiko.de ([2001:638:204:10:21b:21ff:fe22:d9c2] helo=[IPv6:2001:638:204:10:21b:21ff:fe22:d9c2])
	by nce3.hadiko.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LpL9P-0007f2-Eo
	for linux-ide@vger.kernel.org; Thu, 02 Apr 2009 13:32:03 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I assume a problem between Seagate Drives and the ATA Drivers.

Chipset is a ICH10R, but this problems has been seen on a ICH9 also.

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.11
Device Model:     ST31000340AS
Serial Number:    6QJ03QBN
Firmware Version: SD1A
User Capacity:    1,000,203,804,160 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Fri Mar 27 10:58:37 2009 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

This is /dev/sdc. /dev/sdd and /dev/sde is the same model with the same 
Firmware. I'm using a RAID5 on these 3 HDDs.
Because of the Seagate Firmware Bug I had to upgrade the firmware from
'SD15' to 'SD1A'. The upgrade was successful.

Before the upgrade there were no problems, after the upgrade I have 
trouble like this:

[14144.875924] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[14144.875931] ata4.00: cmd ec/00:01:00:00:00/00:00:00:00:00/00 tag 0 
pio 512 in
[14144.875932]          res 40/00:ff:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[14144.875934] ata4.00: status: { DRDY }
[14144.875938] ata4: hard resetting link
[14145.362708] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[14145.526248] ata4.00: configured for UDMA/133
[14145.526261] ata4: EH complete
[14145.550243] sd 3:0:0:0: [sdd] 1953523055 512-byte hardware sectors 
(1000204 MB)
[14145.550263] sd 3:0:0:0: [sdd] Write Protect is off
[14145.550265] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[14145.550282] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

[507139.744594] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[507139.744602] ata5.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
[507139.744603]          res 40/00:00:be:ac:54/00:00:1b:00:00/e0 Emask 
0x4 (timeout)
[507139.744606] ata5.00: status: { DRDY }
[507139.744611] ata5: hard resetting link
[507140.247396] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[507140.251384] ata5.00: configured for UDMA/133
[507140.251384] ata5: EH complete
[507140.253668] sd 4:0:0:0: [sde] 1953523055 512-byte hardware sectors 
(1000204 MB)
[507140.253681] sd 4:0:0:0: [sde] Write Protect is off
[507140.253683] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[507140.253701] sd 4:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't suppo
rt DPO or FUA

[507453.049511] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
[507453.049519] ata4.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
[507453.049520]          res 40/00:00:3e:e0:54/00:00:1b:00:00/e0 Emask 
0x4 (timeout)
[507453.049523] ata4.00: status: { DRDY }
[507453.049529] ata4: hard resetting link
[507453.547144] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[507453.843855] ata4.00: configured for UDMA/133
[507453.843855] ata4: EH complete
[507453.871434] sd 3:0:0:0: [sdd] 1953523055 512-byte hardware sectors 
(1000204 MB)
[507453.872475] sd 3:0:0:0: [sdd] Write Protect is off
[507453.872475] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[507453.872475] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

Where is the problem?

Bye, Thomas


