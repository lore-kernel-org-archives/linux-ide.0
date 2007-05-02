From: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Subject: Problems w/ Sil3124 + Port Multiplier
Date: Wed, 02 May 2007 08:00:22 +0200
Message-ID: <463828F6.7020209@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.jogback.se ([192.165.82.16]:59000 "EHLO jogback.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750719AbXEBHAc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 May 2007 03:00:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi,

I have a system with a Sil3124 controller and two Sil3726 port multipliers.
I'm running 2.6.18.1 with the patches from 
http://home-tj.org/wiki/index.php/Libata-tj-stable
since I was not able to get the port multipler to work at all with 
2.6.21 (perhaps the support for PMP is not fully integrated there).

One of my Sil3726 is freezing my system approx one time per hour when 
the disks are under load.

ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: tag 0 cmd 0xea Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5.15: hard resetting port
ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: hard resetting port
ata5.00: SATA link up 3.0 Gbps (SStatus 113 SControl 300)
ata5.01: hard resetting port
ata5.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.02: hard resetting port
ata5.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.03: hard resetting port
ata5.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.04: hard resetting port
ata5.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/100
ata5.01: configured for UDMA/100
ata5.02: configured for UDMA/100
ata5.03: configured for UDMA/100
ata5.04: configured for UDMA/100
ata5: EH complete

I suspect that the root-cause of the problem could be drive-related. All 
the disks on the other Sil3726 are WD4000KD's and the
disks attached to this one is 3xWD4000KD and 1xWD4000KS and 1xSamsung 
HD501LJ. Is there a way of test this?

Is there an updated patch-set for port multipliers in a later kernel 
than 2.6.18.1?

Regards,
/LM


