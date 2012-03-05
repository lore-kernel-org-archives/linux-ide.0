From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH v2 0/3] ahci: fix boot/resume COMRESET failures
Date: Mon, 5 Mar 2012 08:58:24 +0800
Message-ID: <CAF1ivSZcGHQ-bnGasKghJ-_beDqgyZ_ug=m-7Ykr4xUphZeLqw@mail.gmail.com>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
	<CAE5mzvgfsHD1Ku5saw+Cu7+vJAayx20=HfHfab1MrAwz3AtqJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45656 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab2CEA6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2012 19:58:25 -0500
In-Reply-To: <CAE5mzvgfsHD1Ku5saw+Cu7+vJAayx20=HfHfab1MrAwz3AtqJg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cwillu <cwillu@cwillu.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Matt <jackdachef@gmail.com>

On Fri, Mar 2, 2012 at 9:16 PM, cwillu <cwillu@cwillu.com> wrote:
> On Tue, Feb 21, 2012 at 12:38 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> This series addresses regression problems with
>>
>> =A0 =A0commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>> =A0 =A0ahci: start engine only during soft/hard resets
>
> I just spent the better part of last night tracking down the specific
> sources of the log entry I get when I disconnect my e-sata drive; onc=
e
> it disconnects, the port is dead until I reboot; no combination of
> anything I've been able to poke at in /sys or elsewhere gets it live
> again. =A0This starts with 3.3rc1, and turns out to still work fine i=
n
> 3.2.1. Any chance it's related?
>
> 3.3rc5, immediately after the unplug:

Hi,

I tested on my machine and it's fixed by below patch.
http://marc.info/?l=3Dlinux-kernel&m=3D132996405028746&w=3D2

Would you please also try it?

Thanks,
Lin Ming

>
> [359799.624284] ata5: exception Emask 0x50 SAct 0x0 SErr 0x4090800
> action 0xe frozen
> [359799.624293] ata5: irq_stat 0x00400040, connection status changed
> [359799.624298] ata5: SError: { HostInt PHYRdyChg 10B8B DevExch }
> [359799.624304] ata5: hard resetting link
> [359800.348021] ata5: SATA link down (SStatus 0 SControl 300)
> [359805.348019] ata5: hard resetting link
> [359805.668015] ata5: SATA link down (SStatus 0 SControl 300)
> [359805.668030] ata5: limiting SATA link speed to 1.5 Gbps
> [359810.668014] ata5: hard resetting link
> [359810.988027] ata5: SATA link down (SStatus 0 SControl 310)
> [359810.988038] ata5.00: disabled
> [359810.988052] ata5: EH complete
> [359810.988062] ata5.00: detaching (SCSI 4:0:0:0)
> [359810.989357] sd 4:0:0:0: [sde] Synchronizing SCSI cache
> [359810.989403] sd 4:0:0:0: [sde] =A0Result: hostbyte=3DDID_BAD_TARGE=
T
> driverbyte=3DDRIVER_OK
> [359810.989410] sd 4:0:0:0: [sde] Stopping disk
> [359810.989422] sd 4:0:0:0: [sde] START_STOP FAILED
> [359810.989426] sd 4:0:0:0: [sde] =A0Result: hostbyte=3DDID_BAD_TARGE=
T
> driverbyte=3DDRIVER_OK
>
> plug it back in, and nothing happens.
>
> 3.3rc4 + v2 of your patch series (because there's nothing better than
> finding a likely culprit after 8 hours reading unfamiliar code, and
> the first search result for its commit log has words =A0"However, som=
e
> devices currently have issues with that fix, so we must implement a
> flag that delays the ahci_start_engine() call only for specific
> controllers" along with a patch):
>
> [ =A0135.966542] netconsole: network logging started
> [ =A0136.043949] Fri Mar 2 06:09:41 CST 2012
> [ =A0164.204992] SysRq : Changing Loglevel
> [ =A0164.205008] Loglevel set to 9
>
> unplug the esata cable
>
> [ =A0182.076415] ata5: exception Emask 0x50 SAct 0x0 SErr 0x4090800
> action 0xe frozen
> [ =A0182.076429] ata5: irq_stat 0x00400040, connection status changed
> [ =A0182.076443] ata5: SError: { HostInt PHYRdyChg 10B8B DevExch }
> [ =A0182.076449] ata5: hard resetting link
> [ =A0182.800028] ata5: SATA link down (SStatus 0 SControl 300)
> [ =A0187.800020] ata5: hard resetting link
> [ =A0188.120032] ata5: SATA link down (SStatus 0 SControl 300)
> [ =A0188.120050] ata5: limiting SATA link speed to 1.5 Gbps
> [ =A0193.120021] ata5: hard resetting link
> [ =A0193.440046] ata5: SATA link down (SStatus 0 SControl 310)
> [ =A0193.440087] ata5.00: disabled
> [ =A0193.440106] ata5: EH complete
> [ =A0193.440127] ata5.00: detaching (SCSI 4:0:0:0)
> [ =A0193.441626] sd 4:0:0:0: [sde] Synchronizing SCSI cache
> [ =A0193.441726] sd 4:0:0:0: [sde] =A0Result: hostbyte=3DDID_BAD_TARG=
ET
> driverbyte=3DDRIVER_OK
> [ =A0193.441734] sd 4:0:0:0: [sde] Stopping disk
> [ =A0193.441745] sd 4:0:0:0: [sde] START_STOP FAILED
> [ =A0193.441750] sd 4:0:0:0: [sde] =A0Result: hostbyte=3DDID_BAD_TARG=
ET
> driverbyte=3DDRIVER_OK
>
> plug it back in, and nothing happens.
>
>
> The same the same thing on 3.2.1 for comparison:
>
> [ =A0 68.834142] netconsole: network logging started
> [ =A0 76.551905] SysRq : Changing Loglevel
> [ =A0 76.551917] Loglevel set to 9
>
> unplug
>
> [ =A0 87.530721] ata5: exception Emask 0x50 SAct 0x0 SErr 0x4090800
> action 0xe frozen
> [ =A0 87.530735] ata5: irq_stat 0x00400040, connection status changed
> [ =A0 87.530739] ata5: SError: { HostInt PHYRdyChg 10B8B DevExch }
> [ =A0 87.530748] ata5: hard resetting link
> [ =A0 88.252038] ata5: SATA link down (SStatus 0 SControl 300)
> [ =A0 93.252026] ata5: hard resetting link
> [ =A0 93.576040] ata5: SATA link down (SStatus 0 SControl 300)
> [ =A0 93.576069] ata5: limiting SATA link speed to 1.5 Gbps
> [ =A0 98.576034] ata5: hard resetting link
> [ =A0 98.896035] ata5: SATA link down (SStatus 0 SControl 310)
> [ =A0 98.896052] ata5.00: disabled
> [ =A0 98.896069] ata5: EH complete
> [ =A0 98.896090] ata5.00: detaching (SCSI 4:0:0:0)
> [ =A0 98.897565] sd 4:0:0:0: [sde] Synchronizing SCSI cache
> [ =A0 98.898391] sd 4:0:0:0: [sde] =A0Result: hostbyte=3DDID_BAD_TARG=
ET
> driverbyte=3DDRIVER_OK
> [ =A0 98.898405] sd 4:0:0:0: [sde] Stopping disk
> [ =A0 98.898417] sd 4:0:0:0: [sde] START_STOP FAILED
> [ =A0 98.898421] sd 4:0:0:0: [sde] =A0Result: hostbyte=3DDID_BAD_TARG=
ET
> driverbyte=3DDRIVER_OK
>
> and plug it back in...
>
> [ =A0111.783606] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4040000
> action 0xe frozen
> [ =A0111.783620] ata5: irq_stat 0x00000040, connection status changed
> [ =A0111.783625] ata5: SError: { CommWake DevExch }
> [ =A0111.783633] ata5: limiting SATA link speed to 1.5 Gbps
> [ =A0111.783638] ata5: hard resetting link
> [ =A0112.676058] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 31=
0)
> [ =A0112.678304] ata5.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max U=
DMA/133
> [ =A0112.678316] ata5.00: 1953525168 sectors, multi 16: LBA48 NCQ (de=
pth
> 31/32), AA
> [ =A0112.679599] ata5.00: configured for UDMA/133
> [ =A0112.679635] ata5: EH complete
> [ =A0112.679763] scsi 4:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0W=
DC
> WD10EARS-00Y 80.0 PQ: 0 ANSI: 5
> [ =A0112.679933] sd 4:0:0:0: [sde] 1953525168 512-byte logical blocks=
:
> (1.00 TB/931 GiB)
> [ =A0112.680107] sd 4:0:0:0: [sde] Write Protect is off
> [ =A0112.680112] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [ =A0112.680140] sd 4:0:0:0: [sde] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ =A0112.680804] sd 4:0:0:0: Attached scsi generic sg4 type 0
> [ =A0113.099967] =A0sde: unknown partition table
> [ =A0113.100259] sd 4:0:0:0: [sde] Attached SCSI disk
>
> It lives! =A0(and it works fine all the way back to 2.6.32, possibly =
earlier).
>
> Now, the reason I'm picking on you is that git blame only has a
> handful of lines in libata-eh.c, and as near as I can figure, the onl=
y
> lines of code that changed in 3.3 that would seem to be able to cause
> this are the ones that your series is a quasi revert of. =A0I don't h=
ave
> hard evidence yet (unless the logged messages are more damning than I
> think they are), but it does seem likely that, at the very least, you
> might have some idea what's going on :p
>
> -- Carey
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
