From: Kenneth Johansson <ken@kenjo.org>
Subject: Annoying DVD and IRQ problem
Date: Thu, 23 Sep 2004 00:28:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1095892123.2779.12.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:17332 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S268072AbUIVWae
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Sep 2004 18:30:34 -0400
Received: from tiger.kenjo.org ([192.168.1.2])
	by garbo.kenjo.org with esmtp (Exim 3.36 #1 (Debian))
	id 1CAFbP-0005Kf-00
	for <linux-ide@vger.kernel.org>; Thu, 23 Sep 2004 00:28:43 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a problem using the DVD drive under kernel 2.6 in all the
versions I tested(up to 2.6.8.1). Since I do not use the dvd that often
it has not been a big problem but now I starting to get tired of it. 

First is there any valid way for the interrupt rate to drop below 1000 ?
This is a sample from vmstat during a copy from the dvd drive.
----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  3      0   3812  21876 591388    0    0  2340 15260  455   230 25 75  0  0
 2  3      0   4700  21844 590828    0    0  1288     0  422   133 17 83  0  0
 2  4      0   4024  21828 592028    0    0  1288   136  233   121 11 89  0  0
 2  1      0   3856  21852 592272    0    0  2712   116  412   232 21 71  0  7
 2  2      0   3820  21876 592236    0    0  2736     0  330   214 17 83  0  0
 3  3      0   3840  20376 592924    0    0  2468     0  495   332 53 47  0  0
 3  3      0   4092  20396 592092    0    0  2612     0  794   257 29 71  0  0
----

The drive should also do a lot better than 2MB/sec it's spec is 8x for
+/-R and 12X DVD-rom 

During use the mouse pointer sometimes get just crazy for a few seconds
it seams like X is getting fake mouse and keyboard events. resulting in
all sort of fun things ranging from the mouse pointer just moving around
to quiting some program.

It's also not possible to watch tv with tvtime at the same time as the
dvd is in use due to to many lost frames. 

0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)

cat /proc/interrupts
           CPU0
  0:    7232433    IO-APIC-edge  timer
  1:      11872    IO-APIC-edge  i8042
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     150886    IO-APIC-edge  i8042
 15:     169584    IO-APIC-edge  ide1
 16:    7325765   IO-APIC-level  eth0, nvidia
 17:     205210   IO-APIC-level  libata
 18:      75514   IO-APIC-level  EMU10K1
 19:       5970   IO-APIC-level  bttv0
 21:         78   IO-APIC-level  uhci_hcd, uhci_hcd
NMI:          0
LOC:    7242394
ERR:          0
MIS:          4



