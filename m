From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: HighPoint 374 ide problems with 2.4-kernels
Date: Sun, 19 Oct 2003 15:24:58 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <48850.192.168.9.10.1066566298.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ncircle.nullnet.fi ([62.236.96.207]:55230 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262118AbTJSMZA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2003 08:25:00 -0400
Received: from ncircle.nullnet.fi (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with SMTP id 9F9421CEC753
	for <linux-ide@vger.kernel.org>; Sun, 19 Oct 2003 15:24:58 +0300 (EEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I thought that perhaps there would be someone here with additional
knowledge related to the HPT374 ide-chip driver problems I've had
for a some time now. Below is a copy from my reply to a fellow
on linux-kernel list which describes a little bit of my current
problem & hardware. I'd really appreciate any ideas how to get
rid of highpoint proprietary drivers in my system.

Do you think my problem could be directly related to Epox motherboard
as I'm kind of confused about the fact that all the Epox-brand mb's
that I know don't work with kernel included drivers but still I've
seen comments on kernel-list that it does work for HPT374 chips
integrated in some other brand mb's ... ?

------------ reply to Carlos Fernandez Sanz" <cfs-lk@nisupu.com> ------

> What's the current status of HPT 374 support? Is it working in any
kernel version?

Unfortunately, in my experience the included kernel driver doesn't work
reliable at all with my hardware either. I have tried all possible kernel
versions up to and including 2.4.23-pre5 without success.

> I know HP provides binaries, but that's no good, I need to use other kernel
> builds.

The Highpoint proprietary drivers work fine in my case as well, but I'm
not too happy about the fact that I simply can't access the
SMART stats of my drivers at all for example.

>
> 2.4.20-8 detects the card and provides the devices but data corruptions
happens all the time. Using the HP drivers everything works fine (note

I have tested the kernel hpt374 drivers with all possible kernel
configurations with and without ACPI/APM, local apic, io-apic and
they don't seem to change anything in my case. I just get the following
error message sooner or later and the whole system hangs.

Sep 26 23:07:42 alderan kernel: blk: queue c0466908, I/O limit 4095Mb
(mask 0xffffffff)
Sep 26 23:07:42 alderan kernel: hde: dma_timer_expiry: dma status == 0x20
Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
Sep 26 23:07:42 alderan kernel: blk: queue c0466d5c, I/O limit 4095Mb
(mask 0xffffffff)
Sep 26 23:07:42 alderan kernel: hdg: dma_timer_expiry: dma status == 0x20
Sep 26 23:07:42 alderan kernel: hdg: timeout waiting for DMA
Sep 26 23:07:42 alderan kernel: hdg: timeout waiting for DMA

It might be that my problems are somehow related to the motherboards I've
been using, as the first one is "Epox 8K9A3+ (Via KT400 chipset)" while
the another one is "Epox 4PCA3+ (Intel 875p chipset)". But they are 100%
reproduceble with multiple brands of disk-drives.
--------------------------------------------------------


Regards,
Tomi Orava


