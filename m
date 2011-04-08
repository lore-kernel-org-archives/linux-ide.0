From: Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Fri, 8 Apr 2011 19:13:24 +0200
Message-ID: <201104081913.25191.morpheus.ibis@gmail.com>
References: <201104071854.10911.morpheus.ibis@gmail.com> <201104081005.37191.morpheus.ibis@gmail.com> <20110408155918.GA3871@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1I0nNicY74Isc0j"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44675 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab1DHRN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 13:13:29 -0400
Received: by fxm17 with SMTP id 17so2465369fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 08 Apr 2011 10:13:28 -0700 (PDT)
In-Reply-To: <20110408155918.GA3871@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

--Boundary-00=_1I0nNicY74Isc0j
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 08 of April 2011 17:59:18 Tejun Heo wrote:
> Hey,
> 
> Can you please do the followings?
> 
> * Post dmesg w/o the patch.
> 
> * Try different combinations of the flags and see which ones are
>   essential.
> 
> Thanks.

Hi

NO_LPM seems to be unnecessary, but as I don't do link PM on my desktop I 
wouldn't drop it (when all other quirky PMPs need it), unless someone else 
with a laptop (or using LPM on desktop) confirms it.

dmesgs attached (ata8 is JMB363, ata6 is ICH10R), filenames are self-expanatory

Pavel Herrmann

--Boundary-00=_1I0nNicY74Isc0j
Content-Type: text/plain;
  charset="UTF-8";
  name="pmp_ata6_no_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmp_ata6_no_patch"

[    1.228883] ata6: SATA max UDMA/133 abar m2048@0xf7cfc000 port 0xf7cfc380 irq 70
[    5.659250] ata6: SATA link down (SStatus 0 SControl 300)
[  116.532810] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
[  116.532814] ata6: irq_stat 0x00400040, connection status changed
[  116.532819] ata6: hard resetting link
[  117.425467] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  117.425790] ata6.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0
[  117.425793] ata6.15: Asynchronous notification not supported, hotplug won't
[  117.426805] ata6.00: hard resetting link
[  117.917853] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  117.917895] ata6.01: hard resetting link
[  117.925268] ata6.01: failed to read SCR 2 (Emask=0x40)
[  117.925271] ata6.01: COMRESET failed (errno=-5)
[  117.925273] ata6.01: failed to read SCR 0 (Emask=0x40)
[  117.925275] ata6.01: reset failed, giving up
[  117.925279] ata6.15: hard resetting link
[  118.417107] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  122.915605] ata6.00: hard resetting link
[  123.407724] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  123.407766] ata6.01: hard resetting link
[  123.415412] ata6.01: failed to read SCR 2 (Emask=0x40)
[  123.415415] ata6.01: COMRESET failed (errno=-5)
[  123.415418] ata6.01: failed to read SCR 0 (Emask=0x40)
[  123.415420] ata6.01: reset failed, giving up
[  123.415423] ata6.15: hard resetting link
[  123.907274] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  128.405776] ata6.00: hard resetting link
[  128.898131] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  128.898173] ata6.01: hard resetting link
[  128.905558] ata6.01: failed to read SCR 2 (Emask=0x40)
[  128.905561] ata6.01: COMRESET failed (errno=-5)
[  128.905563] ata6.01: failed to read SCR 0 (Emask=0x40)
[  128.905565] ata6.01: reset failed, giving up
[  128.905567] ata6.01: failed to recover link after 3 tries, disabling
[  128.905571] ata6.15: hard resetting link
[  129.397396] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  129.717399] ata6.01: failed to read SCR 0 (Emask=0x100)
[  129.717402] ata6.01: failed to write SCR 1 (Emask=0x40)
[  129.717405] ata6.01: failed to clear SError.N (errno=-5)
[  129.717408] ata6.15: hard resetting link
[  130.209125] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  130.529123] ata6.01: failed to read SCR 0 (Emask=0x100)
[  130.529127] ata6.01: failed to write SCR 1 (Emask=0x40)
[  130.529129] ata6.01: failed to clear SError.N (errno=-5)
[  130.529132] ata6.15: hard resetting link
[  131.020901] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  131.341005] ata6.01: failed to write SCR 1 (Emask=0x100)
[  131.341008] ata6.01: COMRESET failed (errno=-5)
[  131.341011] ata6.01: failed to write SCR 1 (Emask=0x40)
[  131.341013] ata6.01: failed to clear SError.N (errno=-5)
[  131.341016] ata6.15: hard resetting link
[  131.832599] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  132.152732] ata6.01: failed to write SCR 1 (Emask=0x100)
[  132.152735] ata6.01: COMRESET failed (errno=-5)
[  132.152738] ata6.01: failed to write SCR 1 (Emask=0x40)
[  132.152740] ata6.01: failed to clear SError.N (errno=-5)
[  132.152742] ata6: failed to recover PMP after 5 tries, giving up
[  132.152744] ata6.15: Port Multiplier detaching
[  132.152773] ata6.00: disabled
[  132.152781] ata6: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x6 frozen t4
[  132.152783] ata6: irq_stat 0x00800001, incorrect PMP
[  132.152787] ata6: hard resetting link
[  132.644353] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  132.644362] ata6: EH complete

--Boundary-00=_1I0nNicY74Isc0j
Content-Type: text/plain;
  charset="UTF-8";
  name="pmp_ata8_no_ASSUME_ATA"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmp_ata8_no_ASSUME_ATA"

[    1.225913] ata8: SATA max UDMA/133 abar m8192@0xfbbfe000 port 0xfbbfe180 irq 16
[    1.720762] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.721527] ata8.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0
[    1.721736] ata8.15: Asynchronous notification not supported, hotplug won't
[    1.724861] ata8.00: hard resetting link
[    1.736581] ata8.00: failed to read SCR 2 (Emask=0x40)
[    1.736710] ata8.00: COMRESET failed (errno=-5)
[    1.736835] ata8.00: failed to read SCR 0 (Emask=0x40)
[    1.736960] ata8.00: reset failed, giving up
[    1.737085] ata8.15: hard resetting link
[    2.232427] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.722894] ata8.00: hard resetting link
[    7.043180] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    7.043353] ata8.00: link online but device misclassifed
[    7.043355] ata8.00: link online but 1 devices misclassified, retrying
[    7.043528] ata8.00: reset failed (errno=-11), retrying in 10 secs
[   16.719519] ata8.00: hard resetting link
[   17.040278] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   17.040454] ata8.00: link online but device misclassifed
[   17.040456] ata8.00: link online but 1 devices misclassified, retrying
[   17.040630] ata8.00: reset failed (errno=-11), retrying in 10 secs
[   26.716136] ata8.00: hard resetting link
[   30.035033] ata8.15: qc timeout (cmd 0xe4)
[   30.035169] ata8.00: failed to read SCR 0 (Emask=0x4)
[   30.035295] ata8.00: SATA link down (SStatus 123 SControl 320)
[   30.035425] ata8.00: failed to read SCR 0 (Emask=0x40)
[   30.035551] ata8.00: failed to read SCR 0 (Emask=0x40)
[   30.035676] ata8.00: link status unknown, clearing UNKNOWN to NONE
[   30.035680] ata8.01: hard resetting link
[   30.035802] ata8.01: failed to read SCR 2 (Emask=0x40)
[   30.035928] ata8.01: failed to read SCR 2 (Emask=0x40)
[   30.036054] ata8.01: COMRESET failed (errno=-5)
[   30.036178] ata8.01: failed to read SCR 0 (Emask=0x40)
[   30.036304] ata8.01: reset failed, giving up
[   30.036427] ata8.15: hard resetting link
[   30.694806] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   35.033338] ata8.01: hard resetting link
[   35.353611] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   35.353785] ata8.01: link online but device misclassifed
[   35.353788] ata8.01: link online but 1 devices misclassified, retrying
[   35.353960] ata8.01: reset failed (errno=-11), retrying in 10 secs
[   45.029918] ata8.01: hard resetting link
[   45.350675] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   45.350851] ata8.01: link online but device misclassifed
[   45.350854] ata8.01: link online but 1 devices misclassified, retrying
[   45.351027] ata8.01: reset failed (errno=-11), retrying in 10 secs
[   55.026566] ata8.01: hard resetting link
[   55.347265] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   55.347441] ata8.01: link online but device misclassifed
[   55.347444] ata8.01: link online but 1 devices misclassified, retrying
[   55.347617] ata8.01: reset failed (errno=-11), retrying in 35 secs
[   90.014841] ata8.01: limiting SATA link speed to 1.5 Gbps
[   90.014970] ata8.01: hard resetting link
[   90.335037] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   90.335210] ata8.01: link online but device misclassifed
[   90.335213] ata8.01: link online but 1 devices misclassified, device detection might fail
[   90.335468] ata8: EH complete


--Boundary-00=_1I0nNicY74Isc0j
Content-Type: text/plain;
  charset="UTF-8";
  name="pmp_ata8_no_NO_LPM"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmp_ata8_no_NO_LPM"

[    1.237343] ata8: SATA max UDMA/133 abar m8192@0xfbbfe000 port 0xfbbfe180 irq 16
[    1.728096] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.728627] ata8.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0
[    1.728834] ata8.15: Asynchronous notification not supported, hotplug won't
[    1.730504] ata8.00: hard resetting link
[    1.740080] ata8.00: failed to read SCR 2 (Emask=0x40)
[    1.740209] ata8.00: COMRESET failed (errno=-5)
[    1.740331] ata8.00: failed to read SCR 0 (Emask=0x40)
[    1.740454] ata8.00: reset failed, giving up
[    1.740576] ata8.15: hard resetting link
[    2.231929] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.726329] ata8.00: hard resetting link
[    9.961235] ata8.15: qc timeout (cmd 0xe4)
[    9.961370] ata8.00: failed to read SCR 0 (Emask=0x4)
[    9.961496] ata8.00: COMRESET failed (errno=-5)
[    9.961620] ata8.00: failed to read SCR 0 (Emask=0x40)
[    9.961747] ata8.00: reset failed, giving up
[    9.961871] ata8.15: hard resetting link
[   10.509064] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   11.724586] ata8.00: hard resetting link
[   12.045405] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   12.045583] ata8.01: hard resetting link
[   12.365303] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   12.384258] ata8.00: ATA-8: WDC WD10EAVS-00D7B1, 01.01A01, max UDMA/133
[   12.384398] ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   12.385475] ata8.00: configured for UDMA/133
[   12.722839] ata8.01: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
[   12.722972] ata8.01: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   12.726652] ata8.01: configured for UDMA/133
[   12.726886] ata8: EH complete


--Boundary-00=_1I0nNicY74Isc0j
Content-Type: text/plain;
  charset="UTF-8";
  name="pmp_ata8_no_NO_SRST"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmp_ata8_no_NO_SRST"

[    1.234190] ata8: SATA max UDMA/133 abar m8192@0xfbbfe000 port 0xfbbfe180 irq 16
[    1.728869] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.729462] ata8.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0
[    1.729671] ata8.15: Asynchronous notification not supported, hotplug won't
[    1.731173] ata8.00: hard resetting link
[    2.225408] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    2.225587] ata8.01: hard resetting link
[    2.232638] ata8.01: failed to read SCR 2 (Emask=0x40)
[    2.232763] ata8.01: COMRESET failed (errno=-5)
[    2.232885] ata8.01: failed to read SCR 0 (Emask=0x40)
[    2.233008] ata8.01: reset failed, giving up
[    2.233129] ata8.15: hard resetting link
[    2.724606] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.223025] ata8.00: hard resetting link
[    7.715089] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    7.715264] ata8.01: hard resetting link
[    7.722779] ata8.01: failed to read SCR 2 (Emask=0x40)
[    7.722906] ata8.01: COMRESET failed (errno=-5)
[    7.723030] ata8.01: failed to read SCR 0 (Emask=0x40)
[    7.723156] ata8.01: reset failed, giving up
[    7.723280] ata8.15: hard resetting link
[    8.214682] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   12.713146] ata8.00: hard resetting link
[   13.205235] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   13.205411] ata8.01: hard resetting link
[   13.212920] ata8.01: failed to read SCR 2 (Emask=0x40)
[   13.213046] ata8.01: COMRESET failed (errno=-5)
[   13.213170] ata8.01: failed to read SCR 0 (Emask=0x40)
[   13.213296] ata8.01: reset failed, giving up
[   13.213419] ata8.01: failed to recover link after 3 tries, disabling
[   13.213548] ata8.15: hard resetting link
[   13.704771] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   18.203293] ata8.00: hard resetting link
[   18.695379] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   18.704380] ata8.00: ATA-8: WDC WD10EAVS-00D7B1, 01.01A01, max UDMA/133
[   18.704512] ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   18.705595] ata8.00: configured for UDMA/133
[   18.705765] ata8: EH complete

--Boundary-00=_1I0nNicY74Isc0j
Content-Type: text/plain;
  charset="UTF-8";
  name="pmp_ata8_no_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmp_ata8_no_patch"

[    1.245918] ata8: SATA max UDMA/133 abar m8192@0xfbbfe000 port 0xfbbfe180 irq 16
[    1.736595] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.737173] ata8.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0
[    1.737381] ata8.15: Asynchronous notification not supported, hotplug won't
[    1.738946] ata8.00: hard resetting link
[    1.748673] ata8.00: failed to read SCR 2 (Emask=0x40)
[    1.748805] ata8.00: COMRESET failed (errno=-5)
[    1.748927] ata8.00: failed to read SCR 0 (Emask=0x40)
[    1.749050] ata8.00: reset failed, giving up
[    1.749172] ata8.15: hard resetting link
[    2.240433] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.734885] ata8.00: hard resetting link
[    7.226986] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    7.227162] ata8.01: hard resetting link
[    7.234675] ata8.01: failed to read SCR 2 (Emask=0x40)
[    7.234801] ata8.01: COMRESET failed (errno=-5)
[    7.234926] ata8.01: failed to read SCR 0 (Emask=0x40)
[    7.235051] ata8.01: reset failed, giving up
[    7.235175] ata8.15: hard resetting link
[    7.726522] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   12.225041] ata8.00: hard resetting link
[   12.717590] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   12.717767] ata8.01: hard resetting link
[   12.724822] ata8.01: failed to read SCR 2 (Emask=0x40)
[   12.724948] ata8.01: COMRESET failed (errno=-5)
[   12.725073] ata8.01: failed to read SCR 0 (Emask=0x40)
[   12.725199] ata8.01: reset failed, giving up
[   12.725322] ata8.15: hard resetting link
[   13.216669] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   17.715187] ata8.00: hard resetting link
[   18.207273] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   18.207449] ata8.01: hard resetting link
[   18.214961] ata8.01: failed to read SCR 2 (Emask=0x40)
[   18.215087] ata8.01: COMRESET failed (errno=-5)
[   18.215211] ata8.01: failed to read SCR 0 (Emask=0x40)
[   18.215337] ata8.01: reset failed, giving up
[   18.215460] ata8.01: failed to recover link after 3 tries, disabling
[   18.215590] ata8.15: hard resetting link
[   18.706812] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   23.205337] ata8.00: hard resetting link
[   23.697419] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   23.698413] ata8.00: ATA-8: WDC WD10EAVS-00D7B1, 01.01A01, max UDMA/133
[   23.698544] ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   23.699593] ata8.00: configured for UDMA/133
[   23.699765] ata8: EH complete

--Boundary-00=_1I0nNicY74Isc0j--
