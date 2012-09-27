From: Brian Norris <computersforpeace@gmail.com>
Subject: AHCI power down via unbind/rmmod
Date: Thu, 27 Sep 2012 15:29:26 -0700
Message-ID: <CAN8TOE8jSOgv7iMgTOBMX0-DVRd3fdE3SVmc7m5dA5hfEnj_MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52094 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab2I0W31 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2012 18:29:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@sirena.org.uk>, Kevin Cernekee <cernekee@gmail.com>, Brian Norris <computersforpeace@gmail.com>

Hi,

I'm trying to support unbinding an AHCI platform device from the
ahci_platform driver, so that I can put my entire SoC SATA core into a
low power state with no functionality, similar to case 1 here:

  http://article.gmane.org/gmane.linux.power-management.general/27080

The bind/unbind suggestion is here:

  http://article.gmane.org/gmane.linux.power-management.general/27093

Right now, ahci_platform doesn't support unbinding due to its use of
platform_driver_probe(). I have tried patching it to be a typical
module_platform_driver(), including a proper .probe function in the
platform_driver struct. This gives me the unbind sysfs hook I'm
looking for.

However, I'm running into a problem with the AHCI/ATA system. If I
power down my core during the "exit" hook in ahci_remove
(drivers/ata/ahci_platform.c:212), then the ATA subsystem still tries
to perform HW activity via its devres cleanup functions. This
obviously causes a bus error, as my core is powered down. In fact,
this error occurs with either unbind or rmmod - see below.

So: this really comes down to the fact that ATA's devres system is
being used in an unsafe way. Typically, devres is just used for
SW-only cleanup, right? (DMA buffers, memory, etc.?) The suspect line
(libata-core.c:5880):

  start_dr = devres_alloc(ata_host_stop, 0, GFP_KERNEL);

Thanks,
Brian

---

# rmmod ahci_platform.ko
Data bus error, epc == e07c0ca0, ra == e07c0d24
Oops[#1]:
...
Call Trace:
[<e07c0ca0>] ahci_stop_engine+0x28/0x84 [libahci]
[<e07c0d24>] ahci_deinit_port+0x28/0xe8 [libahci]
[<e07c0e08>] ahci_port_stop+0x24/0x64 [libahci]
[<802dcc28>] ata_host_stop+0x5c/0xc0
[<802b5390>] release_nodes+0x144/0x244
[<802b159c>] __device_release_driver+0x68/0xcc
[<802b1fd8>] driver_detach+0xe8/0xf0
[<802b13e0>] bus_remove_driver+0x98/0x128
[<8007b9e4>] sys_delete_module+0x188/0x2d4
[<8000e6fc>] stack_done+0x20/0x40
