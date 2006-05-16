From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 20:36:51 -0700
Message-ID: <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	 <446914C7.1030702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:22868 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751104AbWEPDgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 23:36:52 -0400
Received: by nf-out-0910.google.com with SMTP id o25so196150nfa
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 20:36:51 -0700 (PDT)
In-Reply-To: <446914C7.1030702@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> Avuton Olrich wrote:
> > On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> >> * sata_sil and ata_piix also need healthy re-testing of all basic
> >> functionality.
> >
> > I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:
>
> Testing what?  sata_sil?  Please provide full dmesg, there's a lot of
> missing information.

More followup, it did finally error out on me:

Not sure if it helps any, but this is a sata2 disk with a sata
interface. This is rc4-git2 with the libata patch from the beginning
of this thread, using sata_sil.

dmesg:
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: limiting speed to UDMA/66
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/66
ata1: EH complete
ata1.00: limiting speed to UDMA/44
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/44
ata1: EH complete
ata1.00: limiting speed to UDMA/33
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sda, sector 703661647
ata1: EH complete
ata1.00: limiting speed to UDMA/25
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/25
ata1: EH complete
NETDEV WATCHDOG: eth2: transmit timed out
ata1.00: limiting speed to UDMA/16
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/16
ata1: EH complete
ata1.00: limiting speed to PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x3 frozen
ata1.00: (BMDMA stat 0x1)
ata1.00: tag 0 cmd 0x25 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for PIO4
ata1: EH complete
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
  Flags; bus-master 1, dirty 18790(6) current 18806(6)
  Transmit list 37e3c5c0 vs. f7e3c5c0.
  0: @f7e3c200  length 8000002a status 0000002a
  1: @f7e3c2a0  length 8000002a status 0000002a
  2: @f7e3c340  length 8000002a status 0000002a
  3: @f7e3c3e0  length 8000002a status 0000002a
  4: @f7e3c480  length 8000002a status 8000002a
  5: @f7e3c520  length 8000002a status 8000002a
  6: @f7e3c5c0  length 8000005f status 0000005f
  7: @f7e3c660  length 8000005f status 0000005f
  8: @f7e3c700  length 8000002a status 0000002a
  9: @f7e3c7a0  length 8000002a status 0000002a
  10: @f7e3c840  length 8000002a status 0000002a
  11: @f7e3c8e0  length 8000002a status 0000002a
  12: @f7e3c980  length 8000002a status 0000002a
  13: @f7e3ca20  length 8000002a status 0000002a
  14: @f7e3cac0  length 8000002a status 0000002a
  15: @f7e3cb60  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
  Flags; bus-master 1, dirty 18790(6) current 18806(6)
  Transmit list 37e3c5c0 vs. f7e3c5c0.
  0: @f7e3c200  length 8000002a status 0000002a
  1: @f7e3c2a0  length 8000002a status 0000002a
  2: @f7e3c340  length 8000002a status 0000002a
  3: @f7e3c3e0  length 8000002a status 0000002a
  4: @f7e3c480  length 8000002a status 8000002a
  5: @f7e3c520  length 8000002a status 8000002a
  6: @f7e3c5c0  length 8000005f status 0000005f
  7: @f7e3c660  length 8000005f status 0000005f
  8: @f7e3c700  length 8000002a status 0000002a
  9: @f7e3c7a0  length 8000002a status 0000002a
  10: @f7e3c840  length 8000002a status 0000002a
  11: @f7e3c8e0  length 8000002a status 0000002a
  12: @f7e3c980  length 8000002a status 0000002a
  13: @f7e3ca20  length 8000002a status 0000002a
  14: @f7e3cac0  length 8000002a status 0000002a
  15: @f7e3cb60  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
  Flags; bus-master 1, dirty 18790(6) current 18806(6)
  Transmit list 37e3c5c0 vs. f7e3c5c0.
  0: @f7e3c200  length 8000002a status 0000002a
  1: @f7e3c2a0  length 8000002a status 0000002a
  2: @f7e3c340  length 8000002a status 0000002a
  3: @f7e3c3e0  length 8000002a status 0000002a
  4: @f7e3c480  length 8000002a status 8000002a
  5: @f7e3c520  length 8000002a status 8000002a
  6: @f7e3c5c0  length 8000005f status 0000005f
  7: @f7e3c660  length 8000005f status 0000005f
  8: @f7e3c700  length 8000002a status 0000002a
  9: @f7e3c7a0  length 8000002a status 0000002a
  10: @f7e3c840  length 8000002a status 0000002a
  11: @f7e3c8e0  length 8000002a status 0000002a
  12: @f7e3c980  length 8000002a status 0000002a
  13: @f7e3ca20  length 8000002a status 0000002a
  14: @f7e3cac0  length 8000002a status 0000002a
  15: @f7e3cb60  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
  Flags; bus-master 1, dirty 18790(6) current 18806(6)
  Transmit list 37e3c5c0 vs. f7e3c5c0.
  0: @f7e3c200  length 8000002a status 0000002a
  1: @f7e3c2a0  length 8000002a status 0000002a
  2: @f7e3c340  length 8000002a status 0000002a
  3: @f7e3c3e0  length 8000002a status 0000002a
  4: @f7e3c480  length 8000002a status 8000002a
  5: @f7e3c520  length 8000002a status 8000002a
  6: @f7e3c5c0  length 8000005f status 0000005f
  7: @f7e3c660  length 8000005f status 0000005f
  8: @f7e3c700  length 8000002a status 0000002a
  9: @f7e3c7a0  length 8000002a status 0000002a
  10: @f7e3c840  length 8000002a status 0000002a
  11: @f7e3c8e0  length 8000002a status 0000002a
  12: @f7e3c980  length 8000002a status 0000002a
  13: @f7e3ca20  length 8000002a status 0000002a
  14: @f7e3cac0  length 8000002a status 0000002a
  15: @f7e3cb60  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
  Flags; bus-master 1, dirty 18790(6) current 18806(6)
  Transmit list 37e3c5c0 vs. f7e3c5c0.
  0: @f7e3c200  length 8000002a status 0000002a
  1: @f7e3c2a0  length 8000002a status 0000002a
  2: @f7e3c340  length 8000002a status 0000002a
  3: @f7e3c3e0  length 8000002a status 0000002a
  4: @f7e3c480  length 8000002a status 8000002a
  5: @f7e3c520  length 8000002a status 8000002a
  6: @f7e3c5c0  length 8000005f status 0000005f
  7: @f7e3c660  length 8000005f status 0000005f
  8: @f7e3c700  length 8000002a status 0000002a
  9: @f7e3c7a0  length 8000002a status 0000002a
  10: @f7e3c840  length 8000002a status 0000002a
  11: @f7e3c8e0  length 8000002a status 0000002a
  12: @f7e3c980  length 8000002a status 0000002a
  13: @f7e3ca20  length 8000002a status 0000002a
  14: @f7e3cac0  length 8000002a status 0000002a
  15: @f7e3cb60  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cc0 media 8080 dma 000000a0 fifo 8800
  Flags; bus-master 1, dirty 18790(6) current 18806(6)
  Transmit list 37e3c5c0 vs. f7e3c5c0.
  0: @f7e3c200  length 8000002a status 0000002a
  1: @f7e3c2a0  length 8000002a status 0000002a
  2: @f7e3c340  length 8000002a status 0000002a
  3: @f7e3c3e0  length 8000002a status 0000002a
  4: @f7e3c480  length 8000002a status 8000002a
  5: @f7e3c520  length 8000002a status 8000002a
  6: @f7e3c5c0  length 8000005f status 0000005f
  7: @f7e3c660  length 8000005f status 0000005f
  8: @f7e3c700  length 8000002a status 0000002a
  9: @f7e3c7a0  length 8000002a status 0000002a
  10: @f7e3c840  length 8000002a status 0000002a
  11: @f7e3c8e0  length 8000002a status 0000002a
  12: @f7e3c980  length 8000002a status 0000002a
  13: @f7e3ca20  length 8000002a status 0000002a
  14: @f7e3cac0  length 8000002a status 0000002a
  15: @f7e3cb60  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.

lspci -vvv:
01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3112 SATARaid Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 9c00 [size=8]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at a400 [size=8]
        Region 3: I/O ports at a800 [size=4]
        Region 4: I/O ports at ac00 [size=16]
        Region 5: Memory at e5006000 (32-bit, non-prefetchable)
[size=512]
        [virtual] Expansion ROM at e6800000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
