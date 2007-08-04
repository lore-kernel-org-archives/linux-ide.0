From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: 2.6.23-rc1: pata_via cable detection differs from via82cxxx
Date: Sat, 4 Aug 2007 12:59:35 +0200 (MEST)
Message-ID: <200708041059.l74AxZ1u027405@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:34485 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842AbXHDK7l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Aug 2007 06:59:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org

On Fri, 3 Aug 2007 23:32:17 +0100, Alan Cox wrote:
> Mikael Pettersson <mikpe@it.uu.se> wrote:
> 
> > The machine is an Athlon64 laptop with a K8T800 chipset. With the IDE
> > VIA driver the disk is detected as udma/100:
> 
> Currently old IDE via driver has a hack in it which goes 'did the BIOS
> set UDMA3+' then I guess the cable is 80 wire regardless. libata doesn't
> do that as it breaks with hotplug, breaks with suspend/resume before the
> driver is loaded and other bits.
> 
> Instead we have two things - an ACPI snoop and a table of wonky laptops
> (eg those that use 40 wire ultrashort cables which are valid for UDMA133
> but not detected as 80 wire). If your laptop is done that way then it
> just needs adding to the magic list and/or 2.6.23-rc1-mm should spot it
> by ACPI. I'd prefer the table entry anyway as I don't like relying on ACPI
> so an lspci -vvxx would be appreciated

Sure:

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Rioworks: Unknown device 2032
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 17
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 1ce0 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 05 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 1c 00 00 00 00 00 00 00 00 00 00 1f 16 32 20
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 01 00 00

The machine is an Arima W730-K8, rebadged and sold as the
Targa Visionary 811. eMachines and others also had this model.

/Mikael
