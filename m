From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Problem with IDE driver not claiming the disk
Date: Tue, 6 Dec 2005 09:23:56 +0100
Message-ID: <58cb370e0512060023w3ce35e9bk316ff6eb3f7e43f9@mail.gmail.com>
References: <1133826994.8181.68.camel@localhost.localdomain>
	 <58cb370e0512051634l323e922cxabb713a96ec72cab@mail.gmail.com>
	 <1133832984.8181.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.193]:55909 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751684AbVLFIYA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Dec 2005 03:24:00 -0500
Received: by nproxy.gmail.com with SMTP id x29so99993nfb
        for <linux-ide@vger.kernel.org>; Tue, 06 Dec 2005 00:23:57 -0800 (PST)
In-Reply-To: <1133832984.8181.87.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott James Remnant <scott@ubuntu.com>
Cc: linux-ide@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, Ben Collins <ben.collins@ubuntu.com>

On 12/6/05, Scott James Remnant <scott@ubuntu.com> wrote:
> Thanks for replying so quickly,
>
> On Tue, 2005-12-06 at 01:34 +0100, Bartlomiej Zolnierkiewicz wrote:
>
> > On 12/6/05, Scott James Remnant <scott@ubuntu.com> wrote:
> > > We've been having some IDE problems at Ubuntu Towers and can't seem to
> > > figure out what's up, and I was hoping you guys might instantly spot
> > > what we're doing wrong ...
> > >
> > > In order to get those events, and find out what's on the bus, we
> > > explicitly load the "ide-generic" driver.  This spawns a whole number of
> > > events, creating a whole array of devices -- /dev/hda* and friends.
> >
> > This sounds very, very wrong.  Devices should be probed and
> > registered by alim15x3/via82cxxx and not ide-generic driver.
> >
> Right, that's not happening for any of the drivers -- so far I haven't
> found an IDE driver that, when loaded, probes for devices and registers
> them.  They all need ide-generic to be loaded to "kick" them.
>
> > > Do you concur?  What are we doing wrong, or what is the driver doing
> > > wrong?
> >
> > We can only guess without dmesg and lspci -vvv.
> >
> Certainly...
>
> On the alim15x3 machine:
>
> modprobe pci:.... as a result of touching the uevent file for that
> device; loads the ide-core, alim15x3 and "generic" modules.  dmesg
> output:
>
>         Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>         ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>         ACPI: bus type ide registered
>
> modprobe ide-generic - currently hard-coded into our initramfs script.
> dmesg output:
>
>         ALI15X3: IDE controller at PCI slot 0000:00:10.0
>         ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 10
>         PCI: setting IRQ 10 as level-triggered
>         ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [C0C5] -> GSI 10 (level, low) -> IRQ 10
>         ALI15X3: chipset revision 196
>         ALI15X3: not 100% native mode: will probe irqs later
>             ide0: BM-DMA at 0x3800-0x3807, BIOS settings: hda:DMA, hdb:pio
>         ALI15X3: simplex device: DMA forced
>             ide1: BM-DMA at 0x3808-0x380f, BIOS settings: hdc:DMA, hdd:DMA
>         Probing IDE interface ide0...
>         hda: HTS548040M9AT00, ATA DISK drive
>         ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>         Probing IDE interface ide1...
>         Probing IDE interface ide1...
>         hda: max request size: 128KiB
>         hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
>         hda: cache flushes supported
>         hda: hda1 hda2 < hda5 > hda3
>
> (Full dmesg attached as alim-dmesg)
>
> As you can see, the probing doesn't take place until after ide-generic
> is loaded -- I left long gaps between doing each bit so it's reasonably
> obvious in the dmesg output.
>
> lspci of that device:
>
> 0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if ea)
>         Subsystem: Compaq Computer Corporation: Unknown device 005a
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (500ns min, 1000ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 4: I/O ports at 3800 [size=16]
>         Capabilities: <available only to root>
>
> (Full lspci attached as alim-lspci)
>
> > You didn't even tell your kernel version and whether this
> > is vanilla kernel or Ubuntu one (do you have any extra
> > IDE patches?).
> >
> I was first hoping it was a glaringly obvious thing we were doing wrong,
> and wouldn't come to comparing kernel code;  the kernel is the current
> Ubuntu one, it's based off 2.6.15 -- our patches are all in git:
>
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git
>
> I'm not best placed to answer the patches that are in the exact version
> I used ("our" 2.6.15-6.8), Ben Collins is (Cc'd).

You have IDE patches in your tree, please try vanilla 2.6.15.

Changes to setup-pci.c and ide-generic.c in the following patch are wrong:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=149744c1475cdaf2c6babfd92f163cca8f10c540;hp=5a373d68631531fff09047364be4565d67335f08

It seems that with this patch 'pre_init' in setup-pci.c. will
become '0' (it equals '1' initially) only after ide-generic is loaded...
and ide_pci_register_driver() checks 'pre_init' value.

Sigh, this patch was NACK-ed upstream for some (important) reasons...

Bartlomiej
