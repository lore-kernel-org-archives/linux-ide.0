From: Thomas DEBESSE <thomas.debesse+debian@gmail.com>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
 ahci module deactivate hotplug support (regression from lenny)
Date: Tue, 5 Oct 2010 09:45:40 +0200
Message-ID: <AANLkTikVYpaYd4xOeBeWu9aHieJ+P1nTLJ_eoGyXC2K0@mail.gmail.com>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet>
	<1285799230.28504.105.camel@localhost>
	<4CAA04FB.7070402@gmail.com>
	<20101004175438.GZ5947@vostochny.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34170 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0JEHps (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2010 03:45:48 -0400
Received: by wwj40 with SMTP id 40so5252780wwj.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2010 00:45:47 -0700 (PDT)
In-Reply-To: <20101004175438.GZ5947@vostochny.stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: 598518@bugs.debian.org, Ben Hutchings <ben@decadent.org.uk>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

2010/9/30 Ben Hutchings <ben@decadent.org.uk>:
> On Wed, 2010-09-29 at 18:50 +0200, thomas.debesse+debian@gmail.com
> wrote:
> You can force ahci to be loaded first:
> 1. Add the line 'ahci' to /etc/initramfs-tools/modules.
> 2. Run 'update-initramfs -u' to regenerate the initramfs.
> 3. Reboot.

I've tested it, it does'nt change anything.
Nowadays, I blacklist ata_piix

# echo 'blacklist ata_piix' >> /etc/modprobe.d/blacklist.conf
# update-initramfs -k all -u
# reboot

then I manually load ata_piix using modprobe after boot

> But it seems like it would be better if ahci was automatically
> preferred.

Yes, because I'm not the only one using ich6 chipset who want to
upgrade from lenny to squeeze indeed. :)

2010/10/4 maximilian attems <max@stro.at>:
> we do shipp modules.order in initramfs.

It looks like what I'm looking for... a way to force loading of ahci
module before loading of ata_piix module.

> hmm thomas what are your MODULES settings, please post output of
>  egrep MODULES -r /etc/initramfs-tools/
>
> if MODULES=dep appears it could be that the sys walking code has
> a bug in adding the wrong module to the initramfs.
> please change it to the safe and default MODULES=most and regenerate:
> update-initramfs -u -k <kernelversion>
>
> you can check any initramfs if it has the relevant modules with
> lsinitramfs /boot/initrd.img-2.6.35-trunk-amd64 | grep ahci

I'm going to check this !

It can be important to point out that previously quoted lenny lspci
showed me it knows the two modules could be used and experience showed
me it does the good choice.

# diff lspci-lenny lspci-squeeze
16,18c16,17
<       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
<    Kernel driver in use: ahci
<    Kernel modules: ahci, ata_piix
---
>       Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>    Kernel driver in use: ata_piix

Squeeze lspci does'nt have this "Kernel modules" line even though both
modules are loaded.

So, I'm going to check modules.order and /etc/initramfs-tools/ then I
will report here what I can see.

-- 
Thomas DEBESSE
