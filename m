From: Wakko Warner <wakko@animx.eu.org>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Sat, 28 Sep 2013 23:11:01 -0400
Message-ID: <20130929031101.GD11789@animx.eu.org>
References: <20130927231346.GA5662@animx.eu.org>
 <CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
 <20130928122013.GA26951@animx.eu.org>
 <CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tn-76-7-162-101.sta.embarqhsd.net ([76.7.162.101]:48519 "EHLO
	animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab3I2DLF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Sep 2013 23:11:05 -0400
Content-Disposition: inline
In-Reply-To: <CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Reartes Guillermo <rtguille@gmail.com>
Cc: linux-ide@vger.kernel.org

Reartes Guillermo wrote:
> Hi, i have updated the bug-report.
> 
> I re-tested with 3.11.1-200.fc19.x86_64, and the
> 'libata.atapi_passthru16=0' kernel boot parameter is still needed to
> avoid the system freeze.
> 
> Please post a 'lsscsi' output.

I won't beable to do that if it needs to be plugged in to the ASM
controller.  The log below may contain enough information.

I had the drive plugged in to the intel controller (ata4).  I forgot to
change it to the ASM before I booted.  Still crashed either way.  Here's the
log.  It includes the unplug from ata4 and the plug into ata7 (the ASM port
0).  The port on the ASM is irrelevent, crashes on either plugged in.

This is also kernel 3.11.2.  I'll be testing 3.12-rcX (mainly due to the
i915 giving me a problem).  If it's any different, I'll report that back.

[  483.112423] ata4: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
[  483.113153] ata4: irq_stat 0x00400040, connection status changed
[  483.113871] ata4: SError: { HostInt PHYRdyChg 10B8B DevExch }
[  483.114508] ata4: hard resetting link
[  483.765169] ata4: SATA link down (SStatus 0 SControl 300)
[  487.442902] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
[  487.443646] ata7: irq_stat 0x00000040, connection status changed
[  487.444342] ata7: SError: { CommWake DevExch }
[  487.444983] ata7: hard resetting link
[  488.242392] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  488.245138] ata7.00: ATAPI: HL-DT-ST DVDRAM GH24NS95, RN01, max UDMA/133
[  488.249764] ata7.00: configured for UDMA/133
[  488.254294] ata7: EH complete
[  488.259109] scsi 6:0:0:0: CD-ROM            HL-DT-ST DVDRAM GH24NS95  RN01 PQ: 0 ANSI: 5
[  488.265359] sr1: scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw xa/form2 cdda tray
[  488.266209] sr 6:0:0:0: Attached scsi generic sg4 type 5
[  488.386743] ata4: hard resetting link
[  488.683575] ata4: SATA link down (SStatus 0 SControl 300)
[  488.684285] ata4: limiting SATA link speed to 1.5 Gbps
[  493.325977] ata4: hard resetting link
[  493.610920] ata4: SATA link down (SStatus 0 SControl 310)
[  493.611640] ata4.00: disabled
[  493.612336] ata4: EH complete
[  493.612957] ata4.00: detaching (SCSI 3:0:0:0)
[  516.314095] ata7.00: exception Emask 0x52 SAct 0x0 SErr 0xffffffff action 0xe frozen
[  516.314699] ata7: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq TrStaTrns UnrecFIS DevExch }
[  516.315939] ata7.00: failed command: IDENTIFY PACKET DEVICE
[  516.316567] ata7.00: cmd a1/00:01:00:00:00/00:00:00:00:00/00 tag 0 pio 512 in
[  516.316567]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x56 (ATA bus error)
[  516.317794] ata7.00: status: { DRDY }
[  516.318407] ata7: hard resetting link

Once this last line was printed, pings stopped working.  Computer was
completely frozen.  Keyboard lock keys won't toggle either.  SYSRQ non
functional.

> Also check if you can connect via ssh from another system and capture
> the kernel logs at the momment of the freeze. (either by using
> journalctl -f or doing a tail -f /var/log/messages).
> 
> At the momment of the freeze, some error or message should be printed.

I didn't even try.  I just setup netconsole instead.

> On Sat, Sep 28, 2013 at 9:20 AM, Wakko Warner <wakko@animx.eu.org> wrote:
> > Reartes Guillermo wrote:
> >> I am not sure it is the exact same [model] card., but check my bugreport:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=906532
> >> Hard freezes with ASMedia SATA (1b21:0612) (PCIe) and Optical Drive
> >> (iHBS112) (WORKAROUND = 'libata.atapi_passthru16=0')
> >
> > I looked.  Here's my controller:
> > 06:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA
> > Controller (rev 01) (prog-if 01 [AHCI 1.0])
> >         Subsystem: Super Micro Computer Inc Device 0805
> >         Flags: bus master, fast devsel, latency 0, IRQ 41
> >         I/O ports at d050 [size=8]
> >         I/O ports at d040 [size=4]
> >         I/O ports at d030 [size=8]
> >         I/O ports at d020 [size=4]
> >         I/O ports at d000 [size=32]
> >         Memory at f0400000 (32-bit, non-prefetchable) [size=512]
> >         Capabilities: <access denied>
> >         Kernel driver in use: ahci
> >
> > What I found interesting was the fact that the PCI location (06:00.0) is the
> > same as yours.  Mine is built on the motherboard.
> >
> > Did you wait to see if your system came responsive again?  Did you receive
> > ATA errors in your kernel log?  I unfortunately don't have the errors
> > written down and the system crashed before anything was logged.
> >
> > I'll try the atapi passthrough thing.
> >
> >> On Fri, Sep 27, 2013 at 8:13 PM, Wakko Warner <wakko@animx.eu.org> wrote:
> >> > I am not on this list, please keep me in CC.
> >> >
> >> > I have a SuperMicro X10SAE with a 2 port ASM1061 controller.  When a DVDRW
> >> > is plugged into the port and is accessed (ie udev rules), there will be some
> >> > errors, an ata reset then the system hangs.  Keyboard is non-responsive
> >> > (lock key lights won't change).  SYSRQ doesn't work.
> >> >
> >> > I tried both ports with the same result with 2 DVDRW drives (both same
> >> > model).
> >> >
> >> > I was able to use a hard disk attached to either port w/o problems.
> >> >
> >> > Kernel is vanilla 3.11.1 running on x86_64.
> >> >
> >> > --
> >> >  Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
> >> >  million bugs.
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> >  Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
> >  million bugs.
-- 
 Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
 million bugs.
