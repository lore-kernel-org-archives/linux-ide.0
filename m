From: Reartes Guillermo <rtguille@gmail.com>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Tue, 1 Oct 2013 12:25:35 -0300
Message-ID: <CAPVzhpwbrRg4A65hD3=-7JL3X0d18F-Way_BTKUhsHR2LmzkZQ@mail.gmail.com>
References: <20130927231346.GA5662@animx.eu.org>
	<CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
	<20130928122013.GA26951@animx.eu.org>
	<CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
	<20130929031101.GD11789@animx.eu.org>
	<20130930192731.GA2703@htj.dyndns.org>
	<20131001015559.GC18206@animx.eu.org>
	<20131001143924.GC2736@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42795 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab3JAPZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2013 11:25:36 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so7456985pdi.28
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2013 08:25:35 -0700 (PDT)
In-Reply-To: <20131001143924.GC2736@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-ide@vger.kernel.org, Kay Sievers <kay@vrfy.org>

> Do you happen to have a different optical drive?  It'd be interesting
> to find out whether the problem is independent of the drive.

If i am not mistaken, Wakko Warner's optical drive is: ATAPI: HL-DT-ST
DVDRAM GH24NS95, RN01

And in my case:

Optical Drive #1: iHBS112 (FW:PL06) (Updated from FW: CL0K)
Optical Drive #2: iHBS112 (FW:PL06) (Updated from FW: PL01)

System #1 Controllers (Sabertooth 990FX):
08:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial
ATA Controller [1b21:0612] (rev 01)
00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391] (rev 40)
Optical Drive #2

System #2 Controller (M4N72-E):
00:09.0 SATA controller [0106]: NVIDIA Corporation MCP78S [GeForce
8200] AHCI Controller [10de:0ad4] (rev a2)
Optical Drive #1

Freeze Error: (System #1 is the one who freezes)

Sep 28 16:14:27 ulquiorra.espada kernel: ata12.00: exception Emask
0x52 SAct 0x0 SErr 0xffffffff action 0xe frozen
Sep 28 16:14:27 ulquiorra.espada kernel: ata12: SError: { RecovData
RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt CommWake
10B8B Dispar BadC... DevExch }
Sep 28 16:14:27 ulquiorra.espada kernel: ata12.00: failed command:
IDENTIFY PACKET DEVICE
Sep 28 16:14:27 ulquiorra.espada kernel: [142B blob data]
Sep 28 16:14:27 ulquiorra.espada kernel: ata12.00: status: { DRDY }
Sep 28 16:14:27 ulquiorra.espada kernel: ata12: hard resetting link

So, i brought Optical Drive #1 and put it on System #1, got the issue
then i put it on System #2 and brought Optical Drive #2, got the
issue.
Updated both Optical Drives firmware and still got the issue.

Cheers.

On Tue, Oct 1, 2013 at 11:39 AM, Tejun Heo <tj@kernel.org> wrote:
> (cc'ing Kay)
>
> Kay, udev *could* be a part of the issue.  The original thread can be
> read from
>
>   http://thread.gmane.org/gmane.linux.ide/55284
>
> On Mon, Sep 30, 2013 at 09:55:59PM -0400, Wakko Warner wrote:
>> Please keep me in CC.
>
> That's the norm.  Everybody is supposed to reply-to-all here.  No need
> to worry about that.
>
>> > Misbehaving controllers can hang machine without any software way to
>> > recover from it.  It could just hang in the middle of memory
>> > transaction.  Unless PCI bridge aborts it with timeout, the only way
>> > the system can get out of there is hard reset.  Unfortunately,
>> > controllers misbehaving this way weren't too uncommon way back with
>> > controllers with taskfile based interface.  Nowadays, it mostly
>> > disappeared but we apparently have one here.
>>
>> Does it matter if it's PCIe?
>
> PCI tends to be worse probably because it's easier to get lost while
> literally holding the bus but I'm sure there are multiple ways to
> screw the whole system on pcie too.
>
>> Since hard drives and optical drives are all I have, I can't test anything
>> else.  I can try another optical drive, but it appears that others have the
>> same problem with optical drives on this controller.  Hard drives do not
>> have any problems on this controller.
>>
>> If I add libata.atapi_passthru16=0 (as mentioned by another), I do not have
>> any errors and I can use the drive w/o problems.  I burned and verified a
>> disc on this controller with this parameter set to 0.  I'm not sure if a
>> quirk can be added for this controller or not.  Seems that this disables for
>> all libata controllers.  I'm not sure what the impact would be though.
>
> Apparently, a command issued through SCSI passthrough from udev and
> its minions is upsetting the device / controller, which then enters a
> very catastrophic failure mode.  From the log, it looks like it's
> IDENTIFY_PACKET_DEVICE but it'd be interesting if we can actually
> isolate issuance of the single failing command.  It could be that the
> userland is issuing something slightly off which usually works okay
> but not for this one, or it could be the kernel passthrough code
> failing to handle some command bits or alignment properly.
>
> Do you happen to have a different optical drive?  It'd be interesting
> to find out whether the problem is independent of the drive.
>
> Thanks.
>
> --
> tejun
