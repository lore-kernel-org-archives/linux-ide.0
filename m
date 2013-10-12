From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Sat, 12 Oct 2013 11:29:37 +0200
Message-ID: <52591681.1020001@linux.com>
References: <522C1AC5.4080105@linux.com>	<522E9982.2060504@gmail.com>	<52347C24.8060102@linux.com>	<CADLC3L3tGG4yGZKir2pPzMYeddPjSFuD77u87C=YYEqtVn908Q@mail.gmail.com>	<523887BC.50704@linux.com>	<CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>	<523D4C4C.5070400@linux.com>	<CADLC3L3WCMWc4kuJ1-_GbFinEyCABuuh3Fonh641SptsfYDaeA@mail.gmail.com>	<523E989F.5040800@linux.com>	<CADLC3L2HO5R9jhBcz+L7d6kry6c+spJ+YMW7FW=o79VU2Xb=9A@mail.gmail.com>	<524586F9.6030406@linux.com>	<CADLC3L1HdD4xV64AWN0bO-2GizUMhwfwY5PZsLZN0eQ=4yFyXA@mail.gmail.com>	<52471600.4090908@linux.com>	<CADLC3L0nr3FmyEikG+Vev18mskR7XbfMAqPStLoj8BaEPNX3qA@mail.gmail.com>	<CADLC3L3Bcv8B90eyroU7NemkHT3omechwP=0BCR3EG0Ko53yUg@mail.gmail.com>	<52582250.5040701@linux.com> <CADLC3L0fieYC3tkEj3DnD6fvQNNHga-92etYh1vC6ajV
 JrEnHA@mail.gmail.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:35392 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab3JLJ3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Oct 2013 05:29:41 -0400
In-Reply-To: <CADLC3L0fieYC3tkEj3DnD6fvQNNHga-92etYh1vC6ajVJrEnHA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013-10-12 04:06 keltez=E9ssel, Robert Hancock =EDrta:
> On Fri, Oct 11, 2013 at 10:07 AM, Levente Kurusa <levex@linux.com> wr=
ote:
>> 2013-10-01 06:25 keltez=E9ssel, Robert Hancock =EDrta:
>>> On Sat, Sep 28, 2013 at 7:21 PM, Robert Hancock <hancockrwd@gmail.c=
om> wrote:
>>>> On Sat, Sep 28, 2013 at 11:46 AM, Levente Kurusa <levex@linux.com>=
 wrote:
>>>>> 2013-09-28 06:55 keltez=E9ssel, Robert Hancock =EDrta:
>>>>>
>>>>>> On Fri, Sep 27, 2013 at 7:24 AM, Levente Kurusa <levex@linux.com=
> wrote:
>>>>>>>
>>>>>>> 2013-09-25 08:31 keltez=E9ssel, Robert Hancock =EDrta:
>>>>>>>
>>>>>>>> On Sun, Sep 22, 2013 at 1:13 AM, Levente Kurusa <levex@linux.c=
om> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2013-09-21 19:04 keltez=E9ssel, Robert Hancock =EDrta:
>>>>>>>>>
>>>>>>>>>> On Sat, Sep 21, 2013 at 1:35 AM, Levente Kurusa <levex@linux=
=2Ecom>
>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The following dmesg is stuck in an infinite loop.
>>>>>>>>>>>>>>>>> dmesg:
>>>>>>>>>>>>>>>>> ata3: lost interrupt (Status 0x50)
>>>>>>>>>>>>>>>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action=
 0x6
>>>>>>>>>>>>>>>>> frozen
>>>>>>>>>>>>>>>>> ata3.00: failed command: READ DMA
>>>>>>>>>>>>>>>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag =
0 dma 4096
>>>>>>>>>>>>>>>>> in
>>>>>>>>>>>>>>>>>                     res 40/00:00:00:00:00/00:00:00:00=
:00/00
>>>>>>>>>>>>>>>>> Emask
>>>>>>>>>>>>>>>>> 0x4
>>>>>>>>>>>>>>>>> (timeout)
>>>>>>>>>>>>>>>>> ata3.00: status: { DRDY }
>>>>>>>>>>>>>>>>> ata3: soft resetting link
>>>>>>>>>>>>>>>>> ata3.00: configured for UDMA/33 (no error)
>>>>>>>>>>>>>>>>> ata3.00: device reported invalid CHS sector 0
>>>>>>>>>>>>>>>>> ata3: EH complete
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Patch that fixes the infinite loop:
>>>>>>>>>>>>>>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/li=
bata-eh.c
>>>>>>>>>>>>>>>>> index f9476fb..eeedf80 100644
>>>>>>>>>>>>>>>>> --- a/drivers/ata/libata-eh.c
>>>>>>>>>>>>>>>>> +++ b/drivers/ata/libata-eh.c
>>>>>>>>>>>>>>>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link_report=
(struct
>>>>>>>>>>>>>>>>> ata_link
>>>>>>>>>>>>>>>>> *link)
>>>>>>>>>>>>>>>>>                                   ehc->i.action, froz=
en,
>>>>>>>>>>>>>>>>> tries_buf);
>>>>>>>>>>>>>>>>>                       if (desc)
>>>>>>>>>>>>>>>>>                               ata_dev_err(ehc->i.dev,=
 "%s\n",
>>>>>>>>>>>>>>>>> desc);
>>>>>>>>>>>>>>>>> +               ehc->i.dev->exce_cnt ++;
>>>>>>>>>>>>>>>>> +               ata_dev_warn(ehc->i.dev, "Number of e=
xceptions:
>>>>>>>>>>>>>>>>> %d\n",
>>>>>>>>>>>>>>>>> ehc->i.dev->exce_cnt);
>>>>>>>>>>>>>>>>> +               /**
>>>>>>>>>>>>>>>>> +                  * The device is failing terribly,
>>>>>>>>>>>>>>>>> +                 * disable it to prevent damage.
>>>>>>>>>>>>>>>>> +                 */
>>>>>>>>>>>>>>>>> +               if(ehc->i.dev->exce_cnt > 2)
>>>>>>>>>>>>>>>>> +                       ata_dev_disable(ehc->i.dev);
>>>>>>>>>>>>>>>>>               } else {
>>>>>>>>>>>>>>>>>                       ata_link_err(link, "exception E=
mask 0x%x
>>>>>>>>>>>>>>>>> "
>>>>>>>>>>>>>>>>>                                    "SAct 0x%x SErr 0x=
%x action
>>>>>>>>>>>>>>>>> 0x%x%s%s\n",
>>>>>>>>>>>>>>>>> diff --git a/include/linux/libata.h b/include/linux/l=
ibata.h
>>>>>>>>>>>>>>>>> index eae7a05..fa52ee6 100644
>>>>>>>>>>>>>>>>> --- a/include/linux/libata.h
>>>>>>>>>>>>>>>>> +++ b/include/linux/libata.h
>>>>>>>>>>>>>>>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>>>>>>>>>>>>>>>               u8
>>>>>>>>>>>>>>>>> devslp_timing[ATA_LOG_DEVSLP_SIZE];
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>               /* error history */
>>>>>>>>>>>>>>>>> -       int                     spdn_cnt;
>>>>>>>>>>>>>>>>> +       int                     spdn_cnt; /* Number o=
f
>>>>>>>>>>>>>>>>> speed_downs
>>>>>>>>>>>>>>>>> */
>>>>>>>>>>>>>>>>> +       int                     exce_cnt; /* Number o=
f
>>>>>>>>>>>>>>>>> exceptions
>>>>>>>>>>>>>>>>> that
>>>>>>>>>>>>>>>>> happenned */
>>>>>>>>>>>>>>>>>               /* ering is CLEAR_END, read comment abo=
ve
>>>>>>>>>>>>>>>>> CLEAR_END
>>>>>>>>>>>>>>>>> */
>>>>>>>>>>>>>>>>>               struct ata_ering        ering;
>>>>>>>>>>>>>>>>>        };
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This doesn't seem like a very good fix. It may prevent=
 the
>>>>>>>>>>>>>>>> apparent
>>>>>>>>>>>>>>>> infinite loop but will just prevent that device from f=
unctioning
>>>>>>>>>>>>>>>> at
>>>>>>>>>>>>>>>> all.
>>>>>>>>>>>>>>>> It would be better if we could figure out what was act=
ually
>>>>>>>>>>>>>>>> going
>>>>>>>>>>>>>>>> wrong.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I have tested the problem with three different computer=
s, all
>>>>>>>>>>>>>>> switched
>>>>>>>>>>>>>>> to legacy/IDE/compatibility mode, and they didn't have =
this
>>>>>>>>>>>>>>> problem.
>>>>>>>>>>>>>>> Of
>>>>>>>>>>>>>>> course, they could have been set to AHCI mode, and ther=
e the
>>>>>>>>>>>>>>> kernel
>>>>>>>>>>>>>>> would
>>>>>>>>>>>>>>> boot normally. Feels strange, but so far I was only abl=
e to
>>>>>>>>>>>>>>> reproduce
>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>> problem with a Toshiba MK8052GSX. On the topic of my pa=
tch, I
>>>>>>>>>>>>>>> still
>>>>>>>>>>>>>>> don't
>>>>>>>>>>>>>>> see why a device which fails so terribly that it report=
s 3
>>>>>>>>>>>>>>> exceptions
>>>>>>>>>>>>>>> shouldn't be disabled. Like in this case, it could caus=
e infinite
>>>>>>>>>>>>>>> loops.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The problem is that this could happen in some cases when=
 you
>>>>>>>>>>>>>> wouldn't
>>>>>>>>>>>>>> want to disable the device, like an error that just happ=
ens
>>>>>>>>>>>>>> sporadically and works on retry, or a device you're tryi=
ng to
>>>>>>>>>>>>>> recover
>>>>>>>>>>>>>> data from.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> What do you think if I edit the patch in a way, that when=
 an
>>>>>>>>>>>>> operation
>>>>>>>>>>>>> successfully completes, it resets exce_cnt to zero. Might=
 as well
>>>>>>>>>>>>> add
>>>>>>>>>>>>> a
>>>>>>>>>>>>> module_param, which can set the maximum value of exce_cnt=
, while
>>>>>>>>>>>>> having
>>>>>>>>>>>>> zero
>>>>>>>>>>>>> as an option to never disable the device. Please don't th=
ink me
>>>>>>>>>>>>> wrong,
>>>>>>>>>>>>> I
>>>>>>>>>>>>> don't want to force this patch, I just want to learn how =
all this
>>>>>>>>>>>>> works,
>>>>>>>>>>>>> and
>>>>>>>>>>>>> in the process try to make it better. :-)
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> That would be better, but I think you're still going to ha=
ve an
>>>>>>>>>>>> issue
>>>>>>>>>>>> with what magic number to pick to avoid disabling devices
>>>>>>>>>>>> inappropriately.
>>>>>>>>>>>>
>>>>>>>>>>>> Conceptually, disabling the device doesn't really make sen=
se anyway.
>>>>>>>>>>>> If someone in userspace wants to keep trying to read from =
that
>>>>>>>>>>>> device,
>>>>>>>>>>>> why would you stop them because of some arbitrary judgemen=
t? The
>>>>>>>>>>>> kernel itself isn't "locked up" during this process, anyth=
ing not
>>>>>>>>>>>> blocked on I/O to that device should be able to continue r=
unning, so
>>>>>>>>>>>> that process is only hurting itself. If the system fails t=
o boot
>>>>>>>>>>>> from
>>>>>>>>>>>> another device due to this, this would likely point out so=
me kind of
>>>>>>>>>>>> problem in userspace or the distro boot process being over=
ly
>>>>>>>>>>>> serialized.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I have been booting up with the initramfs from ubuntu 13.04=
,
>>>>>>>>>>> and I have also tried to boot with the ubuntu install cd. T=
hey
>>>>>>>>>>> couldn't
>>>>>>>>>>> continue the boot process. I'm gonna spend the weekend tryi=
ng to
>>>>>>>>>>> figure
>>>>>>>>>>> out where and why the interrupts don't happen. Whether it b=
e a
>>>>>>>>>>> routing
>>>>>>>>>>> or a hardware issue, which I highly doubt due to the fact t=
hat
>>>>>>>>>>> Windows
>>>>>>>>>>> XP SP2 was able to boot up without errors.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Are you able to get out full dmesg output from a boot attemp=
t and the
>>>>>>>>>> contents of /proc/interrupts?
>>>>>>>>>>
>>>>>>>>> As I said before, I am not able to get to the shell, without =
my
>>>>>>>>> 'symptom
>>>>>>>>> cure'. With my patch I get the following dmesg output, with
>>>>>>>>> some of my debug messages turned off:
>>>>>>>>> http://pastebin.com/5eb5G3Dx
>>>>>>>>> /proc/interrupts is here:
>>>>>>>>> http://pastebin.com/84CJey2D
>>>>>>>>> After yesterday's research, I have come to ata_piix.c . That =
file looks
>>>>>>>>> like
>>>>>>>>> the real culprit, as my netbook's controller is an Intel ICH7=
M one,
>>>>>>>>> The values I am getting from the device are very different th=
an those
>>>>>>>>> that are expected.
>>>>>>>>>
>>>>>>>>> Things I have noticed, but ignored in dmesg:
>>>>>>>>> There is a stack dump, because nobody cared about IRQ#20. I h=
ave
>>>>>>>>> ignored
>>>>>>>>> this because it is the EHCI IRQ, and I suppose it has nothing=
 to do
>>>>>>>>> with
>>>>>>>>> ata. The problem is with ata3 or /dev/sdc, while the IRQ happ=
ens
>>>>>>>>> with /dev/sda, which works fine.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> I think it is likely related to the problem. The kernel thinks=
 this
>>>>>>>> controller is on IRQ 16, but apparently something is raising
>>>>>>>> un-acknowledged interrupts on IRQ 20 and nothing is coming in =
on IRQ
>>>>>>>> 16. It seems quite likely that this is actually the ATA contro=
ller.
>>>>>>>>
>>>>>>>> You mentioned that Windows XP was able to work in this mode. I=
 wonder
>>>>>>>> if it was using the IOAPIC, as if not then the IRQ routing is
>>>>>>>> different which might mask the problem. Do you know what IRQ D=
evice
>>>>>>>> Manager reported for this controller in Windows? And was it us=
ing any
>>>>>>>> IRQs over 15 (which would indicate the IOAPIC was in use)?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hmm, according to WinXP's Device manager for this controller,
>>>>>>> it listens to IRQ# 20, and therefore it is using the I/O APIC.
>>>>>>> Now, one question remains where is the error that mismaps
>>>>>>> controller?
>>>>>>> I have created a simple patch which seems to fix this:
>>>>>>> ---
>>>>>>> @@ -1704,6 +1767,8 @@ static int piix_init_one(struct pci_dev *=
pdev,
>>>>>>> const
>>>>>>> struct pci_device_id *ent)
>>>>>>>                  hpriv->map =3D piix_init_sata_map(pdev, port_i=
nfo,
>>>>>>>
>>>>>>> piix_map_db_table[ent->driver_data]);
>>>>>>>
>>>>>>> +       if(pdev->vendor =3D=3D 0x8086 && pdev->device =3D=3D 0x=
27C4)
>>>>>>> +               pdev->irq =3D 20;
>>>>>>>          rc =3D ata_pci_bmdma_prepare_host(pdev, ppi, &host);
>>>>>>>          if (rc)
>>>>>>>                  return rc;
>>>>>>>
>>>>>>> However, I am more than sure that this is not the way
>>>>>>> to solve this problem. Do you have any idea on where
>>>>>>> the ideal place would be to implement a fix?
>>>>>>> According to specs of ICH7M, which is essentially the
>>>>>>> same as ICH6M, we need to check on what interrupt pin
>>>>>>> is the SATA controller, and after that check which IRQ line
>>>>>>> is connected to the I/O APIC and decide the IRQ's number
>>>>>>> on those findings.
>>>>>>>
>>>>>>> Specs of ICH7:
>>>>>>>
>>>>>>> http://www.intel.com/content/dam/doc/datasheet/i-o-controller-h=
ub-7-datasheet.pdf
>>>>>>> Device 31 Interrupt Route Register: Chapter 7.1.46
>>>>>>> Device 31 Interrupt Pin Register: Chapter 7.1.41
>>>>>>>
>>>>>>> The SATA controller is always Device 31.
>>>>>>
>>>>>>
>>>>>> It would appear that something is messing up with the ACPI IRQ r=
outing
>>>>>> on this machine that's causing us to think the controller is on =
the
>>>>>> wrong IRQ. CCing the linux-acpi list to see if anyone has some
>>>>>> additional debugging suggestions. I suspect that dumping the DSD=
T is
>>>>>> likely the first step though. If you can get IASL installed, you=
 can
>>>>>> do something like:
>>>>>>
>>>>>> cat /sys/firmware/acpi/tables/DSDT > dsdt.aml
>>>>>> iasl -d dsdt.aml
>>>>>>
>>>>>> That should spit out a dsdt.dsl file which would hopefully have =
the
>>>>>> info needed to figure out what's going on.
>>>>>>
>>>>>
>>>>> Here is the disassembled DSDT table:
>>>>> http://pastebin.com/LWNVht9H
>>>>> The SATA controller is at line 5206.
>>>>> I also disassembled the SSDT, but nothing interesting was there:
>>>>> http://pastebin.com/fus5sxU8
>>>>>
>>>>> I disabled the usage of ACPI for IRQs with acpi=3Dnoirq,
>>>>> and it successfully booted up setting itself to IRQ#3.
>>>>> This makes me think that this is the BIOS's fault.
>>>>> I think it would be possible to create a DMI check
>>>>> and forcibly set the irq to 20 if the DMI matches.
>>>>> Any comments on this?
>>>>
>>>> The BIOS may be doing something funky, but since Windows apparentl=
y
>>>> can figure out it's on IRQ 20, Linux presumably should be able to =
as
>>>> well. DMI checks should be the last resort - Windows almost certai=
nly
>>>> doesn't have any machine-specific logic here, and it's hard to tel=
l
>>>> what other machine models could be affected. With ACPI stuff, we
>>>> generally just need to do the same thing Windows does for things t=
o
>>>> work reliably, and DMI checks are more of a hack workaround than a
>>>> real fix.
>>>>
>>>> I'll try and have a look at the DSDT within the next few days and =
see
>>>> if I can figure anything out, unless someone beats me to it.
>>>
>>> I haven't gone into too much detail, but one thing I noticed with t=
he
>>> DSDT is that there appear to be some _OSI checks for Windows 2006
>>> (i.e. Vista) that seem to affect various things, including potentia=
lly
>>> the PCI IRQ routing table. It's possible that their IRQ routing tab=
le
>>> is broken for legacy mode with an ACPI OS supporting Vista (as curr=
ent
>>> Linux versions do). Could be this slipped through testing if they o=
nly
>>> tested AHCI mode with Vista installed.
>>>
>>> You can try booting with the kernel parameters
>>>
>>> acpi_osi=3D! acpi_osi=3D"Windows 2001 SP3"
>>>
>>> That should make the BIOS think we are Windows XP and bypass the Vi=
sta
>>> code path. If that works, then you might want to check for a BIOS
>>> update on this machine.
>>>
>>
>> First of all, sorry for the late reply. I was kinda busy.
>>
>> I tried what you suggested but unfortunately the problem persists.
>> This makes me believe that Windows XP does have somekind of DMI chec=
k here.
>> Of course, while a BIOS update may solve this, I would prefer that L=
inux
>> should also be able to boot up with this broken BIOS as well.
>>
>> If you are certain that WinXP doesn't use DMI checks,
>> it could be that WinXP's driver of ICH7M's SATA controller applies
>> a quirk and sets that irq line to #20.
>=20
> Can you post the dmesg output from a bootup attempt with those option=
s?
>=20
> You may also want to try adding just: acpi_osi=3D!
>=20

None of the 3 possible combinations succeeded to boot.

Here are a couple of dmesgs:

Params: acpi_osi=3D"Windows 2001 SP3"
http://pastebin.com/vF3BSuhc

Params: acpi_osi=3D! acpi_osi=3D"Windows 2001 SP3"
http://pastebin.com/BuUzc3es

Params: acpi_osi=3D!
http://pastebin.com/u7uRx8Ru


--=20
Regards,
Levente Kurusa
