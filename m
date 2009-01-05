From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 05 Jan 2009 15:08:04 +0300
Message-ID: <4961F824.1090406@ru.mvista.com>
References: <49615667.9020408@iwl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55490 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752265AbZAEMIL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 07:08:11 -0500
In-Reply-To: <49615667.9020408@iwl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Auerbach <karl@iwl.com>
Cc: linux-ide@vger.kernel.org, karl@cavebear.com

Hello.

Karl Auerbach wrote:

> I've found what I believe are some problems with the IDE drivers on 
> the 2.6.8 kernel on
> the PC-Engines ALIX2 platform.
>
> There are two points in particular:
>
> 1. The ide_generic driver no longer finds the IDE drive (an EXT3
> formatted compact flash on an IDE channel on an AMD CS5536 controller)
> unless the kernel is given the ide_generic.probe_mask=0x## command
> line parameter.  (I'll get to the values of ## later.)

   The probing behavior was changes on purpose, IIRC.

> 2. The cs5535 ide driver doesn't seem to be able to recognize the
> newer CS5536 controller for IDE.

   No wonder, it's even impossible to determine CS5536 IDE controller's 
device ID from the datasheet; include/linux/pci_ids.h tells me that the 
device ID is 0x209A, so adding another ID to the 'cs5535' driver's ID 
table shouldn't be an issue -- if they are indeed compatible. Looking at 
the datasheets, they are not -- bad luck, we need a new driver... BTW, 
libata seems to already have support for this chipset.

> I will provide more details below.
>
> I'd submit these directly into the bugzilla but as I'm not familar
> with the process and conventions I thought I'd begin with this email.

   I don't think these are bugs.

> I. The ide_generic issue:
>
> [1.] One line summary of the problem:
>
> ide_generic driver under 2.6.28 no longer finds IDE drives on
> PC-Engines ALIX2.
>
> [2.] Full description of the problem/report:
>
> The PC-Engines ALIX2 platform uses an AMD Geode LX processor with the
> AMD CS5536 companion chip for things like IDE support.  The IDE drive
> is a compact flash.
>
> On the 2.6.27.8 kernel the ide_generic driver found the IDE and
> compact flash without the need for any kernel command line parameters.
>
> On the 2.6.28 kernel the ide_generic driver no longer finds the IDE
> drive unless a ide_generic.probe_mask=0x## command line parameter is
> given to the kernel.

   Because ide-generic now avoids IDE ports already known to belong to 
the PCI controllers.

> I've tried several values for ##, I have not yet found one that
> exactly replicates the behaviour of the 2.6.27.8 kernel.
>
> However, values 0x3f, 0x31, and 0x11 all seem to work, although the
> last of these (0x11 has the closest behaviour to the 2.6.27.8 kernel.)

   Hm, doesn't plain 1 also work?

> Here's the relevant kernel output when using the 0x11 value in the
> following kernel command line.  (The 0x31 value gives the same
> results.  The 0x3f value finds several more IDE items.)
>
> Kernel command line: console=ttyS0,38400 root=/dev/hda2 
> ramdisk_size=16384 initrd=/initrd.gz rw ide_generic.probe_mask=0x11 
> BOOT_IMAGE=/linux
>
> Uniform Multi-Platform E-IDE driver
> ide_generic: enforcing probing of I/O ports upon user request
> hda: TRANSCEND, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x1e0-0x1e7,0x3e6 on irq 8
> ide2 at 0x160-0x167,0x366 on irq 12

   But this rather matches 0x31 mask.

> ide-gd driver 1.18
> hda: max request size: 128KiB
> hda: 3915072 sectors (2004 MB) w/1KiB Cache, CHS=3884/16/63
>  hda: hda1 hda2 hda3
> Driver 'sd' needs updating - please use bus_type methods

   Hm, why are you using 'sd' driver at all?

> II. The cs5536 controller issue.
>
> [1.] One line summary of the problem:
>
> The cs5535 ide driver doesn't seem to recognize the AMD CS5536
> controller.

  And it shouldn't -- the controllers are incompatible.

> [2.] Full description of the problem/report
>
> The old AMD Geode used the CS5535 companion chipset for several
> purposes including IDE.
>
> The newer AMD Geode LX uses the CS5536 companion chipset.
>
> It is not clear that the cs5535 ide kernel driver is supposed to
> handle the newer chipset.  But in any event, it seems that the cs5535
> driver, when it is looking for the hardware, is not seeing anything it
> recognizes.
>
> There is some ambiguity created becaause at least one "cs5535" driver
> works on the The CS5536: cs5535_gpio

   That only means that *some* fucntins of CS5536 are compatible with 
CS5535.

> This is not a particularly signifcant issue - the ide_generic driver
> handles the CS5536 IDE just fine (modulo the command line issue I
> reported above.)  But it would be nice if any ambiguity about what the
> cs5535 driver supports and what it does not support were clarified.

   Hopefully, it's clarified now. :-)

>     Thanks,
>         --karl--

MBR, Sergei


