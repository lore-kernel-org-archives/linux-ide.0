From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Mon, 28 Jul 2008 12:02:25 +1000
Message-ID: <1217210545.11188.146.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34314 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbYG1CCe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jul 2008 22:02:34 -0400
In-Reply-To: <1217208596.11188.144.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Mon, 2008-07-28 at 11:29 +1000, Benjamin Herrenschmidt wrote:
> The current ide-pmac upstream is broken. It calls
> media_bay_set_ide_infos() with an uninitialized "hwif" argument.
> 
> It's not a trivial mistake, there's a chicken-and-egg problem in the
> init code in there.
> 
> I've locally fixed it with this patch that i'll merge via the powerpc
> tree unless you have an objection.
> 
> However, the machine crashes when removing the media-bay CD-ROM drive.
> 
> Crash appears to be a NULL deref, possibly in elv_may_queue() though
> I don't have a clean backtrace yet, working on it...

Here's a backtrace:

Vector: 300 (Data Access) at [c58b7b80]
    pc: c014f264: elv_may_queue+0x10/0x44
    lr: c0152750: get_request+0x2c/0x2c0
    sp: c58b7c30
   msr: 1032
   dar: c
 dsisr: 40000000
  current = 0xc58aaae0
    pid   = 854, comm = media-bay
enter ? for help
mon> t
[c58b7c40] c0152750 get_request+0x2c/0x2c0
[c58b7c70] c0152a08 get_request_wait+0x24/0xec
[c58b7cc0] c0225674 ide_cd_queue_pc+0x58/0x1a0
[c58b7d40] c022672c ide_cdrom_packet+0x9c/0xdc
[c58b7d70] c0261810 cdrom_get_disc_info+0x60/0xd0
[c58b7dc0] c026208c cdrom_mrw_exit+0x1c/0x11c
[c58b7e30] c0260f7c unregister_cdrom+0x84/0xe8
[c58b7e50] c022395c ide_cd_release+0x80/0x84
[c58b7e70] c0163650 kref_put+0x54/0x6c
[c58b7e80] c0223884 ide_cd_put+0x40/0x5c
[c58b7ea0] c0211100 generic_ide_remove+0x28/0x3c
[c58b7eb0] c01e9d34 __device_release_driver+0x78/0xb4
[c58b7ec0] c01e9e44 device_release_driver+0x28/0x44
[c58b7ee0] c01e8f7c bus_remove_device+0xac/0xd8
[c58b7f00] c01e7424 device_del+0x104/0x198
[c58b7f20] c01e74d0 device_unregister+0x18/0x30
[c58b7f40] c02121c4 __ide_port_unregister_devices+0x6c/0x88
[c58b7f60] c0212398 ide_port_unregister_devices+0x38/0x80
[c58b7f80] c0208ca4 media_bay_step+0x1cc/0x5c0
[c58b7fb0] c0209124 media_bay_task+0x8c/0xcc
[c58b7fd0] c00485c0 kthread+0x48/0x84
[c58b7ff0] c0011b20 kernel_thread+0x44/0x60


