From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Wed, 30 Jul 2008 16:57:32 +1000
Message-ID: <1217401052.11188.318.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <200807291404.46906.bzolnier@gmail.com>
	 <200807291645.03382.bzolnier@gmail.com>
	 <200807292126.12238.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51899 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYG3G5q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jul 2008 02:57:46 -0400
In-Reply-To: <200807292126.12238.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Tue, 2008-07-29 at 21:26 +0200, Bartlomiej Zolnierkiewicz wrote:

> I WON!!!

Only half...

It goes further and then blows up again. First problem is, this
unregister interface doesn't quite convey the fact that the HW is gone
and the IDE code seems to take it's sweet time figuring it out after
trying some requests. Maybe something smarter can be done here ? ie,
ide_set_interface_dead() :-)

mediabay0: switching to 7
mediabay0: powering down
media bay 0 is empty
hdc: status error: status=0x00 { }
ide: failed opcode was: unknown
hdc: status error: status=0x00 { }
ide: failed opcode was: unknown

Then after this couple of failed attempts at sending commands, it
crashes with the backtrace below. Another NULL dereference apparently,
though the DAR value (the faulting address) has been slightly different
between consecutive tests so it may be a use-after-free too.

Note that there shouldn't be anything fundamentally different from
ide-pmac here vs. something like pcmcia IDE cards... do you have one of
these to test with ?

Vector: 300 (Data Access) at [c59dfdc0]
    pc: c0211f78: ide_device_put+0x18/0x58
    lr: c0223c34: ide_cd_put+0x40/0x5c
    sp: c59dfe70
   msr: 9032
   dar: 10
 dsisr: 40000000
  current = 0xc58a9880
    pid   = 843, comm = media-bay
enter ? for help
[c59dfe80] c0223c34 ide_cd_put+0x40/0x5c
[c59dfea0] c02114d4 generic_ide_remove+0x28/0x3c
[c59dfeb0] c01ea108 __device_release_driver+0x78/0xb4
[c59dfec0] c01ea218 device_release_driver+0x28/0x44
[c59dfee0] c01e9350 bus_remove_device+0xac/0xd8
[c59dff00] c01e77f8 device_del+0x104/0x198
[c59dff20] c01e78a4 device_unregister+0x18/0x30
[c59dff40] c0212598 __ide_port_unregister_devices+0x6c/0x88
[c59dff60] c021276c ide_port_unregister_devices+0x38/0x80
[c59dff80] c0209078 media_bay_step+0x1cc/0x5c0
[c59dffb0] c02094f8 media_bay_task+0x8c/0xcc
[c59dffd0] c0048640 kthread+0x48/0x84
[c59dfff0] c0011b38 kernel_thread+0x44/0x60


