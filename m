From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: The 5th bar of ide controller at legacy mode
Date: Mon, 12 Feb 2007 09:40:53 +0800
Message-ID: <1171244453.15989.389.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:24410 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932926AbXBLBkx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 20:40:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: fedora-ia64-list <fedora-ia64-list@redhat.com>

Hi,

I am using Fedora Core 7 Test1 on my ia64 box and run into an issue
about my cd drive. FC6 works well on my machine, but FC7Test1 couldn't
recognise the cd drive.

I checked it and found FC6 uses ide-cd/piix drivers, while FC7Test1
replaces them with ata/ata_piix drivers. When drivers call pci_enable_device,
the calling will fail if the bar resource is incorrect.

The bar resource of the ide controller on my tiger machine:
[root@tigerF 0000:00:1f.1]# pwd
/sys/devices/pci0000:00/0000:00:1f.1
[root@tigerF 0000:00:1f.1]# cat resource
0x00000000000001f0 0x00000000000001f7 0x0000000000000110
0x00000000000003f6 0x00000000000003f6 0x0000000000000110
0x0000000000000170 0x0000000000000177 0x0000000000000110
0x0000000000000376 0x0000000000000376 0x0000000000000110
0x0000000000001000 0x000000000000100f 0x0000000000000101
0x0000000000000000 0x00000000000003ff 0x0000000000000200
0x0000000000000000 0x0000000000000000 0x0000000000000000

The 5th bar is incorrect. BIOS initiates ide controllers.

If pci_enable_device fails, ata/ata_piix drivers will report the probe
failure, but ide-cd/piix is smarter to recall pci_enable_device_bars
directly with parameter bars=(1<<4), so only 0~4th bar resources are checked.

Below is a copy of some comments of function ide_pci_enable:

 *      Enable the IDE PCI device. We attempt to enable the device in full
 *      but if that fails then we only need BAR4 so we will enable that.

>From the comments, I expect the bars (other than 4th) of ide controllers
are incorrectly innitiated by BIOS very often.

So my question is: should ata/ata_piix also need to recall pci_enable_device_bars
with parameter bars=(1<<4) if pci_enable_device fails like what ide-cd/piix does?

Yanmin
