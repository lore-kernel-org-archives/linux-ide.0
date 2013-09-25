From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Wed, 25 Sep 2013 00:31:10 -0600
Message-ID: <CADLC3L2HO5R9jhBcz+L7d6kry6c+spJ+YMW7FW=o79VU2Xb=9A@mail.gmail.com>
References: <522C1AC5.4080105@linux.com>
	<522E9982.2060504@gmail.com>
	<52347C24.8060102@linux.com>
	<CADLC3L3tGG4yGZKir2pPzMYeddPjSFuD77u87C=YYEqtVn908Q@mail.gmail.com>
	<523887BC.50704@linux.com>
	<CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>
	<523D4C4C.5070400@linux.com>
	<CADLC3L3WCMWc4kuJ1-_GbFinEyCABuuh3Fonh641SptsfYDaeA@mail.gmail.com>
	<523E989F.5040800@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:52278 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3IYGbL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2013 02:31:11 -0400
Received: by mail-qa0-f46.google.com with SMTP id j7so3123604qaq.5
        for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2013 23:31:10 -0700 (PDT)
In-Reply-To: <523E989F.5040800@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: levex@linux.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Sep 22, 2013 at 1:13 AM, Levente Kurusa <levex@linux.com> wrote=
:
> 2013-09-21 19:04 keltez=E9ssel, Robert Hancock =EDrta:
>
>> On Sat, Sep 21, 2013 at 1:35 AM, Levente Kurusa <levex@linux.com> wr=
ote:
>>>>>>>>>
>>>>>>>>> The following dmesg is stuck in an infinite loop.
>>>>>>>>> dmesg:
>>>>>>>>> ata3: lost interrupt (Status 0x50)
>>>>>>>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fro=
zen
>>>>>>>>> ata3.00: failed command: READ DMA
>>>>>>>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 40=
96 in
>>>>>>>>>                   res 40/00:00:00:00:00/00:00:00:00:00/00 Ema=
sk 0x4
>>>>>>>>> (timeout)
>>>>>>>>> ata3.00: status: { DRDY }
>>>>>>>>> ata3: soft resetting link
>>>>>>>>> ata3.00: configured for UDMA/33 (no error)
>>>>>>>>> ata3.00: device reported invalid CHS sector 0
>>>>>>>>> ata3: EH complete
>>>>>>>>>
>>>>>>>>> Patch that fixes the infinite loop:
>>>>>>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.=
c
>>>>>>>>> index f9476fb..eeedf80 100644
>>>>>>>>> --- a/drivers/ata/libata-eh.c
>>>>>>>>> +++ b/drivers/ata/libata-eh.c
>>>>>>>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report(struct
>>>>>>>>> ata_link
>>>>>>>>> *link)
>>>>>>>>>                                 ehc->i.action, frozen, tries_=
buf);
>>>>>>>>>                     if (desc)
>>>>>>>>>                             ata_dev_err(ehc->i.dev, "%s\n", d=
esc);
>>>>>>>>> +               ehc->i.dev->exce_cnt ++;
>>>>>>>>> +               ata_dev_warn(ehc->i.dev, "Number of exception=
s:
>>>>>>>>> %d\n",
>>>>>>>>> ehc->i.dev->exce_cnt);
>>>>>>>>> +               /**
>>>>>>>>> +                  * The device is failing terribly,
>>>>>>>>> +                 * disable it to prevent damage.
>>>>>>>>> +                 */
>>>>>>>>> +               if(ehc->i.dev->exce_cnt > 2)
>>>>>>>>> +                       ata_dev_disable(ehc->i.dev);
>>>>>>>>>             } else {
>>>>>>>>>                     ata_link_err(link, "exception Emask 0x%x =
"
>>>>>>>>>                                  "SAct 0x%x SErr 0x%x action
>>>>>>>>> 0x%x%s%s\n",
>>>>>>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>>>>>>> index eae7a05..fa52ee6 100644
>>>>>>>>> --- a/include/linux/libata.h
>>>>>>>>> +++ b/include/linux/libata.h
>>>>>>>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>>>>>>>             u8
>>>>>>>>> devslp_timing[ATA_LOG_DEVSLP_SIZE];
>>>>>>>>>
>>>>>>>>>             /* error history */
>>>>>>>>> -       int                     spdn_cnt;
>>>>>>>>> +       int                     spdn_cnt; /* Number of speed_=
downs
>>>>>>>>> */
>>>>>>>>> +       int                     exce_cnt; /* Number of except=
ions
>>>>>>>>> that
>>>>>>>>> happenned */
>>>>>>>>>             /* ering is CLEAR_END, read comment above CLEAR_E=
ND */
>>>>>>>>>             struct ata_ering        ering;
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>
>>>>>>>> This doesn't seem like a very good fix. It may prevent the app=
arent
>>>>>>>> infinite loop but will just prevent that device from functioni=
ng at
>>>>>>>> all.
>>>>>>>> It would be better if we could figure out what was actually go=
ing
>>>>>>>> wrong.
>>>>>>>>
>>>>>>>>
>>>>>>> I have tested the problem with three different computers, all
>>>>>>> switched
>>>>>>> to legacy/IDE/compatibility mode, and they didn't have this pro=
blem.
>>>>>>> Of
>>>>>>> course, they could have been set to AHCI mode, and there the ke=
rnel
>>>>>>> would
>>>>>>> boot normally. Feels strange, but so far I was only able to rep=
roduce
>>>>>>> the
>>>>>>> problem with a Toshiba MK8052GSX. On the topic of my patch, I s=
till
>>>>>>> don't
>>>>>>> see why a device which fails so terribly that it reports 3 exce=
ptions
>>>>>>> shouldn't be disabled. Like in this case, it could cause infini=
te
>>>>>>> loops.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> The problem is that this could happen in some cases when you wou=
ldn't
>>>>>> want to disable the device, like an error that just happens
>>>>>> sporadically and works on retry, or a device you're trying to re=
cover
>>>>>> data from.
>>>>>>
>>>>> What do you think if I edit the patch in a way, that when an oper=
ation
>>>>> successfully completes, it resets exce_cnt to zero. Might as well=
 add a
>>>>> module_param, which can set the maximum value of exce_cnt, while =
having
>>>>> zero
>>>>> as an option to never disable the device. Please don't think me w=
rong,
>>>>> I
>>>>> don't want to force this patch, I just want to learn how all this
>>>>> works,
>>>>> and
>>>>> in the process try to make it better. :-)
>>>>
>>>>
>>>>
>>>> That would be better, but I think you're still going to have an is=
sue
>>>> with what magic number to pick to avoid disabling devices
>>>> inappropriately.
>>>>
>>>> Conceptually, disabling the device doesn't really make sense anywa=
y.
>>>> If someone in userspace wants to keep trying to read from that dev=
ice,
>>>> why would you stop them because of some arbitrary judgement? The
>>>> kernel itself isn't "locked up" during this process, anything not
>>>> blocked on I/O to that device should be able to continue running, =
so
>>>> that process is only hurting itself. If the system fails to boot f=
rom
>>>> another device due to this, this would likely point out some kind =
of
>>>> problem in userspace or the distro boot process being overly
>>>> serialized.
>>>>
>>>
>>> I have been booting up with the initramfs from ubuntu 13.04,
>>> and I have also tried to boot with the ubuntu install cd. They coul=
dn't
>>> continue the boot process. I'm gonna spend the weekend trying to fi=
gure
>>> out where and why the interrupts don't happen. Whether it be a rout=
ing
>>> or a hardware issue, which I highly doubt due to the fact that Wind=
ows
>>> XP SP2 was able to boot up without errors.
>>
>>
>> Are you able to get out full dmesg output from a boot attempt and th=
e
>> contents of /proc/interrupts?
>>
> As I said before, I am not able to get to the shell, without my 'symp=
tom
> cure'. With my patch I get the following dmesg output, with
> some of my debug messages turned off:
> http://pastebin.com/5eb5G3Dx
> /proc/interrupts is here:
> http://pastebin.com/84CJey2D
> After yesterday's research, I have come to ata_piix.c . That file loo=
ks like
> the real culprit, as my netbook's controller is an Intel ICH7M one,
> The values I am getting from the device are very different than those
> that are expected.
>
> Things I have noticed, but ignored in dmesg:
> There is a stack dump, because nobody cared about IRQ#20. I have igno=
red
> this because it is the EHCI IRQ, and I suppose it has nothing to do w=
ith
> ata. The problem is with ata3 or /dev/sdc, while the IRQ happens
> with /dev/sda, which works fine.

I think it is likely related to the problem. The kernel thinks this
controller is on IRQ 16, but apparently something is raising
un-acknowledged interrupts on IRQ 20 and nothing is coming in on IRQ
16. It seems quite likely that this is actually the ATA controller.

You mentioned that Windows XP was able to work in this mode. I wonder
if it was using the IOAPIC, as if not then the IRQ routing is
different which might mask the problem. Do you know what IRQ Device
Manager reported for this controller in Windows? And was it using any
IRQs over 15 (which would indicate the IOAPIC was in use)?

>
> Things I have not noticed before, but did now:
> The ACPI errors at ~0.1329
