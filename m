From: Justin Fletcher <gerph@gerph.org>
Subject: Problems with >3 drives on an eSATA portmultiplier
Date: Wed, 1 Apr 2009 14:54:55 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:50217 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759478AbZDANzB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 09:55:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by buttercup.gerph.org (Postfix) with ESMTP id 15C454BBDA
	for <linux-ide@vger.kernel.org>; Wed,  1 Apr 2009 14:54:55 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hiya,

I've been having problems recently with my external eSATA drives failing 
to be recognised when there are more than 3 plugged in at one time.

Summary of problem:

When one drive is connected in the external box, everything is fine.

When two are connected, everything is fine.

When three are connected, it can sometimes take a while for them all to 
be detected and mounted.

When four are connected, it almost never detects them properly or mounts 
them. Occassionally I get all 4 mounted, and rarely I get just 1 or 2 of 
the drives mounted.

When five are connected, it's not mounting the drives.


More details:

The kernel I'm using now is 2.6.29 with no patches applied.

The system I'm using is a MSI motherboard, with a SiI eSATA controller 
(a 3132, specifically this 
one: http://www.span.com/catalog/product_info.php?products_id=15995 ) 
connected though the only PCI express card on the MB.

The bridgeboard in my external box is a NA910C, with a SiI3726 onboard 
(specifically this 
one: http://www.span.com/catalog/product_info.php?products_id=15709 ).

The method of disconnecting the drives is to remove the SATA cable from 
the bridge board.

The eSATA cable has been replaced with another one (both 1M long) and 
this has had no effect.

All the drives in the external box are Western Digital. 3 are 500G 
drives, 2 are 1T 'Green Power' drives.

Once detected, the drives are mounted (and subsequently unmounted) by 
udev rules.


History:

The full 5 drives were working and being mounted correctly in the past. 
However, due to many upgrades and confusing hardware problems at the 
same time, trying to identify when that was has become a problem for me 
- I can't say when it was working. When it was working I had a JMB362 
PCIexpress card (specifically this one: 
http://www.span.com/catalog/product_info.php?products_id=16361 ). This 
has been replaced by the SiI card in order to determine if the card is a 
problem; the problems persist and have the same symptoms. (should it be 
necessary for diagnosis, I can put the JMB362 card back). I can say for 
certain that the failures I'm seeing have happened at least on kernels 
2.6.28.3, 2.6.28.4 and 2.6.29.

During testing combinations of drives have been changed, and the bridge 
board ports that they are plugged in to. This has not appeared to make 
any difference - the factor in this equation is the number of drives 
that are connected.


Typical failure:

A typical reads something like this (taken from kern.log from messages 
collected during initialisation):

Apr  1 11:43:23 buttercup kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.02: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to write SCR 1 (Emask=0x1)
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.03: hardreset failed (port not ready)
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1: controller in dubious state, performing PORT_RST
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.02: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.03: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to write SCR 2 (Emask=0x1)
Apr  1 11:43:23 buttercup kernel: ata1.03: COMRESET failed (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1: controller in dubious state, performing PORT_RST
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.02: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.03: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 2 (Emask=0x1)
Apr  1 11:43:23 buttercup kernel: ata1.03: COMRESET failed (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to recover link after 3 tries, disabling
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1: controller in dubious state, performing PORT_RST

... and so on until it tries detaching the port multiplier ...

Apr  1 11:43:23 buttercup kernel: ata1: controller in dubious state, performing PORT_RST
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: failed to read SCR 2 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.01: COMRESET failed (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1.01: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.01: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.01: failed to recover link after 3 tries, disabling
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.04: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.04: COMRESET failed (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1.04: failed to write SCR 1 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.04: failed to clear SError.N (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1: failed to recover PMP after 5 tries, giving up
Apr  1 11:43:23 buttercup kernel: ata1.15: Port Multiplier detaching
Apr  1 11:43:23 buttercup kernel: ata1.00: disabled
Apr  1 11:43:23 buttercup kernel: ata1: exception Emask 0x13 SAct 0x0 SErr 0x40d0000 action 0xe frozen t4
Apr  1 11:43:23 buttercup kernel: ata1: irq_stat 0x01100010, PHY RDY changed
Apr  1 11:43:23 buttercup kernel: ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
Apr  1 11:43:23 buttercup kernel: ata1: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.02: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.03: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: COMRESET failed (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.02: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 (Emask=0x1)
Apr  1 11:43:23 buttercup kernel: ata1.02: COMRESET failed (errno=-5)
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.02: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.02: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 (Emask=0x1)
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to read SCR 1 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.02: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.03: hardreset failed (port not ready)
Apr  1 11:43:23 buttercup kernel: ata1.03: failed to read SCR 0 (Emask=0x40)
Apr  1 11:43:23 buttercup kernel: ata1.03: reset failed, giving up
Apr  1 11:43:23 buttercup kernel: ata1.15: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1: controller in dubious state, performing PORT_RST

... and the sequence repeats until it gets fed up ...

Apr  1 11:43:23 buttercup kernel: ata1: controller in dubious state, performing PORT_RST
Apr  1 11:43:23 buttercup kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.01: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.01: SATA link down (SStatus 221 SControl 300)
Apr  1 11:43:23 buttercup kernel: ata1.05: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.00: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max UDMA/133
Apr  1 11:43:23 buttercup kernel: ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Apr  1 11:43:23 buttercup kernel: ata1.00: configured for UDMA/100
Apr  1 11:43:23 buttercup kernel: ata1.04: PHY status changed but maxed out on retries, giving up
Apr  1 11:43:23 buttercup kernel: ata1.04: Manully issue scan to resume this link
Apr  1 11:43:23 buttercup kernel: ata1: PMP SError.N set for some ports, repeating recovery
Apr  1 11:43:23 buttercup kernel: ata1.00: hard resetting link
Apr  1 11:43:23 buttercup kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Apr  1 11:43:23 buttercup kernel: ata1.00: configured for UDMA/100
Apr  1 11:43:23 buttercup kernel: ata1: EH pending after 5 tries, giving up
Apr  1 11:43:23 buttercup kernel: ata1: EH complete


As can be seen, it got as far as identifying one of the drives in this 
configuration on the final attempt, but the other 3 were not detected 
properly.


My gut feeling:

There's some timing problem involved here - either the drives are being 
sent commands when they're not ready, or they're being timed out before 
they have a chance to respond after a reset. As the problem gets worse 
(to the point of always failing) with more drives, I'm thinking of some 
overall timeout that's being triggered but the individual drives are 
getting less and less time to handle it. For example, drive 1 reset at 
1s, drive 2 reset at 2s, drive 3 reset at 3s, etc, but an overall 
timeout of 8s, so by the time that drive 5 has been reset, it only has 
3s to respond and its initialisation takes longer than that so it never 
does). Not knowing what is involved here, this may be complete rubbish 
and is purely guesswork on my part.


More details from kernel logs:

Because I'm not sure what's useful, and I wanted to capture some timings 
for the sequences of events, I've captured kernel logs of the a number 
of drive combinations. In each case the PC was turned off, the box was 
turned off, the SATA leads were connected as required for the test, then 
the box turned on, a few seconds waited for the box to settle, then the 
PC turned on. The system booted into 2.6.29 and then waited until it had 
settled to a login prompt. At this point, the drive box was turned off. 
The system then shut down whatever drives it had detected after 
determining that the PMP had gone away. The drive box was then turned on 
again. This second initialisation of the box should ensure that there 
are timings present in the kernel logs which determine how long it was 
between events.

The numbering of the logs indicates which drives were connected - these 
are drives numbers from 1-5, not the numbers used in the log messages 
which are 0-4 (it just makes more sense for me to think of them as 
drives 1-5 not 0-4).

Drives 1-3 are 500G, drives 4-5 are 1T.

In the logs it can also be seen that there are two ATA drives connected 
to the MB, and two SATA drives connected to the MB. Neither of these 
appear to exhibit any other problems.

The logs can be found at:

http://usenet.gerph.org/SATA/


sata-15-kern.log:
    2 drives connected.
    All detected during initialisation.
    All detected on restarting box.

sata-45-kern.log:
    2 drives connected.
    All detected during initialisation.
    All detected on restarting box, although it reset the port 3 times.

sata-125-kern.log:
    3 drives connected.
    All detected during initialisation, but after doing so it then tried
    to re-detect later (which was successful)
    All detected on restarting box, although it reset the port 2 times
    and had SCSI errors reported which it recovered from.

sata-345-kern.log:
    3 drives connected.
    1 detected during initialisation, only drive 4 was initialised
    properly; during init 3 had been IDENTIFYd but the port was then
    reset and more attempts made.
    All detected on restarting box, although it reset the port 2 times
    and had other errors reported which it recovered from.

sata-1235-kern.log:
    4 drives connected.
    1 detected during initialisation (drive 1), many attempts made.
    None detected on restarting box, although it retried many times.

sata-12345-kern.log:
    5 drives connected.
    None detected during initialisation, many attempts made.
    Ineffective - no output when the external box was turned off, nor
    when it was turned on.


Finally:

I can provide more information, more combinations and try different 
kernel configurations if it's found to be useful for this. I'm sorry if 
this information is too verbose, or if I've missed something out - 
please let me know and I'll try to do tests or fill in the blanks.


Hope someone can help with this!


-- 
Gerph <http://gerph.org/>
[ All information, speculation, opinion or data within, or attached to,
   this email is private and confidential. Such content may not be
   disclosed to third parties, or a public forum, without explicit
   permission being granted. ]
