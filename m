From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Fri, 22 Jan 2010 00:31:45 -0500
Message-ID: <4B593841.2030900@garzik.org>
References: <4B591D61.8030003@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:54282 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0AVFbr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jan 2010 00:31:47 -0500
Received: by gxk9 with SMTP id 9so795046gxk.8
        for <linux-ide@vger.kernel.org>; Thu, 21 Jan 2010 21:31:47 -0800 (PST)
In-Reply-To: <4B591D61.8030003@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: infernix <infernix@infernix.net>
Cc: linux-ide@vger.kernel.org

On 01/21/2010 10:37 PM, infernix wrote:
> Hi,
>
> I've got an Intel SS4200(-ESW) here which according to lspci has an
> Intel 82801GB/GR/GH controller. It has 4 sata ports + 1 pata port in
> which i have a 4GB IDE flash DOM. It also has a SIL 3132 for 2 external
> eSATA ports. There are no disks connected to any of the SATA ports.
>
> The bios allows for two modes:
>
> - Compatible mode, which makes the kernel use ata_piix. lspci shows that
> the chipset uses pci id 8086:27c0.
>
> - Enhanced mode (with sub options IDE, RAID or AHCI - using AHCI here),
> which of course makes the kernel use ahci. lspci shows the the chipset
> now uses pci id 8086:27c1.
>
> In compatible mode, the bios can be configured to make the pata
> controller the first and the sata controller the second controller under
> ata_piix. This works and I can boot off the IDE in the PATA DOM without
> issues. The DOM works fine under ata_piix as /dev/sda.
>
> The problem is with the Enhanced mode with the sub mode set to AHCI (or
> IDE for that matter, it didn't change anything). In Enhanced AHCI mode,
> the SATA ports are detected just fine, but the PATA port is not
> detected. As I'm using an IDE DOM as root device, I can't boot in AHCI
> mode.
>
> What's weird though is that if I enable the old IDE PIIX driver, the
> PATA port does get detected and the DOM shows up as /dev/hda. But
> performance is abysmal, and since this is now deprecated we should try
> to get the PATA port working while in Enhanced AHCI mode.
>
> Running in compatible mode is not an option because this allows me to
> chose PATA for controller 0 and SATA for controller 1, but as a
> consequence i lose 2 sata ports as can be seen in the dmesg output. Or I
> could set it to full SATA but then the PATA port is rendered useless.

What PCI device is the PATA port?  Does the pata_marvell driver enable it?

Can you provide full lspci?

	Jeff


