From: Thomas DEBESSE <thomas.debesse+debian@gmail.com>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
 ahci module deactivate hotplug support (regression from lenny)
Date: Wed, 6 Oct 2010 19:04:48 +0200
Message-ID: <AANLkTimUEpq1V=eSammBk9M0GHVRjZgfSBCjXQ36o95_@mail.gmail.com>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet>
	<1285799230.28504.105.camel@localhost>
	<4CAA04FB.7070402@gmail.com>
	<20101004175438.GZ5947@vostochny.stro.at>
	<AANLkTikVYpaYd4xOeBeWu9aHieJ+P1nTLJ_eoGyXC2K0@mail.gmail.com>
	<20101005090522.GA5947@vostochny.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36261 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759167Ab0JFREt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Oct 2010 13:04:49 -0400
Received: by wwj40 with SMTP id 40so7399962wwj.1
        for <linux-ide@vger.kernel.org>; Wed, 06 Oct 2010 10:04:48 -0700 (PDT)
In-Reply-To: <20101005090522.GA5947@vostochny.stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: 598518@bugs.debian.org, Ben Hutchings <ben@decadent.org.uk>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

2010/10/4 maximilian attems <max@stro.at>:
> we do shipp modules.order in initramfs.

> hmm thomas what are your MODULES settings, please post output of
> =C2=A0egrep MODULES -r /etc/initramfs-tools/

> you can check any initramfs if it has the relevant modules with
> lsinitramfs /boot/initrd.img-2.6.35-trunk-amd64 | grep ahci

2010/10/5 maximilian attems <max@stro.at>:
> please also report which initramfs-tools version you are using,
> since lenny there had been ton of fixes:
> dpkg -l initramfs-tools
>
> you should be running 0.98.4

Somes checks, playing with system configuration,

On Lenny:

# egrep MODULES -r /etc/initramfs-tools/
/etc/initramfs-tools/initramfs.conf:# MODULES: [ most | netboot | dep |=
 list ]
/etc/initramfs-tools/initramfs.conf:MODULES=3Dmost

# lspci -vv -s 00:1f.2 | grep Kernel
	Kernel driver in use: ahci
	Kernel modules: ahci, ata_piix

# dpkg -l initramfs-tools | grep ^ii
ii  initramfs-tools                   0.92o                      tools
for generating an initramfs

# find / -iname "modules.order"

On Squeeze :

# egrep MODULES -r /etc/initramfs-tools/
/etc/initramfs-tools/initramfs.conf:# MODULES: [ most | netboot | dep |=
 list ]
/etc/initramfs-tools/initramfs.conf:MODULES=3Dmost

# lspci -vv -s 00:1f.2 | grep Kernel
	Kernel driver in use: ata_piix

# dpkg -l initramfs-tools | grep ^ii
ii  initramfs-tools                   0.98.4
tools for generating an initramfs

# find / -iname "modules.order"

Nothing seems to be interesting here.

Playing with initrd,

On Lenny :

# lsinitramfs initrd.img-2.6.26-2-686 | grep 'ahci\|ata_piix'
lib/modules/2.6.26-2-686/kernel/drivers/ata/ahci.ko
lib/modules/2.6.26-2-686/kernel/drivers/ata/ata_piix.ko

# gunzip < initrd.img-2.6.26-2-686 | cpio -i --make-directories
# find . -iname '*module*'
=2E/conf/modules
=2E/lib/modules

On Squeeze (unmodified):

# lsinitramfs initrd.img-2.6.32-5-686 | grep 'ahci\|ata_piix'
lib/modules/2.6.32-5-686/kernel/drivers/ata/ahci.ko
lib/modules/2.6.32-5-686/kernel/drivers/ata/ata_piix.ko

# gunzip < initrd.img-2.6.32-5-686 | cpio -i --make-directories
# find . -iname '*module*'
=2E/conf/modules
=2E/lib/modules
=2E/lib/modules/2.6.32-5-686/modules.symbols
=2E/lib/modules/2.6.32-5-686/modules.dep
=2E/lib/modules/2.6.32-5-686/modules.alias.bin
=2E/lib/modules/2.6.32-5-686/modules.symbols.bin
=2E/lib/modules/2.6.32-5-686/modules.alias
=2E/lib/modules/2.6.32-5-686/modules.devname
=2E/lib/modules/2.6.32-5-686/modules.dep.bin
=2E/lib/modules/2.6.32-5-686/modules.softdep

On Squeeze (modified, with blacklist ata_piix):

# lsinitramfs initrd.img-2.6.32-5-686 | grep 'ahci\|ata_piix'
lib/modules/2.6.32-5-686/kernel/drivers/ata/ahci.ko
lib/modules/2.6.32-5-686/kernel/drivers/ata/ata_piix.ko

# gunzip < initrd.img-2.6.32-5-686 | cpio -i --make-directories
# find . -iname '*module*'
=2E/conf/modules
=2E/lib/modules
=2E/lib/modules/2.6.32-5-686/modules.symbols
=2E/lib/modules/2.6.32-5-686/modules.dep
=2E/lib/modules/2.6.32-5-686/modules.alias.bin
=2E/lib/modules/2.6.32-5-686/modules.symbols.bin
=2E/lib/modules/2.6.32-5-686/modules.alias
=2E/lib/modules/2.6.32-5-686/modules.devname
=2E/lib/modules/2.6.32-5-686/modules.dep.bin
=2E/lib/modules/2.6.32-5-686/modules.softdep

Comparing file 'conf/module' which is common to Lenny and Squeeze

# diff lenny/conf/modules squeeze-unmodified/conf/modules
# diff squeeze-unmodified/conf/modules squeeze-blacklist/conf/modules

Comparing somes Squeeze modified and unmodified initrds contents :

# for i in modules.symbols \
           modules.dep \
           modules.alias.bin \
           modules.symbols.bin \
           modules.alias \
           modules.devname \
           modules.dep.bin \
           modules.softdep
do diff squeeze-unmodified/lib/modules/2.6.32-5-686/$i \
        squeeze-blacklist/lib/modules/2.6.32-5-686/$i
done

# diff squeeze-unmodified/etc/modprobe.d/blacklist.conf
squeeze-blacklist/etc/modprobe.d/blacklist.conf
24a25
> blacklist ata_piix

# diff squeeze-blacklist/etc/modprobe.d/aliases.conf
squeeze-unmodified/etc/modprobe.d/aliases.conf
# diff lenny/etc/modprobe.d/aliases
squeeze-unmodified/etc/modprobe.d/aliases.conf
4,5c4,5
< # Please file a bug against module-init-tools if a package needs a en=
try
< # in this file.
---
> # No new aliases should be added to this file, please file a bug agai=
nst
> # the kernel for any aliases which are still not built-in.
14c14
< alias net-pf-7  bridge
---
> # 7 BRIDGE
30c30
< alias net-pf-25 wanrouter
---
> # 25 WANROUTER
57,59d56
< alias block-major-8-*  sd_mod
< alias block-major-9-*  md
< alias block-major-11-* sr_mod
78d74
< alias char-major-9-* st
141,146c137,142
< alias bt-proto-0 l2cap
< alias bt-proto-2 sco
< alias bt-proto-3 rfcomm
< alias bt-proto-4 bnep
< alias bt-proto-5 cmtp
< alias bt-proto-6 hidp
---
> #alias bt-proto-0 l2cap
> #alias bt-proto-2 sco
> #alias bt-proto-3 rfcomm
> #alias bt-proto-4 bnep
> #alias bt-proto-5 cmtp
> #alias bt-proto-6 hidp
165a162,167
> # work around other kernel issues ###################################=
#########
> # The EHCI driver should be loaded before the ones for low speed cont=
rollers
> # or some devices may be confused when they are disconnected and reco=
nnected.
> softdep uhci-hcd pre: ehci-hcd
> softdep ohci-hcd pre: ehci-hcd
>

Nothing seems to be interesting here...

Playing with kernel sources

# ar p linux-source-2.6.26_2.6.26-25lenny1_all.deb data.tar.gz|tar zx
# ar p linux-source-2.6.32_2.6.32-23_all.deb data.tar.gz|tar zx
# (cd /usr/src ; tar -xjf linux-source-2.6.26.tar.bz2)
# (cd /usr/src ; tar -xjf linux-source-2.6.32.tar.bz2)
# find usr/src/linux-source-2.6.26 -iname '*modules.order*'
# find usr/src/linux-source-2.6.32 -iname '*modules.order*'

Nothing seems to be interesting here...

Where can I find modules.order ?
Or where write it and how ?
