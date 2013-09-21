From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Sat, 21 Sep 2013 09:35:40 +0200
Message-ID: <523D4C4C.5070400@linux.com>
References: <522C1AC5.4080105@linux.com> <522E9982.2060504@gmail.com> <52347C24.8060102@linux.com> <CADLC3L3tGG4yGZKir2pPzMYeddPjSFuD77u87C=YYEqtVn908Q@mail.gmail.com> <523887BC.50704@linux.com> <CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:65263 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab3IUHfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Sep 2013 03:35:44 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so672988eae.38
        for <linux-ide@vger.kernel.org>; Sat, 21 Sep 2013 00:35:43 -0700 (PDT)
In-Reply-To: <CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2013-09-18 03:35 keltez=E9ssel, Robert Hancock =EDrta:
> On Tue, Sep 17, 2013 at 10:47 AM, Levente Kurusa <levex@linux.com> wr=
ote:
>> 2013-09-16 06:37 keltez=E9ssel, Robert Hancock =EDrta:
>>
>>> On Sat, Sep 14, 2013 at 9:09 AM, Levente Kurusa <levex@linux.com> w=
rote:
>>>>
>>>> 2013-09-10 06:01 keltez=E9ssel, Robert Hancock =EDrta:
>>>>
>>>>> On 09/08/2013 12:35 AM, Levente Kurusa wrote:
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I have been testing the Linux Kernel on a two year Toshiba NB100
>>>>>> netbook of mine, however when I enabled SATA compatibility/legac=
y mode
>>>>>> instead of AHCI mode in the BIOS, the kernel got stuck. I have p=
asted
>>>>>> the relevant dmesg piece along with a patch that fixes it tempor=
arily.
>>>>>> What I suspect to be the cause is that the BIOS sets the device =
into
>>>>>> IDE mode, but it will report it as a SATA device and hence libat=
a tries
>>>>>> to send ATA commands to it, which obviously makes it go bad. The=
 patch
>>>>>
>>>>>
>>>>>
>>>>> No, the commands are the same whichever mode the controller is in=
=2E The
>>>>> problem is presumably something else, like maybe some kind of int=
errupt
>>>>> routing problem when the controller is in legacy mode.
>>>>>
>>>> Yes, I see now.
>>>>
>>>>
>>>>>> fixes it, by adding a new field to ata_device called exce_cnt, w=
hich
>>>>>> counts how many exceptions have occured. After three exceptions,=
 it
>>>>>> automatically disables the device. Also, please note this is my =
first
>>>>>> ever patch for the kernel :-)
>>>>>>
>>>>>> The following dmesg is stuck in an infinite loop.
>>>>>> dmesg:
>>>>>> ata3: lost interrupt (Status 0x50)
>>>>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>>>>> ata3.00: failed command: READ DMA
>>>>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 =
in
>>>>>>                  res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0=
x4
>>>>>> (timeout)
>>>>>> ata3.00: status: { DRDY }
>>>>>> ata3: soft resetting link
>>>>>> ata3.00: configured for UDMA/33 (no error)
>>>>>> ata3.00: device reported invalid CHS sector 0
>>>>>> ata3: EH complete
>>>>>>
>>>>>> Patch that fixes the infinite loop:
>>>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>>>>> index f9476fb..eeedf80 100644
>>>>>> --- a/drivers/ata/libata-eh.c
>>>>>> +++ b/drivers/ata/libata-eh.c
>>>>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report(struct ata=
_link
>>>>>> *link)
>>>>>>                                ehc->i.action, frozen, tries_buf)=
;
>>>>>>                    if (desc)
>>>>>>                            ata_dev_err(ehc->i.dev, "%s\n", desc)=
;
>>>>>> +               ehc->i.dev->exce_cnt ++;
>>>>>> +               ata_dev_warn(ehc->i.dev, "Number of exceptions: =
%d\n",
>>>>>> ehc->i.dev->exce_cnt);
>>>>>> +               /**
>>>>>> +                  * The device is failing terribly,
>>>>>> +                 * disable it to prevent damage.
>>>>>> +                 */
>>>>>> +               if(ehc->i.dev->exce_cnt > 2)
>>>>>> +                       ata_dev_disable(ehc->i.dev);
>>>>>>            } else {
>>>>>>                    ata_link_err(link, "exception Emask 0x%x "
>>>>>>                                 "SAct 0x%x SErr 0x%x action 0x%x=
%s%s\n",
>>>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>>>> index eae7a05..fa52ee6 100644
>>>>>> --- a/include/linux/libata.h
>>>>>> +++ b/include/linux/libata.h
>>>>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>>>>            u8                      devslp_timing[ATA_LOG_DEVSLP_=
SIZE];
>>>>>>
>>>>>>            /* error history */
>>>>>> -       int                     spdn_cnt;
>>>>>> +       int                     spdn_cnt; /* Number of speed_dow=
ns */
>>>>>> +       int                     exce_cnt; /* Number of exception=
s that
>>>>>> happenned */
>>>>>>            /* ering is CLEAR_END, read comment above CLEAR_END *=
/
>>>>>>            struct ata_ering        ering;
>>>>>>     };
>>>>>>
>>>>>
>>>>> This doesn't seem like a very good fix. It may prevent the appare=
nt
>>>>> infinite loop but will just prevent that device from functioning =
at all.
>>>>> It would be better if we could figure out what was actually going=
 wrong.
>>>>>
>>>>>
>>>> I have tested the problem with three different computers, all swit=
ched
>>>> to legacy/IDE/compatibility mode, and they didn't have this proble=
m. Of
>>>> course, they could have been set to AHCI mode, and there the kerne=
l would
>>>> boot normally. Feels strange, but so far I was only able to reprod=
uce the
>>>> problem with a Toshiba MK8052GSX. On the topic of my patch, I stil=
l don't
>>>> see why a device which fails so terribly that it reports 3 excepti=
ons
>>>> shouldn't be disabled. Like in this case, it could cause infinite =
loops.
>>>
>>>
>>> The problem is that this could happen in some cases when you wouldn=
't
>>> want to disable the device, like an error that just happens
>>> sporadically and works on retry, or a device you're trying to recov=
er
>>> data from.
>>>
>> What do you think if I edit the patch in a way, that when an operati=
on
>> successfully completes, it resets exce_cnt to zero. Might as well ad=
d a
>> module_param, which can set the maximum value of exce_cnt, while hav=
ing zero
>> as an option to never disable the device. Please don't think me wron=
g, I
>> don't want to force this patch, I just want to learn how all this wo=
rks, and
>> in the process try to make it better. :-)
>
> That would be better, but I think you're still going to have an issue
> with what magic number to pick to avoid disabling devices
> inappropriately.
>
> Conceptually, disabling the device doesn't really make sense anyway.
> If someone in userspace wants to keep trying to read from that device=
,
> why would you stop them because of some arbitrary judgement? The
> kernel itself isn't "locked up" during this process, anything not
> blocked on I/O to that device should be able to continue running, so
> that process is only hurting itself. If the system fails to boot from
> another device due to this, this would likely point out some kind of
> problem in userspace or the distro boot process being overly
> serialized.
>

I have been booting up with the initramfs from ubuntu 13.04,
and I have also tried to boot with the ubuntu install cd. They couldn't
continue the boot process. I'm gonna spend the weekend trying to figure
out where and why the interrupts don't happen. Whether it be a routing
or a hardware issue, which I highly doubt due to the fact that Windows
XP SP2 was able to boot up without errors.

--=20
Regards,
Levente Kurusa
