From: russell@lls.lls.com (Russell Brown)
Subject: AIT Tape/SATA problems
Date: Tue, 6 May 2008 11:21:08 +0100 (BST)
Message-ID: <m1JtKIG-00r8jaa@lls.lls.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.llsnet.co.uk ([81.187.66.114]:45342 "EHLO
	mail2.llsnet.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYEFKoF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 06:44:05 -0400
Received: from localhost (10598 bytes) by lls.lls.com
	via sendmail with P:stdio/R:smart_host/T:via_mailX_smtp
	(sender: <russell>) (ident <russell> using unix)
	id <m1JtKIG-00r8jaa@lls.lls.com>
	for <linux-ide@vger.kernel.org>; Tue, 6 May 2008 11:21:08 +0100 (BST)
	(Smail-3.2.0.114 2001-Aug-6 #2 built 2001-dic-12)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Back in March I posted this to the list but didn't get any replies and
I'd really like to try and make progress on this.

Can anyone point me in the right direction?  I can build kernels and run
debug.

TIA

>I'm trying to use a Sony AIT SDX-870V tape drive on an NVidia MCP55
>SATA controller and it's basically not working :-(  
>
>I've tried two tape drives, different cables, different SATA ports and
>various kernels upto 2.6.25-rc7.  All suffer from the same problem when
>reading/writing data.  FWIW I do have a SATA CDRW drive on the same
>system and can read from that all day long without problems.
>
>The drive status is readable (and doing this doesn't cause failures):
>
># mt -f /dev/st0 status
>SCSI 2 tape drive:
>File number=0, block number=-1, partition=0.
>Tape block size 1024 bytes. Density code 0xb3 (no translation).
>Soft error count since last status=0
>General status bits on (1010000):
> ONLINE IM_REP_EN
>#
>
>If I write (using tar cvf /dev/st0...) a small amount of data, then some
>it gets written (I can read back half a dozen files). Anything
>non-trivial however always results in:
>
>ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
>ata3.00: BMDMA stat 0x4
>ata3.00: cmd a0/01:00:00:00:28/00:00:00:00:00/a0 tag 0 dma 10240 out
>         cdb 0a 01 00 00 0a 00 00 00  00 00 00 00 00 00 00 00
>         res 10/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x2 (HSM
>violation)
>ata3: soft resetting link
>ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>ata3.00: configured for UDMA/100
>ata3: EH complete
>st0: Sense Key : Aborted Command [current] [descriptor]
>Descriptor sense data with sense descriptors (in hex):
>        72 0b 00 00 00 00 00 0e 09 0c 00 00 00 03 00 00 
>        00 00 00 00 a0 10 
>st0: Add. Sense: No additional sense information
>st0: Sense Key : Unit Attention [current] 
>Info fld=0x1
>st0: Add. Sense: Power on, reset, or bus device reset occurred
>st0: Error on write filemark.
>st0: Sense Key : Not Ready [current] 
>st0: Add. Sense: Logical unit not ready, cause not reportable
>
>
>The drive detection bit from kern.log goes:
>
>Mar 28 09:56:34 build kernel: ata1: SATA link down (SStatus 0 SControl 300)
>Mar 28 09:56:34 build kernel: ata2: SATA link down (SStatus 0 SControl 300)
>Mar 28 09:56:34 build kernel: ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 22
>Mar 28 09:56:34 build kernel: ACPI: PCI Interrupt 0000:00:05.1[B] -> Link [LSA1] -> GSI 22 (level, low) -> IRQ 22
>Mar 28 09:56:34 build kernel: PCI: Setting latency timer of device 0000:00:05.1 to 64
>Mar 28 09:56:34 build kernel: scsi3 : sata_nv
>Mar 28 09:56:34 build kernel: scsi4 : sata_nv
>Mar 28 09:56:34 build kernel: ata3: SATA max UDMA/133 cmd 0xa880 ctl 0xa800 bmdma 0xa080 irq 22
>Mar 28 09:56:34 build kernel: ata4: SATA max UDMA/133 cmd 0xa480 ctl 0xa400 bmdma 0xa088 irq 22
>Mar 28 09:56:34 build kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>Mar 28 09:56:34 build kernel: ata3.00: ATAPI: SONY    SDX-870V, 0100, max UDMA/100
>Mar 28 09:56:34 build kernel: ata3.00: applying bridge limits
>Mar 28 09:56:34 build kernel: ata3.00: configured for UDMA/100
>Mar 28 09:56:34 build kernel: ata4: SATA link down (SStatus 0 SControl 300)
>Mar 28 09:56:34 build kernel: scsi 3:0:0:0: Sequential-Access SONY SDX-870V         0100 PQ: 0 ANSI: 3
>Mar 28 09:56:34 build kernel: st 3:0:0:0: Attached scsi tape st0
>Mar 28 09:56:34 build kernel: st 3:0:0:0: st0: try direct i/o: yes (alignment 4 B)
>Mar 28 09:56:34 build kernel: st 3:0:0:0: Attached scsi generic sg6 type 1
>Mar 28 09:56:34 build kernel: ACPI: PCI Interrupt Link [LSA2] enabled at IRQ 21
>Mar 28 09:56:34 build kernel: ACPI: PCI Interrupt 0000:00:05.2[C] -> Link [LSA2] -> GSI 21 (level, low) -> IRQ 21
>Mar 28 09:56:34 build kernel: PCI: Setting latency timer of device 0000:00:05.2 to 64
>Mar 28 09:56:34 build kernel: scsi5 : sata_nv
>Mar 28 09:56:34 build kernel: scsi6 : sata_nv
>Mar 28 09:56:34 build kernel: ata5: SATA max UDMA/133 cmd 0xa000 ctl 0x9c00 bmdma 0x9480 irq 21
>Mar 28 09:56:34 build kernel: ata6: SATA max UDMA/133 cmd 0x9880 ctl 0x9800 bmdma 0x9488 irq 21
>Mar 28 09:56:34 build kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>Mar 28 09:56:34 build kernel: ata5.00: ATAPI: ASUS    DRW-2014L1T, 1.00, max UDMA/66
>Mar 28 09:56:34 build kernel: ata5.00: configured for UDMA/66
>Mar 28 09:56:34 build kernel: ata6: SATA link down (SStatus 0 SControl 300)
>Mar 28 09:56:34 build kernel: scsi 5:0:0:0: CD-ROM            ASUS DRW-2014L1T      1.00 PQ: 0 ANSI: 5
>Mar 28 09:56:34 build kernel: sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
>Mar 28 09:56:34 build kernel: Uniform CD-ROM driver Revision: 3.20
>Mar 28 09:56:34 build kernel: sr 5:0:0:0: Attached scsi CD-ROM sr0
>Mar 28 09:56:34 build kernel: sr 5:0:0:0: Attached scsi generic sg7 type 5
>Mar 28 09:56:34 build kernel: ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 20
>
>lspci -v (for the SATA stuff) shows:
>
>00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3) (prog-if 85 [Master SecO PriO])
>        Subsystem: Super Micro Computer Inc Unknown device a011
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
>        I/O ports at b480 [size=8]
>        I/O ports at b400 [size=4]
>        I/O ports at b080 [size=8]
>        I/O ports at b000 [size=4]
>        I/O ports at ac00 [size=16]
>        Memory at dfaf9000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
>        Capabilities: [cc] HyperTransport: MSI Mapping
>
>00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3) (prog-if 85 [Master SecO PriO])
>        Subsystem: Super Micro Computer Inc Unknown device a011
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
>        I/O ports at a880 [size=8]
>        I/O ports at a800 [size=4]
>        I/O ports at a480 [size=8]
>        I/O ports at a400 [size=4]
>        I/O ports at a080 [size=16]
>        Memory at dfaf8000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
>        Capabilities: [cc] HyperTransport: MSI Mapping
>
>00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3) (prog-if 85 [Master SecO PriO])
>        Subsystem: Super Micro Computer Inc Unknown device a011
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
>        I/O ports at a000 [size=8]
>        I/O ports at 9c00 [size=4]
>        I/O ports at 9880 [size=8]
>        I/O ports at 9800 [size=4]
>        I/O ports at 9480 [size=16]
>        Memory at dfaf7000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
>        Capabilities: [cc] HyperTransport: MSI Mapping
>
>
>Using the 'sonytools' utility, I can do things like eject the tape (mt
>does that too) but trying a 'longer' command like tape format results in:
>
>#  sonytape /dev/st0 -p
>SONY tape device detected.
>SONY SDX-870V   Revision: 0100
>Please Load Tape In Drive!
>Sleeping 60 seconds.
>Formatting Tape.
>Request Sense data: 0x72 0x0b 0x47 0x00 0x00 0x00 0x00 0x0e 0x09 0x0c 
> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 
> 0xa0 0x58 
>Unknown Sense Code, No additional sense information
>Done.
>#
>
>and dmesg for this failure says:
>
>ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>ata3.00: cmd a0/00:00:00:16:00/00:00:00:00:00/a0 tag 0 pio 24 out
>         cdb 15 10 00 00 16 00 00 00  00 00 00 00 00 00 00 00
>         res 58/00:00:00:02:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
>ata3.00: status: { DRDY DRQ }
>ata3: port is slow to respond, please be patient (Status 0xd0)
>ata3: device not ready (errno=-16), forcing hardreset
>ata3: hard resetting link
>ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>ata3.00: configured for UDMA/100
>ata3: EH complete
>st0: Sense Key : Unit Attention [current] 
>st0: Add. Sense: Power on, reset, or bus device reset occurred
>
>As I said earlier, small amounts of data work like so:
>
># tar cvf /dev/st0 .
>./
>./sonytape
>./nori_trace.txt
>./SDX-870V.pdf
>./sonytape_linux_v2.8.tar.gz
>./sdx870v_0100.v87
>./datap.bin
>./readme_sonytape_linux_v2.8.txt
>./chnginq.txt
># tar vtf /dev/st0
>drwxrwxr-x root/root         0 2008-03-27 15:07 ./
>-rwxr-xr-x root/root    135282 2008-03-19 18:29 ./sonytape
>-rw-rw-r-- root/root   1360365 2008-03-27 15:07 ./nori_trace.txt
>-rw------- root/root    481793 2008-03-27 14:48 ./SDX-870V.pdf
>-rw-rw-r-- root/root     57566 2008-03-27 14:48
>./sonytape_linux_v2.8.tar.gz
>-rw------- root/root   1514496 2008-03-27 14:48 ./sdx870v_0100.v87
>-r-xr-xr-x root/root     65536 2003-07-20 16:43 ./datap.bin
>-rw-r--r-- root/root     12674 2008-03-19 15:28
>./readme_sonytape_linux_v2.8.txt
>-r-xr-xr-x root/root        28 2008-03-19 18:15 ./chnginq.txt
>#
>
>So it's seemingly something to do with the amount of data being sent to
>the drive.
>
>Can anyone suggest a course of action to getting this fixed?  I'm very
>happy to stick debug in bits of the kernel and report results.
>
>Thanks in advance.
>
-- 
 Regards,
     Russell
 --------------------------------------------------------------------
| Russell Brown          | MAIL: russell@lls.com PHONE: 01780 471800 |
| Lady Lodge Systems     | WWW Work: http://www.lls.com              |
| Peterborough, England  | WWW Play: http://www.ruffle.me.uk         |
 --------------------------------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
 Regards,
     Russell
 --------------------------------------------------------------------
| Russell Brown          | MAIL: russell@lls.com PHONE: 01780 471800 |
| Lady Lodge Systems     | WWW Work: http://www.lls.com              |
| Peterborough, England  | WWW Play: http://www.ruffle.me.uk         |
 --------------------------------------------------------------------
