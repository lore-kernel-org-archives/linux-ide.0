From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Fri, 22 Jan 2010 19:23:06 -0600
Message-ID: <4B5A4F7A.4040709@gmail.com>
References: <4B591D61.8030003@infernix.net> <4B593128.1040104@gmail.com> <4B59A0CD.4000801@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:63205 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab0AWBXK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jan 2010 20:23:10 -0500
Received: by iwn16 with SMTP id 16so639935iwn.33
        for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2010 17:23:08 -0800 (PST)
In-Reply-To: <4B59A0CD.4000801@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: infernix <infernix@infernix.net>
Cc: linux-ide@vger.kernel.org

On 01/22/2010 06:57 AM, infernix wrote:
> On 22/01/10 06:01, Robert Hancock wrote:
>> If the board has PATA ports driven off the chipset, then in AHCI mode
>> you should get two devices showing up, one AHCI controller for the SATA
>> ports and one IDE controller for the PATA ports which ata_piix should
>> drive. Is that not happening on this board?
>
> This is indeed the problem. In AHCI mode, the PATA port is undetected.
> ata_piix does not handle it at all.
>
>
> On 22/01/10 06:31, Jeff Garzik wrote:
>  > What PCI device is the PATA port? Does the pata_marvell driver enable
> it?
>
> In compatible mode it's /dev/disk/by-path/pci-0000:00:1f.2-scsi-0:0:0:0
> because i configured the bios to use PATA+SATA. This is the ICH7
> controller (according to lspci).
>
> In Enhanced AHCI mode it does not show up at all on lspci. Poking around
> in /sys shows that ide-gd is responsible for discovering hda; without
> CONFIG_IDE, it's not found at all.
>
> The pata_marvell driver is unrelated, it only serves the two external
> eSATA ports, nothing else. You can even see that it's situated close to
> the eSATA ports whereas the Intel ICH7 SATA and PATA ports are on the
> complete opposite side of the board:
> http://ss4200.pbworks.com/f/IMG_2187.jpg

Think you meant the sata_sil24 driver (it's a Silicon Image 3132 chip), 
but yeah, it's unrelated.

>
> Full mobo image here: http://ss4200.pbworks.com/f/CIMG0326.jpg
>
>  > Can you provide full lspci?
>
> Sure, compatible mode:
> http://dx.infernix.net/ss4200/lspci-vv.compatible_mode
>
> Enhanced ahci mode:
> http://dx.infernix.net/ss4200/lspci-vv.enhanced_ahci_mode

 From what I can gather from the ICH7 datasheet, when using AHCI the IDE 
controller is supposed to show up as device 1f.1 and the SATA controller 
as 1f.2. It seems like for some reason your BIOS is disabling the IDE 
controller entirely in that mode, which appears rather wrong.

Do you have the latest BIOS for that board?

The
