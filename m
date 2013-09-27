From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Fri, 27 Sep 2013 15:24:09 +0200
Message-ID: <524586F9.6030406@linux.com>
References: <522C1AC5.4080105@linux.com>	<522E9982.2060504@gmail.com>	<52347C24.8060102@linux.com>	<CADLC3L3tGG4yGZKir2pPzMYeddPjSFuD77u87C=YYEqtVn908Q@mail.gmail.com>	<523887BC.50704@linux.com>	<CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>	<523D4C4C.5070400@linux.com>	<CADLC3L3WCMWc4kuJ1-_GbFinEyCABuuh3Fonh641SptsfYDaeA@mail.gmail.com>	<523E989F.5040800@linux.com> <CADLC3L2HO5R9jhBcz+L7d6kry6c+spJ+YMW7FW=o79VU2Xb=9A@mail.gmail.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:50417 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab3I0NYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Sep 2013 09:24:13 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so1229943eek.30
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 06:24:12 -0700 (PDT)
In-Reply-To: <CADLC3L2HO5R9jhBcz+L7d6kry6c+spJ+YMW7FW=o79VU2Xb=9A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2013-09-25 08:31 keltez=E9ssel, Robert Hancock =EDrta:
> On Sun, Sep 22, 2013 at 1:13 AM, Levente Kurusa <levex@linux.com> wro=
te:
>> 2013-09-21 19:04 keltez=E9ssel, Robert Hancock =EDrta:
>>
>>> On Sat, Sep 21, 2013 at 1:35 AM, Levente Kurusa <levex@linux.com> w=
rote:
>>>>>>>>>>
>>>>>>>>>> The following dmesg is stuck in an infinite loop.
>>>>>>>>>> dmesg:
>>>>>>>>>> ata3: lost interrupt (Status 0x50)
>>>>>>>>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 fr=
ozen
>>>>>>>>>> ata3.00: failed command: READ DMA
>>>>>>>>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4=
096 in
>>>>>>>>>>                    res 40/00:00:00:00:00/00:00:00:00:00/00 E=
mask 0x4
>>>>>>>>>> (timeout)
>>>>>>>>>> ata3.00: status: { DRDY }
>>>>>>>>>> ata3: soft resetting link
>>>>>>>>>> ata3.00: configured for UDMA/33 (no error)
>>>>>>>>>> ata3.00: device reported invalid CHS sector 0
>>>>>>>>>> ata3: EH complete
>>>>>>>>>>
>>>>>>>>>> Patch that fixes the infinite loop:
>>>>>>>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh=
=2Ec
>>>>>>>>>> index f9476fb..eeedf80 100644
>>>>>>>>>> --- a/drivers/ata/libata-eh.c
>>>>>>>>>> +++ b/drivers/ata/libata-eh.c
>>>>>>>>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report(struct
>>>>>>>>>> ata_link
>>>>>>>>>> *link)
>>>>>>>>>>                                  ehc->i.action, frozen, trie=
s_buf);
>>>>>>>>>>                      if (desc)
>>>>>>>>>>                              ata_dev_err(ehc->i.dev, "%s\n",=
 desc);
>>>>>>>>>> +               ehc->i.dev->exce_cnt ++;
>>>>>>>>>> +               ata_dev_warn(ehc->i.dev, "Number of exceptio=
ns:
>>>>>>>>>> %d\n",
>>>>>>>>>> ehc->i.dev->exce_cnt);
>>>>>>>>>> +               /**
>>>>>>>>>> +                  * The device is failing terribly,
>>>>>>>>>> +                 * disable it to prevent damage.
>>>>>>>>>> +                 */
>>>>>>>>>> +               if(ehc->i.dev->exce_cnt > 2)
>>>>>>>>>> +                       ata_dev_disable(ehc->i.dev);
>>>>>>>>>>              } else {
>>>>>>>>>>                      ata_link_err(link, "exception Emask 0x%=
x "
>>>>>>>>>>                                   "SAct 0x%x SErr 0x%x actio=
n
>>>>>>>>>> 0x%x%s%s\n",
>>>>>>>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>>>>>>>> index eae7a05..fa52ee6 100644
>>>>>>>>>> --- a/include/linux/libata.h
>>>>>>>>>> +++ b/include/linux/libata.h
>>>>>>>>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>>>>>>>>              u8
>>>>>>>>>> devslp_timing[ATA_LOG_DEVSLP_SIZE];
>>>>>>>>>>
>>>>>>>>>>              /* error history */
>>>>>>>>>> -       int                     spdn_cnt;
>>>>>>>>>> +       int                     spdn_cnt; /* Number of speed=
_downs
>>>>>>>>>> */
>>>>>>>>>> +       int                     exce_cnt; /* Number of excep=
tions
>>>>>>>>>> that
>>>>>>>>>> happenned */
>>>>>>>>>>              /* ering is CLEAR_END, read comment above CLEAR=
_END */
>>>>>>>>>>              struct ata_ering        ering;
>>>>>>>>>>       };
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This doesn't seem like a very good fix. It may prevent the ap=
parent
>>>>>>>>> infinite loop but will just prevent that device from function=
ing at
>>>>>>>>> all.
>>>>>>>>> It would be better if we could figure out what was actually g=
oing
>>>>>>>>> wrong.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> I have tested the problem with three different computers, all
>>>>>>>> switched
>>>>>>>> to legacy/IDE/compatibility mode, and they didn't have this pr=
oblem.
>>>>>>>> Of
>>>>>>>> course, they could have been set to AHCI mode, and there the k=
ernel
>>>>>>>> would
>>>>>>>> boot normally. Feels strange, but so far I was only able to re=
produce
>>>>>>>> the
>>>>>>>> problem with a Toshiba MK8052GSX. On the topic of my patch, I =
still
>>>>>>>> don't
>>>>>>>> see why a device which fails so terribly that it reports 3 exc=
eptions
>>>>>>>> shouldn't be disabled. Like in this case, it could cause infin=
ite
>>>>>>>> loops.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> The problem is that this could happen in some cases when you wo=
uldn't
>>>>>>> want to disable the device, like an error that just happens
>>>>>>> sporadically and works on retry, or a device you're trying to r=
ecover
>>>>>>> data from.
>>>>>>>
>>>>>> What do you think if I edit the patch in a way, that when an ope=
ration
>>>>>> successfully completes, it resets exce_cnt to zero. Might as wel=
l add a
>>>>>> module_param, which can set the maximum value of exce_cnt, while=
 having
>>>>>> zero
>>>>>> as an option to never disable the device. Please don't think me =
wrong,
>>>>>> I
>>>>>> don't want to force this patch, I just want to learn how all thi=
s
>>>>>> works,
>>>>>> and
>>>>>> in the process try to make it better. :-)
>>>>>
>>>>>
>>>>>
>>>>> That would be better, but I think you're still going to have an i=
ssue
>>>>> with what magic number to pick to avoid disabling devices
>>>>> inappropriately.
>>>>>
>>>>> Conceptually, disabling the device doesn't really make sense anyw=
ay.
>>>>> If someone in userspace wants to keep trying to read from that de=
vice,
>>>>> why would you stop them because of some arbitrary judgement? The
>>>>> kernel itself isn't "locked up" during this process, anything not
>>>>> blocked on I/O to that device should be able to continue running,=
 so
>>>>> that process is only hurting itself. If the system fails to boot =
from
>>>>> another device due to this, this would likely point out some kind=
 of
>>>>> problem in userspace or the distro boot process being overly
>>>>> serialized.
>>>>>
>>>>
>>>> I have been booting up with the initramfs from ubuntu 13.04,
>>>> and I have also tried to boot with the ubuntu install cd. They cou=
ldn't
>>>> continue the boot process. I'm gonna spend the weekend trying to f=
igure
>>>> out where and why the interrupts don't happen. Whether it be a rou=
ting
>>>> or a hardware issue, which I highly doubt due to the fact that Win=
dows
>>>> XP SP2 was able to boot up without errors.
>>>
>>>
>>> Are you able to get out full dmesg output from a boot attempt and t=
he
>>> contents of /proc/interrupts?
>>>
>> As I said before, I am not able to get to the shell, without my 'sym=
ptom
>> cure'. With my patch I get the following dmesg output, with
>> some of my debug messages turned off:
>> http://pastebin.com/5eb5G3Dx
>> /proc/interrupts is here:
>> http://pastebin.com/84CJey2D
>> After yesterday's research, I have come to ata_piix.c . That file lo=
oks like
>> the real culprit, as my netbook's controller is an Intel ICH7M one,
>> The values I am getting from the device are very different than thos=
e
>> that are expected.
>>
>> Things I have noticed, but ignored in dmesg:
>> There is a stack dump, because nobody cared about IRQ#20. I have ign=
ored
>> this because it is the EHCI IRQ, and I suppose it has nothing to do =
with
>> ata. The problem is with ata3 or /dev/sdc, while the IRQ happens
>> with /dev/sda, which works fine.
>
> I think it is likely related to the problem. The kernel thinks this
> controller is on IRQ 16, but apparently something is raising
> un-acknowledged interrupts on IRQ 20 and nothing is coming in on IRQ
> 16. It seems quite likely that this is actually the ATA controller.
>
> You mentioned that Windows XP was able to work in this mode. I wonder
> if it was using the IOAPIC, as if not then the IRQ routing is
> different which might mask the problem. Do you know what IRQ Device
> Manager reported for this controller in Windows? And was it using any
> IRQs over 15 (which would indicate the IOAPIC was in use)?

Hmm, according to WinXP's Device manager for this controller,
it listens to IRQ# 20, and therefore it is using the I/O APIC.
Now, one question remains where is the error that mismaps
controller?
I have created a simple patch which seems to fix this:
---
@@ -1704,6 +1767,8 @@ static int piix_init_one(struct pci_dev *pdev,=20
const struct pci_device_id *ent)
  		hpriv->map =3D piix_init_sata_map(pdev, port_info,
  					piix_map_db_table[ent->driver_data]);

+	if(pdev->vendor =3D=3D 0x8086 && pdev->device =3D=3D 0x27C4)
+		pdev->irq =3D 20;
  	rc =3D ata_pci_bmdma_prepare_host(pdev, ppi, &host);
  	if (rc)
  		return rc;

However, I am more than sure that this is not the way
to solve this problem. Do you have any idea on where
the ideal place would be to implement a fix?
According to specs of ICH7M, which is essentially the
same as ICH6M, we need to check on what interrupt pin
is the SATA controller, and after that check which IRQ line
is connected to the I/O APIC and decide the IRQ's number
on those findings.

Specs of ICH7:=20
http://www.intel.com/content/dam/doc/datasheet/i-o-controller-hub-7-dat=
asheet.pdf
Device 31 Interrupt Route Register: Chapter 7.1.46
Device 31 Interrupt Pin Register: Chapter 7.1.41

The SATA controller is always Device 31.
--=20
Regards,
Levente Kurusa
