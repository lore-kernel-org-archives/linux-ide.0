From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Subject: Re: How to determine the information about SATA controller
Date: Sat, 11 Sep 2010 18:05:23 +0530
Message-ID: <AANLkTinQVQsjxJLpZQiP5V56o7quGPY6G0ZOnvwPAKbx@mail.gmail.com>
References: <AANLkTimMxQXxC354V=qVOrdUYFSrpJ-RZeKJfQEx0KPN@mail.gmail.com>
	<19595.23873.90306.656565@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57887 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0IKMfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Sep 2010 08:35:24 -0400
In-Reply-To: <19595.23873.90306.656565@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello,

On Sat, Sep 11, 2010 at 4:13 PM, Mikael Pettersson <mikpe@it.uu.se> wro=
te:
> Jaswinder Singh Rajput writes:
> =A0> Hello,
> =A0>
> =A0> My old IDE hard disk is broken so I installed new SATA drive on =
my box with F13:
> =A0>
> =A0> dmesg :
> =A0> http://userweb.kernel.org/~jaswinder/P4_HT/dmesg_2633_fc13.txt
> =A0>
> =A0> lsmod:
> =A0> http://userweb.kernel.org/~jaswinder/P4_HT/lsmod_2633_fc13.txt
> =A0>
> =A0> lspci:
> =A0> 00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
> =A0> Controller/Host-Hub Interface (rev 02)
> =A0> 00:02.0 VGA compatible controller: Intel Corporation 82865G Inte=
grated
> =A0> Graphics Controller (rev 02)
> =A0> 00:06.0 System peripheral: Intel Corporation 82865G/PE/P Process=
or to
> =A0> I/O Memory Interface (rev 02)
> =A0> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
> =A0> 00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LP=
C
> =A0> Interface Bridge (rev 02)
> =A0> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R)=
 IDE
> =A0> Controller (rev 02)
> =A0> 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Con=
troller (rev 02)
> =A0>
> =A0> I am trying to build the kernel with this config:
> =A0> http://userweb.kernel.org/~jaswinder/P4_HT/config-ht-test.txt
> =A0>
> =A0> But I am getting error :
> =A0>
> =A0> No root device found.
> =A0> Boot has failed, sleeping forever
> =A0>
> =A0> I am trying to determine the information about the SATA controll=
er so
> =A0> that I can choose the appropriate controller for SATA in kernel
> =A0> config. I am not able to figure out the SATA information from ab=
ove
> =A0> dmesg and lsmod. How can I do so.
>
> In your working dmesg the disks are controlled by ata_piix,
> but you've disabled CONFIG_ATA_PIIX in the config you're trying.
> So it's not surprising that you can't boot.
>
> 1) re-enable CONFIG_ATA_PIIX and disable CONFIG_IDE

I have enabled CONFIG_ATA_PIIX
and disabled CONFIG_IDE

but still getting same error :

No root device found.
Boot has failed, sleeping forever

Am I missing some more options.

> or
> 2) go into the bios and change the option that says whether to run
> =A0 the ATA controller in legacy/compatible mode or enhanced/ahci mod=
e,
> =A0 you want ahci mode
>

In my case, BIOS options are enhanced / legacy / disabled. I tried all
but of no use. So I am using enhanced to boot Fedora 13 kernel.

Thanks,
--
Jawinder Singh.
