From: Daniel Egger <de@axiros.com>
Subject: Re: Booting from SATA disables IDE?
Date: Fri, 1 Apr 2005 22:35:42 +0200
Message-ID: <b930a665dd861ac1b6c8f87c1df63e30@axiros.com>
References: <1921eeb1e202db77fdccb439f85ac532@axiros.com> <424D7F01.1060204@pobox.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15-936556965"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:8673 "EHLO
	live1.axiros.com") by vger.kernel.org with ESMTP id S262890AbVDAUgO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Apr 2005 15:36:14 -0500
In-Reply-To: <424D7F01.1060204@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--Apple-Mail-15-936556965
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 01.04.2005, at 19:04, Jeff Garzik wrote:

> Well, sata_via never touches the VIA PATA side of things.  Probably a 
> config or BIOS error, or similar.

So I though but since since the device is visible on the PCI
bus at all times that strikes me a bit odd.

> Where's the IDE driver output?

...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
SCSI subsystem initialized
libata version 1.10 loaded.
sata_via version 1.0
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
sata_via(0000:00:0f.0): routed to hard irq line 11
...

That's all.

One thing is pretty strange though which would support your
guess with the BIOS problem: I modified the Debian initrd
system to forcefully load the via82cxxx module before the
libata and sata_via driver but it still does not work, so
at least it doesn't seem to be the order in which the drivers
are loaded.

One other thing I find somewhat irritating is that the driver
and the PCI setup disagree about the IRQ assignment:

0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Unknown device 1849:0571
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 255
         Region 4: I/O ports at fc00 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

egger@karin:~$ cat /proc/interrupts
            CPU0
   0:   18784226    IO-APIC-edge  timer
   1:        256    IO-APIC-edge  i8042
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
169:      19176   IO-APIC-level  libata
177:       9373   IO-APIC-level  eth0
185:       1291   IO-APIC-level  eth1
193:      39017   IO-APIC-level  eth2
201:          2   IO-APIC-level  ohci1394
209:        532   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, 
uhci_hcd, ehci_hcd
217:          0   IO-APIC-level  via82cxxx

Servus,
       Daniel

--Apple-Mail-15-936556965
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCTbCfchlzsq9KoIYRAvHXAKDFKiEj5yONrXWUn10GWFQJUDn14ACfRwZk
hpRi+TBoT2zNz+hJuiVRl/g=
=eDae
-----END PGP SIGNATURE-----

--Apple-Mail-15-936556965--

