From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
	Cougar Point DeviceIDs
Date: Wed, 13 Jan 2010 17:57:22 -0600
Message-ID: <51f3faa71001131557n52e34260k13bf1fe3057bb0e@mail.gmail.com>
References: <201001121700.18234.seth.heasley@intel.com>
	 <4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com>
	 <m3my0i6nou.fsf@intrepid.localdomain> <4B4DFE1A.4000606@pobox.com>
	 <m3iqb57ts7.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f228.google.com ([209.85.217.228]:49896 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab0AMX5X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2010 18:57:23 -0500
In-Reply-To: <m3iqb57ts7.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 13, 2010 at 12:18 PM, Krzysztof Halasa <khc@pm.waw.pl> wrot=
e:
> Jeff Garzik <jgarzik@pobox.com> writes:
>
>> I'm not sure I understand your point. =A0Are there ahci problems wit=
h
>> the generic entries, that remain unresolved?
>
> It seems JMB363 on MSI Neo2 motherboard (P45 + ICH10R) still doesn't
> work correctly, flooding the kernel logs. No SATA devices connected,
> a CD-ROM connected to PATA (and it works fine). I've sent a report to
> the IDE =A0list some time ago, please let me know if you need more de=
tails
> or testing etc.
>
> JMB363 set in BIOS setup to non-RAID mode (it seems this means disabl=
ing
> the JMB BIOS). Last tested with 2.6.32.1 x86-64 SMP. IRQ 16 is shared=
=2E
>
> Currently the IRQ in PCI registers is 10 (JMB363 SATA is not handled)=
,
> I can enable and check again if needed.
>
> 02:00.0 SATA controller: JMicron Technologies, Inc. 20360/20363 Seria=
l ATA Controller (rev 03) (prog-if 01 [AHCI 1.0])
> =A0 =A0 =A0 =A0Subsystem: Micro-Star International Co., Ltd. Device 7=
512
> =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ the_rest-
> =A0 =A0 =A0 =A0Status: Cap+ the_rest-
> =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 32 bytes
> =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 10
> =A0 =A0 =A0 =A0Region 5: Memory at fe9fe000 (32-bit, non-prefetchable=
) [size=3D8K]
> =A0 =A0 =A0 =A0Capabilities: <access denied>
>
> ahci 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SA=
TA mode
> ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part
> ahci 0000:02:00.0: setting latency timer to 64
> scsi6 : ahci
> scsi7 : ahci
> ata7: SATA max UDMA/133 abar m8192@0xfe9fe000 port 0xfe9fe100 irq 16
> ata8: SATA max UDMA/133 abar m8192@0xfe9fe000 port 0xfe9fe180 irq 16
> ata8: SATA link down (SStatus 0 SControl 300)
> ata7: SATA link down (SStatus 0 SControl 300)
>
> then every few seconds (ata8 only, nothing on ata7):
>
> ata8: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
> ata8: irq_stat 0x00000040, connection status changed
> ata8: SError: { CommWake DevExch }
> ata8: hard resetting link
> ata8: SATA link down (SStatus 0 SControl 300)
> ata8: EH complete

That would seem like a board-specific problem, as I have an Asus
P7P55D PRO board with the same JMicron controller and I don't see any
such errors. The JMicron BIOS isn't enabled.

The behavior here is strange, the controller reports a connection
status change interrupt with CommWake which should indicate that some
device completed the handshake with the controller, but then the SATA
link shows down. I assume there's nothing plugged into the two JMicron
SATA ports?
