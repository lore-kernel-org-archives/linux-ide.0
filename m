From: Graeme Russ <graeme.russ@gmail.com>
Subject: Using PATA Platform Driver to access Memory Mapped CF Card
Date: Sat, 01 May 2010 17:13:47 +1000
Message-ID: <4BDBD4AB.8020200@gmail.com>
References: <4BDAE529.20903@gmail.com> <201005010524.40949.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62098 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0EAHNy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 May 2010 03:13:54 -0400
Received: by pxi17 with SMTP id 17so545692pxi.19
        for <linux-ide@vger.kernel.org>; Sat, 01 May 2010 00:13:53 -0700 (PDT)
In-Reply-To: <201005010524.40949.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a CF slot mapped to a GP bus on a board I'm porting linux to. It is
wired in 8-bit Memory Mode only with only A0 - A3 mapped from the address
bus (starting at 0x20000000). I know the arrangement works as this board is
successfully accessing CF cards using existing proprietary firmware.

I have added some platform specific initialisation to the kernel. I came to
the 0x2000000E by looking at some blackfin examples (particularly
mach-bf537/boards/stamp.c) - I do not know if this is exactly right

static struct pata_platform_info enet_pata_platform_data = {
	.ioport_shift = 0,
};

static struct resource enet_pata_resources[] = {
	{
		.start = 0x20000000,
		.end = 0x20000007,
		.flags = IORESOURCE_MEM,
	},
	{
		.start = 0x2000000E,
		.end = 0x2000000E,
		.flags = IORESOURCE_MEM,
	},
};

static struct platform_device enet_pata_device = {
	.name = "pata_platform",
	.id = -1,
	.num_resources = ARRAY_SIZE(enet_pata_resources),
	.resource = enet_pata_resources,
	.dev = {
		.platform_data = &enet_pata_platform_data,
	}
};

static struct platform_device *enet_devices[] __initdata = {
	&enet_pata_device,
};

static int __init enet_init(void)
{
	printk(KERN_INFO "%s(): registering device resources\n", __func__);
	platform_add_devices(enet_devices, ARRAY_SIZE(enet_devices));
	return 0;
}

arch_initcall(enet_init);

Which results in the following kernel messages (With a 512MB SanDisk Card):
[    0.065999] enet_init(): registering device resources
...
[    1.988931] scsi0 : pata_platform
[    1.996940] ata1: PATA max PIO0 no IRQ, using PIO polling mmio cmd
0x20000000 ctl 0x2000000e
...
[    2.168883] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[    1.995794] ata1.01: NODEV after polling detection
[    2.013803] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
...
[    7.146794] ata1.01: NODEV after polling detection
[    7.164802] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[   12.297794] ata1.01: NODEV after polling detection
[   12.315802] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[   17.448794] ata1.01: NODEV after polling detection

And similar with a 1G UltraII and 4G Extreme III but they do not generate
the NODEV message. With no card inserted I get neither the NODEV nor the
failed to IDENTIFY messages. It looks like something is at least partially
working.

Can anyone tell me how to go about enabling an appropriate level of
debugging options, and what I should be looking out for?

TIA

Graeme
