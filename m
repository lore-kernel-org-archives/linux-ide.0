From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Fri, 11 Oct 2013 18:07:44 +0200
Message-ID: <52582250.5040701@linux.com>
References: <522C1AC5.4080105@linux.com>	<522E9982.2060504@gmail.com>	<52347C24.8060102@linux.com>	<CADLC3L3tGG4yGZKir2pPzMYeddPjSFuD77u87C=YYEqtVn908Q@mail.gmail.com>	<523887BC.50704@linux.com>	<CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>	<523D4C4C.5070400@linux.com>	<CADLC3L3WCMWc4kuJ1-_GbFinEyCABuuh3Fonh641SptsfYDaeA@mail.gmail.com>	<523E989F.5040800@linux.com>	<CADLC3L2HO5R9jhBcz+L7d6kry6c+spJ+YMW7FW=o79VU2Xb=9A@mail.gmail.com>	<524586F9.6030406@linux.com>	<CADLC3L1HdD4xV64AWN0bO-2GizUMhwfwY5PZsLZN0eQ=4yFyXA@mail.gmail.com>	<52471600.4090908@linux.com>	<CADLC3L0nr3FmyEikG+Vev18mskR7XbfMAqPStLoj8BaEPNX3qA@mail.gmail.com> <CADLC3L3Bcv8B90eyroU7NemkHT3omechwP=0BCR3EG0Ko53yUg@mail.gmail.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:55715 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3JKQHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Oct 2013 12:07:49 -0400
In-Reply-To: <CADLC3L3Bcv8B90eyroU7NemkHT3omechwP=0BCR3EG0Ko53yUg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013-10-01 06:25 keltez=E9ssel, Robert Hancock =EDrta:
> On Sat, Sep 28, 2013 at 7:21 PM, Robert Hancock <hancockrwd@gmail.com=
> wrote:
>> On Sat, Sep 28, 2013 at 11:46 AM, Levente Kurusa <levex@linux.com> w=
rote:
>>> 2013-09-28 06:55 keltez=E9ssel, Robert Hancock =EDrta:
>>>
>>>> On Fri, Sep 27, 2013 at 7:24 AM, Levente Kurusa <levex@linux.com> =
wrote:
>>>>>
>>>>> 2013-09-25 08:31 keltez=E9ssel, Robert Hancock =EDrta:
>>>>>
>>>>>> On Sun, Sep 22, 2013 at 1:13 AM, Levente Kurusa <levex@linux.com=
> wrote:
>>>>>>>
>>>>>>>
>>>>>>> 2013-09-21 19:04 keltez=E9ssel, Robert Hancock =EDrta:
>>>>>>>
>>>>>>>> On Sat, Sep 21, 2013 at 1:35 AM, Levente Kurusa <levex@linux.c=
om>
>>>>>>>> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The following dmesg is stuck in an infinite loop.
>>>>>>>>>>>>>>> dmesg:
>>>>>>>>>>>>>>> ata3: lost interrupt (Status 0x50)
>>>>>>>>>>>>>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0=
x6
>>>>>>>>>>>>>>> frozen
>>>>>>>>>>>>>>> ata3.00: failed command: READ DMA
>>>>>>>>>>>>>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 =
dma 4096
>>>>>>>>>>>>>>> in
>>>>>>>>>>>>>>>                     res 40/00:00:00:00:00/00:00:00:00:0=
0/00
>>>>>>>>>>>>>>> Emask
>>>>>>>>>>>>>>> 0x4
>>>>>>>>>>>>>>> (timeout)
>>>>>>>>>>>>>>> ata3.00: status: { DRDY }
>>>>>>>>>>>>>>> ata3: soft resetting link
>>>>>>>>>>>>>>> ata3.00: configured for UDMA/33 (no error)
>>>>>>>>>>>>>>> ata3.00: device reported invalid CHS sector 0
>>>>>>>>>>>>>>> ata3: EH complete
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Patch that fixes the infinite loop:
>>>>>>>>>>>>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/liba=
ta-eh.c
>>>>>>>>>>>>>>> index f9476fb..eeedf80 100644
>>>>>>>>>>>>>>> --- a/drivers/ata/libata-eh.c
>>>>>>>>>>>>>>> +++ b/drivers/ata/libata-eh.c
>>>>>>>>>>>>>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report(s=
truct
>>>>>>>>>>>>>>> ata_link
>>>>>>>>>>>>>>> *link)
>>>>>>>>>>>>>>>                                   ehc->i.action, frozen=
,
>>>>>>>>>>>>>>> tries_buf);
>>>>>>>>>>>>>>>                       if (desc)
>>>>>>>>>>>>>>>                               ata_dev_err(ehc->i.dev, "=
%s\n",
>>>>>>>>>>>>>>> desc);
>>>>>>>>>>>>>>> +               ehc->i.dev->exce_cnt ++;
>>>>>>>>>>>>>>> +               ata_dev_warn(ehc->i.dev, "Number of exc=
eptions:
>>>>>>>>>>>>>>> %d\n",
>>>>>>>>>>>>>>> ehc->i.dev->exce_cnt);
>>>>>>>>>>>>>>> +               /**
>>>>>>>>>>>>>>> +                  * The device is failing terribly,
>>>>>>>>>>>>>>> +                 * disable it to prevent damage.
>>>>>>>>>>>>>>> +                 */
>>>>>>>>>>>>>>> +               if(ehc->i.dev->exce_cnt > 2)
>>>>>>>>>>>>>>> +                       ata_dev_disable(ehc->i.dev);
>>>>>>>>>>>>>>>               } else {
>>>>>>>>>>>>>>>                       ata_link_err(link, "exception Ema=
sk 0x%x
>>>>>>>>>>>>>>> "
>>>>>>>>>>>>>>>                                    "SAct 0x%x SErr 0x%x=
 action
>>>>>>>>>>>>>>> 0x%x%s%s\n",
>>>>>>>>>>>>>>> diff --git a/include/linux/libata.h b/include/linux/lib=
ata.h
>>>>>>>>>>>>>>> index eae7a05..fa52ee6 100644
>>>>>>>>>>>>>>> --- a/include/linux/libata.h
>>>>>>>>>>>>>>> +++ b/include/linux/libata.h
>>>>>>>>>>>>>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>>>>>>>>>>>>>               u8
>>>>>>>>>>>>>>> devslp_timing[ATA_LOG_DEVSLP_SIZE];
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>               /* error history */
>>>>>>>>>>>>>>> -       int                     spdn_cnt;
>>>>>>>>>>>>>>> +       int                     spdn_cnt; /* Number of
>>>>>>>>>>>>>>> speed_downs
>>>>>>>>>>>>>>> */
>>>>>>>>>>>>>>> +       int                     exce_cnt; /* Number of
>>>>>>>>>>>>>>> exceptions
>>>>>>>>>>>>>>> that
>>>>>>>>>>>>>>> happenned */
>>>>>>>>>>>>>>>               /* ering is CLEAR_END, read comment above
>>>>>>>>>>>>>>> CLEAR_END
>>>>>>>>>>>>>>> */
>>>>>>>>>>>>>>>               struct ata_ering        ering;
>>>>>>>>>>>>>>>        };
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This doesn't seem like a very good fix. It may prevent t=
he
>>>>>>>>>>>>>> apparent
>>>>>>>>>>>>>> infinite loop but will just prevent that device from fun=
ctioning
>>>>>>>>>>>>>> at
>>>>>>>>>>>>>> all.
>>>>>>>>>>>>>> It would be better if we could figure out what was actua=
lly
>>>>>>>>>>>>>> going
>>>>>>>>>>>>>> wrong.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>> I have tested the problem with three different computers,=
 all
>>>>>>>>>>>>> switched
>>>>>>>>>>>>> to legacy/IDE/compatibility mode, and they didn't have th=
is
>>>>>>>>>>>>> problem.
>>>>>>>>>>>>> Of
>>>>>>>>>>>>> course, they could have been set to AHCI mode, and there =
the
>>>>>>>>>>>>> kernel
>>>>>>>>>>>>> would
>>>>>>>>>>>>> boot normally. Feels strange, but so far I was only able =
to
>>>>>>>>>>>>> reproduce
>>>>>>>>>>>>> the
>>>>>>>>>>>>> problem with a Toshiba MK8052GSX. On the topic of my patc=
h, I
>>>>>>>>>>>>> still
>>>>>>>>>>>>> don't
>>>>>>>>>>>>> see why a device which fails so terribly that it reports =
3
>>>>>>>>>>>>> exceptions
>>>>>>>>>>>>> shouldn't be disabled. Like in this case, it could cause =
infinite
>>>>>>>>>>>>> loops.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The problem is that this could happen in some cases when y=
ou
>>>>>>>>>>>> wouldn't
>>>>>>>>>>>> want to disable the device, like an error that just happen=
s
>>>>>>>>>>>> sporadically and works on retry, or a device you're trying=
 to
>>>>>>>>>>>> recover
>>>>>>>>>>>> data from.
>>>>>>>>>>>>
>>>>>>>>>>> What do you think if I edit the patch in a way, that when a=
n
>>>>>>>>>>> operation
>>>>>>>>>>> successfully completes, it resets exce_cnt to zero. Might a=
s well
>>>>>>>>>>> add
>>>>>>>>>>> a
>>>>>>>>>>> module_param, which can set the maximum value of exce_cnt, =
while
>>>>>>>>>>> having
>>>>>>>>>>> zero
>>>>>>>>>>> as an option to never disable the device. Please don't thin=
k me
>>>>>>>>>>> wrong,
>>>>>>>>>>> I
>>>>>>>>>>> don't want to force this patch, I just want to learn how al=
l this
>>>>>>>>>>> works,
>>>>>>>>>>> and
>>>>>>>>>>> in the process try to make it better. :-)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That would be better, but I think you're still going to have=
 an
>>>>>>>>>> issue
>>>>>>>>>> with what magic number to pick to avoid disabling devices
>>>>>>>>>> inappropriately.
>>>>>>>>>>
>>>>>>>>>> Conceptually, disabling the device doesn't really make sense=
 anyway.
>>>>>>>>>> If someone in userspace wants to keep trying to read from th=
at
>>>>>>>>>> device,
>>>>>>>>>> why would you stop them because of some arbitrary judgement?=
 The
>>>>>>>>>> kernel itself isn't "locked up" during this process, anythin=
g not
>>>>>>>>>> blocked on I/O to that device should be able to continue run=
ning, so
>>>>>>>>>> that process is only hurting itself. If the system fails to =
boot
>>>>>>>>>> from
>>>>>>>>>> another device due to this, this would likely point out some=
 kind of
>>>>>>>>>> problem in userspace or the distro boot process being overly
>>>>>>>>>> serialized.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have been booting up with the initramfs from ubuntu 13.04,
>>>>>>>>> and I have also tried to boot with the ubuntu install cd. The=
y
>>>>>>>>> couldn't
>>>>>>>>> continue the boot process. I'm gonna spend the weekend trying=
 to
>>>>>>>>> figure
>>>>>>>>> out where and why the interrupts don't happen. Whether it be =
a
>>>>>>>>> routing
>>>>>>>>> or a hardware issue, which I highly doubt due to the fact tha=
t
>>>>>>>>> Windows
>>>>>>>>> XP SP2 was able to boot up without errors.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Are you able to get out full dmesg output from a boot attempt =
and the
>>>>>>>> contents of /proc/interrupts?
>>>>>>>>
>>>>>>> As I said before, I am not able to get to the shell, without my
>>>>>>> 'symptom
>>>>>>> cure'. With my patch I get the following dmesg output, with
>>>>>>> some of my debug messages turned off:
>>>>>>> http://pastebin.com/5eb5G3Dx
>>>>>>> /proc/interrupts is here:
>>>>>>> http://pastebin.com/84CJey2D
>>>>>>> After yesterday's research, I have come to ata_piix.c . That fi=
le looks
>>>>>>> like
>>>>>>> the real culprit, as my netbook's controller is an Intel ICH7M =
one,
>>>>>>> The values I am getting from the device are very different than=
 those
>>>>>>> that are expected.
>>>>>>>
>>>>>>> Things I have noticed, but ignored in dmesg:
>>>>>>> There is a stack dump, because nobody cared about IRQ#20. I hav=
e
>>>>>>> ignored
>>>>>>> this because it is the EHCI IRQ, and I suppose it has nothing t=
o do
>>>>>>> with
>>>>>>> ata. The problem is with ata3 or /dev/sdc, while the IRQ happen=
s
>>>>>>> with /dev/sda, which works fine.
>>>>>>
>>>>>>
>>>>>>
>>>>>> I think it is likely related to the problem. The kernel thinks t=
his
>>>>>> controller is on IRQ 16, but apparently something is raising
>>>>>> un-acknowledged interrupts on IRQ 20 and nothing is coming in on=
 IRQ
>>>>>> 16. It seems quite likely that this is actually the ATA controll=
er.
>>>>>>
>>>>>> You mentioned that Windows XP was able to work in this mode. I w=
onder
>>>>>> if it was using the IOAPIC, as if not then the IRQ routing is
>>>>>> different which might mask the problem. Do you know what IRQ Dev=
ice
>>>>>> Manager reported for this controller in Windows? And was it usin=
g any
>>>>>> IRQs over 15 (which would indicate the IOAPIC was in use)?
>>>>>
>>>>>
>>>>>
>>>>> Hmm, according to WinXP's Device manager for this controller,
>>>>> it listens to IRQ# 20, and therefore it is using the I/O APIC.
>>>>> Now, one question remains where is the error that mismaps
>>>>> controller?
>>>>> I have created a simple patch which seems to fix this:
>>>>> ---
>>>>> @@ -1704,6 +1767,8 @@ static int piix_init_one(struct pci_dev *pd=
ev,
>>>>> const
>>>>> struct pci_device_id *ent)
>>>>>                  hpriv->map =3D piix_init_sata_map(pdev, port_inf=
o,
>>>>>
>>>>> piix_map_db_table[ent->driver_data]);
>>>>>
>>>>> +       if(pdev->vendor =3D=3D 0x8086 && pdev->device =3D=3D 0x27=
C4)
>>>>> +               pdev->irq =3D 20;
>>>>>          rc =3D ata_pci_bmdma_prepare_host(pdev, ppi, &host);
>>>>>          if (rc)
>>>>>                  return rc;
>>>>>
>>>>> However, I am more than sure that this is not the way
>>>>> to solve this problem. Do you have any idea on where
>>>>> the ideal place would be to implement a fix?
>>>>> According to specs of ICH7M, which is essentially the
>>>>> same as ICH6M, we need to check on what interrupt pin
>>>>> is the SATA controller, and after that check which IRQ line
>>>>> is connected to the I/O APIC and decide the IRQ's number
>>>>> on those findings.
>>>>>
>>>>> Specs of ICH7:
>>>>>
>>>>> http://www.intel.com/content/dam/doc/datasheet/i-o-controller-hub=
-7-datasheet.pdf
>>>>> Device 31 Interrupt Route Register: Chapter 7.1.46
>>>>> Device 31 Interrupt Pin Register: Chapter 7.1.41
>>>>>
>>>>> The SATA controller is always Device 31.
>>>>
>>>>
>>>> It would appear that something is messing up with the ACPI IRQ rou=
ting
>>>> on this machine that's causing us to think the controller is on th=
e
>>>> wrong IRQ. CCing the linux-acpi list to see if anyone has some
>>>> additional debugging suggestions. I suspect that dumping the DSDT =
is
>>>> likely the first step though. If you can get IASL installed, you c=
an
>>>> do something like:
>>>>
>>>> cat /sys/firmware/acpi/tables/DSDT > dsdt.aml
>>>> iasl -d dsdt.aml
>>>>
>>>> That should spit out a dsdt.dsl file which would hopefully have th=
e
>>>> info needed to figure out what's going on.
>>>>
>>>
>>> Here is the disassembled DSDT table:
>>> http://pastebin.com/LWNVht9H
>>> The SATA controller is at line 5206.
>>> I also disassembled the SSDT, but nothing interesting was there:
>>> http://pastebin.com/fus5sxU8
>>>
>>> I disabled the usage of ACPI for IRQs with acpi=3Dnoirq,
>>> and it successfully booted up setting itself to IRQ#3.
>>> This makes me think that this is the BIOS's fault.
>>> I think it would be possible to create a DMI check
>>> and forcibly set the irq to 20 if the DMI matches.
>>> Any comments on this?
>>
>> The BIOS may be doing something funky, but since Windows apparently
>> can figure out it's on IRQ 20, Linux presumably should be able to as
>> well. DMI checks should be the last resort - Windows almost certainl=
y
>> doesn't have any machine-specific logic here, and it's hard to tell
>> what other machine models could be affected. With ACPI stuff, we
>> generally just need to do the same thing Windows does for things to
>> work reliably, and DMI checks are more of a hack workaround than a
>> real fix.
>>
>> I'll try and have a look at the DSDT within the next few days and se=
e
>> if I can figure anything out, unless someone beats me to it.
>=20
> I haven't gone into too much detail, but one thing I noticed with the
> DSDT is that there appear to be some _OSI checks for Windows 2006
> (i.e. Vista) that seem to affect various things, including potentiall=
y
> the PCI IRQ routing table. It's possible that their IRQ routing table
> is broken for legacy mode with an ACPI OS supporting Vista (as curren=
t
> Linux versions do). Could be this slipped through testing if they onl=
y
> tested AHCI mode with Vista installed.
>=20
> You can try booting with the kernel parameters
>=20
> acpi_osi=3D! acpi_osi=3D"Windows 2001 SP3"
>=20
> That should make the BIOS think we are Windows XP and bypass the Vist=
a
> code path. If that works, then you might want to check for a BIOS
> update on this machine.
>=20

=46irst of all, sorry for the late reply. I was kinda busy.

I tried what you suggested but unfortunately the problem persists.
This makes me believe that Windows XP does have somekind of DMI check h=
ere.
Of course, while a BIOS update may solve this, I would prefer that Linu=
x
should also be able to boot up with this broken BIOS as well.

If you are certain that WinXP doesn't use DMI checks,
it could be that WinXP's driver of ICH7M's SATA controller applies
a quirk and sets that irq line to #20.

--=20
Regards,
Levente Kurusa
