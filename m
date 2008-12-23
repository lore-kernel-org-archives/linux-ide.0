From: Tim Nufire <linux_ide_tim@ibink.com>
Subject: Frozen drives when using SiI3726
Date: Tue, 23 Dec 2008 02:02:47 -0800
Message-ID: <20E60A0E-48E9-4942-851D-E20C012F5B89@ibink.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 75-147-137-225-SFBA.hfc.comcastbusiness.net ([75.147.137.225]:52016
	"EHLO panda.ibink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824AbYLWKiE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Dec 2008 05:38:04 -0500
Received: from tims-mac.ibink.com ([10.100.1.17])
	by panda.ibink.com with asmtp
	(Cipher TLSv1:RC4-SHA:128) (Exim 3.35 #1 (Debian))
	id 1LF46B-0003kq-00
	for <linux-ide@vger.kernel.org>; Tue, 23 Dec 2008 02:02:47 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'm building a server using 9 SiI3726 based port multiplier backplanes  
connected to cards using SiI3132 (PCI Express) and SiI3124 (PCI). The  
drives are configured into 5 RAID6 groups of 9 drives each such that  
each array has 1 drive from each backplane. During the initial RAID  
synchronization one of the backplanes failed and restarted (see dmesg  
output below). While this did not disrupt the RAID groups this time,  
the reset took about 25 seconds and could easily have caused one or  
more drives to fail.

Is there anything I can do to prevent failures like this?

I'm running Debian Etchnhalf with the backport kernel 2.6.26-bpo.1- 
amd6. Here's my dmesg output...

[115135.002342] ata11.00: failed to read SCR 1 (Emask=0x40)
[115135.002348] ata11.01: failed to read SCR 1 (Emask=0x40)
[115135.002350] ata11.02: failed to read SCR 1 (Emask=0x40)
[115135.002353] ata11.03: failed to read SCR 1 (Emask=0x40)
[115135.002355] ata11.04: failed to read SCR 1 (Emask=0x40)
[115135.002362] ata11.05: failed to read SCR 1 (Emask=0x40)
[115135.002366] ata11.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action  
0x6 frozen
[115135.002424] ata11.00: exception Emask 0x100 SAct 0x5f SErr 0x0  
action 0x6 frozen
[115135.002478] ata11.00: cmd 60/28:00:3f:dc:2a/00:00:48:00:00/40 tag  
0 ncq 20480 in
[115135.002478]          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask  
0x4 (timeout)
[115135.002530] ata11.00: status: { DRDY }
[115135.002559] ata11.00: cmd 60/00:08:67:da:2a/01:00:48:00:00/40 tag  
1 ncq 131072 in
[115135.002560]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask  
0x4 (timeout)
[115135.002612] ata11.00: status: { DRDY }
[115135.002638] ata11.00: cmd 60/d8:10:67:db:2a/00:00:48:00:00/40 tag  
2 ncq 110592 in
[115135.002639]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask  
0x4 (timeout)
[115135.002691] ata11.00: status: { DRDY }
[115135.002718] ata11.00: cmd 60/00:18:67:dc:2a/01:00:48:00:00/40 tag  
3 ncq 131072 in
[115135.002718]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask  
0x4 (timeout)
[115135.003726] ata11.00: status: { DRDY }
[115135.003748] ata11.00: cmd 60/00:20:67:dd:2a/01:00:48:00:00/40 tag  
4 ncq 131072 in
[115135.003749]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask  
0x4 (timeout)
[115135.003795] ata11.00: status: { DRDY }
[115135.003906] ata11.00: cmd 60/80:30:67:de:2a/00:00:48:00:00/40 tag  
6 ncq 65536 in
[115135.003906]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask  
0x4 (timeout)
[115135.003906] ata11.00: status: { DRDY }
[115135.003906] ata11.01: exception Emask 0x100 SAct 0x0 SErr 0x0  
action 0x6 frozen
[115135.003906] ata11.02: exception Emask 0x100 SAct 0x0 SErr 0x0  
action 0x6 frozen
[115135.003906] ata11.03: exception Emask 0x100 SAct 0x0 SErr 0x0  
action 0x6 frozen
[115135.003906] ata11.04: exception Emask 0x100 SAct 0x0 SErr 0x0  
action 0x6 frozen
[115135.003906] ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0  
action 0x6 frozen
[115135.003906] ata11.15: hard resetting link
[115137.199223] ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[115137.203173] ata11.00: hard resetting link
[115137.527173] ata11.00: SATA link up 3.0 Gbps (SStatus 123 SControl  
320)
[115137.527173] ata11.01: hard resetting link
[115137.845619] ata11.01: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115137.845619] ata11.02: hard resetting link
[115138.165222] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115138.165226] ata11.03: hard resetting link
[115138.488248] ata11.03: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115138.488248] ata11.04: hard resetting link
[115138.808248] ata11.04: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115138.808248] ata11.05: hard resetting link
[115139.130406] ata11.05: SATA link up 1.5 Gbps (SStatus 113 SControl  
320)
[115139.242365] ata11.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[115139.242369] ata11.00: revalidation failed (errno=-5)
[115139.242398] ata11.15: hard resetting link
[115139.242400] ata11: controller in dubious state, performing PORT_RST
[115141.474099] ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[115141.474071] ata11.00: hard resetting link
[115141.795928] ata11.00: SATA link up 3.0 Gbps (SStatus 123 SControl  
320)
[115141.795928] ata11.01: hard resetting link
[115142.115928] ata11.01: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115142.115932] ata11.02: hard resetting link
[115142.435928] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115142.435928] ata11.03: hard resetting link
[115142.763091] ata11.03: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115142.763091] ata11.04: hard resetting link
[115143.079449] ata11.04: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115143.079453] ata11.05: hard resetting link
[115143.403091] ata11.05: SATA link up 1.5 Gbps (SStatus 113 SControl  
320)
[115143.514319] ata11.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[115143.514322] ata11.00: revalidation failed (errno=-5)
[115143.514351] ata11.15: hard resetting link
[115143.514353] ata11: controller in dubious state, performing PORT_RST
[115145.746903] ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[115145.748120] ata11.00: hard resetting link
[115146.070875] ata11.00: SATA link up 3.0 Gbps (SStatus 123 SControl  
320)
[115146.070875] ata11.01: hard resetting link
[115146.388295] ata11.01: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115146.388295] ata11.02: hard resetting link
[115146.709654] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115146.709658] ata11.03: hard resetting link
[115147.032813] ata11.03: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115147.032817] ata11.04: hard resetting link
[115147.355108] ata11.04: SATA link up 3.0 Gbps (SStatus 123 SControl  
300)
[115147.355112] ata11.05: hard resetting link
[115147.673730] ata11.05: SATA link up 1.5 Gbps (SStatus 113 SControl  
320)
[115147.683449] ata11.00: configured for UDMA/100
[115147.694876] ata11.01: configured for UDMA/100
[115147.708279] ata11.02: configured for UDMA/100
[115148.077686] ata11.03: configured for UDMA/100
[115148.446001] ata11.04: configured for UDMA/100
[115148.446362] ata11: EH complete
[115148.446523] sd 10:0:0:0: [sdu] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446531] sd 10:0:0:0: [sdu] Write Protect is off
[115148.446533] sd 10:0:0:0: [sdu] Mode Sense: 00 3a 00 00
[115148.446546] sd 10:0:0:0: [sdu] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446560] sd 10:1:0:0: [sdv] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446568] sd 10:1:0:0: [sdv] Write Protect is off
[115148.446569] sd 10:1:0:0: [sdv] Mode Sense: 00 3a 00 00
[115148.446582] sd 10:1:0:0: [sdv] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446596] sd 10:2:0:0: [sdw] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446603] sd 10:2:0:0: [sdw] Write Protect is off
[115148.446604] sd 10:2:0:0: [sdw] Mode Sense: 00 3a 00 00
[115148.446617] sd 10:2:0:0: [sdw] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446631] sd 10:3:0:0: [sdx] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446638] sd 10:3:0:0: [sdx] Write Protect is off
[115148.446639] sd 10:3:0:0: [sdx] Mode Sense: 00 3a 00 00
[115148.446652] sd 10:3:0:0: [sdx] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446666] sd 10:4:0:0: [sdy] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446673] sd 10:4:0:0: [sdy] Write Protect is off
[115148.446674] sd 10:4:0:0: [sdy] Mode Sense: 00 3a 00 00
[115148.446687] sd 10:4:0:0: [sdy] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446700] sd 10:0:0:0: [sdu] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446707] sd 10:0:0:0: [sdu] Write Protect is off
[115148.446708] sd 10:0:0:0: [sdu] Mode Sense: 00 3a 00 00
[115148.446721] sd 10:0:0:0: [sdu] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446734] sd 10:1:0:0: [sdv] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446741] sd 10:1:0:0: [sdv] Write Protect is off
[115148.446742] sd 10:1:0:0: [sdv] Mode Sense: 00 3a 00 00
[115148.446755] sd 10:1:0:0: [sdv] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446767] sd 10:2:0:0: [sdw] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446774] sd 10:2:0:0: [sdw] Write Protect is off
[115148.446776] sd 10:2:0:0: [sdw] Mode Sense: 00 3a 00 00
[115148.446788] sd 10:2:0:0: [sdw] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446801] sd 10:3:0:0: [sdx] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446808] sd 10:3:0:0: [sdx] Write Protect is off
[115148.446809] sd 10:3:0:0: [sdx] Mode Sense: 00 3a 00 00
[115148.446822] sd 10:3:0:0: [sdx] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA
[115148.446834] sd 10:4:0:0: [sdy] 1953525168 512-byte hardware  
sectors (1000205 MB)
[115148.446841] sd 10:4:0:0: [sdy] Write Protect is off
[115148.446843] sd 10:4:0:0: [sdy] Mode Sense: 00 3a 00 00
[115148.446855] sd 10:4:0:0: [sdy] Write cache: enabled, read cache:  
enabled, doesn't support DPO or FUA

Thanks,
Tim
