From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 20:06:18 -0400
Message-ID: <1254873978.1471.463.camel@giskard>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>
	 <4ACB3741.2030101@gmail.com> <1254852272.1471.172.camel@giskard>
	 <4ACBA33C.7090606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.develer.com ([83.149.158.210]:43842 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933236AbZJGAHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 20:07:00 -0400
In-Reply-To: <4ACBA33C.7090606@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>

El Tue, 06-10-2009 a las 16:06 -0400, Mark Lord escribi=F3:
> If you could also send me the output of "lspci -vv" for the cards
> then I can also have a quick look at chipset errata for possibilities=
=2E

See below.

Looking at the Status field, is it correct to say that the cards are
definitely running at 133MHz?  Is there a way to force them to a
different speed from Linux or from the BIOS?


> The early revs of these chips did have a number of errata specific to=
 PCI-X.

I checked the revision (09) against the sata_mv source and I couldn't
spot anything relevant to us.


03:04.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX60=
81 8-port SATA II PCI-X Controller (rev 09)
	Subsystem: Marvell Technology Group Ltd. Device 11ab
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at feb00000 (64-bit, non-prefetchable) [size=3D1M]
	Region 2: I/O ports at e800 [size=3D256]
	Region 3: [virtual] Memory at fdc00000 (32-bit, non-prefetchable) [siz=
e=3D4M]
	[virtual] Expansion ROM at fd800000 [disabled] [size=3D4M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=3D=
0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=3D512 OST=3D4
		Status: Dev=3D03:04.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC=3D5=
12 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
	Kernel driver in use: sata_mv
	Kernel modules: sata_mv

03:06.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX60=
81 8-port SATA II PCI-X Controller (rev 09)
	Subsystem: Marvell Technology Group Ltd. Device 11ab
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea00000 (64-bit, non-prefetchable) [size=3D1M]
	Region 2: I/O ports at e400 [size=3D256]
	Region 3: [virtual] Memory at fd400000 (32-bit, non-prefetchable) [siz=
e=3D4M]
	[virtual] Expansion ROM at fd000000 [disabled] [size=3D4M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=3D=
0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=3D512 OST=3D4
		Status: Dev=3D03:06.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC=3D5=
12 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
	Kernel driver in use: sata_mv
	Kernel modules: sata_mv


--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/

