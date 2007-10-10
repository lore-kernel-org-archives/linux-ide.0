From: Len Brown <lenb@kernel.org>
Subject: Re: Invalid PnP ACPI reserved MMIO areas on Supermicro boards
Date: Wed, 10 Oct 2007 01:10:25 -0400
Message-ID: <200710100110.25513.lenb@kernel.org>
References: <470C166C.4030502@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <470C166C.4030502@shaw.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 09 October 2007 20:01, Robert Hancock wrote:
> Some people with certain Supermicro boards (at least the H8DCE, it 
> seems) have reported that the sata_nv driver fails to attach to some of 
> the controllers due to resource conflicts:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=280641
> https://bugzilla.redhat.com/show_bug.cgi?id=313491
> 
> Essentially since about 2.6.22 or so (before which we apparently didn't 
> handle PnpACPI reserved MMIO regions?) we get:

So if you boot with "pnpacpi=off" then the board is happy?

-Len

> pnp: 00:09: iomem range 0xdfefd000-0xdfefd3ff has been reserved
> pnp: 00:09: iomem range 0xdfefe000-0xdfefe3ff has been reserved
> 
> when the CK804 SATA controllers have as their BIOS-assigned resources:
> 
> 80:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
> (rev f3) (prog-if 85 [Master SecO PriO])
> 	Subsystem: Super Micro Computer Inc Unknown device 1011
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 46
> 	Region 0: I/O ports at e400 [size=8]
> 	Region 1: I/O ports at e000 [size=4]
> 	Region 2: I/O ports at dc00 [size=8]
> 	Region 3: I/O ports at d800 [size=4]
> 	Region 4: I/O ports at d400 [size=16]
> 	Region 5: Memory at dfefd000 (32-bit, non-prefetchable)
> 
> and
> 
> 80:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
> (rev f3) (prog-if 85 [Master SecO PriO])
> 	Subsystem: Super Micro Computer Inc Unknown device 1011
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 45
> 	Region 0: I/O ports at f800 [size=8]
> 	Region 1: I/O ports at f400 [size=4]
> 	Region 2: I/O ports at f000 [size=8]
> 	Region 3: I/O ports at ec00 [size=4]
> 	Region 4: I/O ports at e800 [size=16]
> 	Region 5: Memory at dfefe000 (32-bit, non-prefetchable) [size=4K]
> 
> And so of course we get:
> 
> sata_nv 0000:80:07.0: Using ADMA mode
> PCI: Unable to reserve mem region #6:1000@dfefd000 for device 0000:80:07.0
> ACPI: PCI interrupt for device 0000:80:07.0 disabled
> sata_nv: probe of 0000:80:07.0 failed with error -16
> ACPI: PCI Interrupt Link [LT2E] enabled at IRQ 45
> ACPI: PCI Interrupt 0000:80:08.0[A] -> Link [LT2E] -> GSI 45 (level, 
> low) -> IRQ 45
> sata_nv 0000:80:08.0: Using ADMA mode
> PCI: Unable to reserve mem region #6:1000@dfefe000 for device 0000:80:08.0
> ACPI: PCI interrupt for device 0000:80:08.0 disabled
> sata_nv: probe of 0000:80:08.0 failed with error -16
> 
> So essentially the BIOS has erroneously reserved the SATA controller's 
> BARs in the ACPI motherboard resources, preventing the driver from 
> attaching to the device.
> 
> Any ideas on what we can do about this?
> 
> -Get Supermicro to fix the BIOS - already tried, it seems
> -System-specific quirk to ignore these resource reservations?
> -Try to move the PCI resources if they conflict with the ACPI resource 
> reservations?
> 
> I wonder how Windows deals with this, if it even does on these boards?
> 
