From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [Fedora-ia64-list] The 5th bar of ide controller at legacy mode
Date: Mon, 12 Feb 2007 07:22:04 -0500
Message-ID: <45D05BEC.6030502@redhat.com>
References: <1171244453.15989.389.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50833 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbXBLMWM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Feb 2007 07:22:12 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1CCMAxl011141
	for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2007 07:22:10 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1CCM5oW028312
	for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2007 07:22:05 -0500
In-Reply-To: <1171244453.15989.389.camel@ymzhang>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ia64 Fedora Core Development <fedora-ia64-list@redhat.com>
Cc: linux-ide@vger.kernel.org


Zhang, Yanmin wrote:
> Hi,
>
> I am using Fedora Core 7 Test1 on my ia64 box and run into an issue
> about my cd drive. FC6 works well on my machine, but FC7Test1 couldn't
> recognise the cd drive.
>
>   

Just an FYI for everyone on linux-ide ... F7 (not FC anymore ;) )
maps upstream. I think there is a bit of a delta ATM but it's small.

> I checked it and found FC6 uses ide-cd/piix drivers, while FC7Test1
> replaces them with ata/ata_piix drivers. When drivers call pci_enable_device,
> the calling will fail if the bar resource is incorrect.
>   

ide-cd/piix drivers are going to be deprecated some time in the future.
Fedora has already made the switch to ata/ata_piix in order to test the
"new" driver and catch any potential issues with BIOS, ACPI tables,
etc..
> The bar resource of the ide controller on my tiger machine:
> [root@tigerF 0000:00:1f.1]# pwd
> /sys/devices/pci0000:00/0000:00:1f.1
> [root@tigerF 0000:00:1f.1]# cat resource
> 0x00000000000001f0 0x00000000000001f7 0x0000000000000110
> 0x00000000000003f6 0x00000000000003f6 0x0000000000000110
> 0x0000000000000170 0x0000000000000177 0x0000000000000110
> 0x0000000000000376 0x0000000000000376 0x0000000000000110
> 0x0000000000001000 0x000000000000100f 0x0000000000000101
> 0x0000000000000000 0x00000000000003ff 0x0000000000000200
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
>
> The 5th bar is incorrect. BIOS initiates ide controllers.
>   

Your BIOS is broken.

> So my question is: should ata/ata_piix also need to recall pci_enable_device_bars
> with parameter bars=(1<<4) if pci_enable_device fails like what ide-cd/piix does?
>   

No, ata/ata_piix should not call pci_enable_device, IMO.

You're hitting this issue due to a broken BIOS -- if that BIOS is fixed then
the system would boot properly.

IMO, the kernel cannot take care of EVERY single case of a broken BIOS.

Another better approach is to make a Fedora-only
drivers/pci/quirks.c patch to catch this issue ... but I'm not going to
guarantee its acceptance into the Fedora tree.

P.
