From: Reartes Guillermo <rtguille@gmail.com>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Sat, 28 Sep 2013 16:44:38 -0300
Message-ID: <CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
References: <20130927231346.GA5662@animx.eu.org>
	<CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
	<20130928122013.GA26951@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:46418 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab3I1Toj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Sep 2013 15:44:39 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so3936627pbc.1
        for <linux-ide@vger.kernel.org>; Sat, 28 Sep 2013 12:44:38 -0700 (PDT)
In-Reply-To: <20130928122013.GA26951@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-ide@vger.kernel.org

Hi, i have updated the bug-report.

I re-tested with 3.11.1-200.fc19.x86_64, and the
'libata.atapi_passthru16=0' kernel boot parameter is still needed to
avoid the system freeze.

Please post a 'lsscsi' output.

Also check if you can connect via ssh from another system and capture
the kernel logs at the momment of the freeze. (either by using
journalctl -f or doing a tail -f /var/log/messages).

At the momment of the freeze, some error or message should be printed.

Cheers.




On Sat, Sep 28, 2013 at 9:20 AM, Wakko Warner <wakko@animx.eu.org> wrote:
> Reartes Guillermo wrote:
>> I am not sure it is the exact same [model] card., but check my bugreport:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=906532
>> Hard freezes with ASMedia SATA (1b21:0612) (PCIe) and Optical Drive
>> (iHBS112) (WORKAROUND = 'libata.atapi_passthru16=0')
>
> I looked.  Here's my controller:
> 06:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA
> Controller (rev 01) (prog-if 01 [AHCI 1.0])
>         Subsystem: Super Micro Computer Inc Device 0805
>         Flags: bus master, fast devsel, latency 0, IRQ 41
>         I/O ports at d050 [size=8]
>         I/O ports at d040 [size=4]
>         I/O ports at d030 [size=8]
>         I/O ports at d020 [size=4]
>         I/O ports at d000 [size=32]
>         Memory at f0400000 (32-bit, non-prefetchable) [size=512]
>         Capabilities: <access denied>
>         Kernel driver in use: ahci
>
> What I found interesting was the fact that the PCI location (06:00.0) is the
> same as yours.  Mine is built on the motherboard.
>
> Did you wait to see if your system came responsive again?  Did you receive
> ATA errors in your kernel log?  I unfortunately don't have the errors
> written down and the system crashed before anything was logged.
>
> I'll try the atapi passthrough thing.
>
>> On Fri, Sep 27, 2013 at 8:13 PM, Wakko Warner <wakko@animx.eu.org> wrote:
>> > I am not on this list, please keep me in CC.
>> >
>> > I have a SuperMicro X10SAE with a 2 port ASM1061 controller.  When a DVDRW
>> > is plugged into the port and is accessed (ie udev rules), there will be some
>> > errors, an ata reset then the system hangs.  Keyboard is non-responsive
>> > (lock key lights won't change).  SYSRQ doesn't work.
>> >
>> > I tried both ports with the same result with 2 DVDRW drives (both same
>> > model).
>> >
>> > I was able to use a hard disk attached to either port w/o problems.
>> >
>> > Kernel is vanilla 3.11.1 running on x86_64.
>> >
>> > --
>> >  Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
>> >  million bugs.
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
>  Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
>  million bugs.
