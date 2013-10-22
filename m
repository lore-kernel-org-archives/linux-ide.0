From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] BIOS SATA legacy mode failure
Date: Tue, 22 Oct 2013 16:32:07 +0200
Message-ID: <52668C67.60509@linux.com>
References: <522C1AC5.4080105@linux.com>	<523887BC.50704@linux.com>	<CADLC3L1LkeW-GT5A=dtT3JMfcTAoPjOCwKhusNOhQ+9FVz_-fQ@mail.gmail.com>	<523D4C4C.5070400@linux.com>	<CADLC3L3WCMWc4kuJ1-_GbFinEyCABuuh3Fonh641SptsfYDaeA@mail.gmail.com>	<523E989F.5040800@linux.com>	<CADLC3L2HO5R9jhBcz+L7d6kry6c+spJ+YMW7FW=o79VU2Xb=9A@mail.gmail.com>	<524586F9.6030406@linux.com>	<CADLC3L1HdD4xV64AWN0bO-2GizUMhwfwY5PZsLZN0eQ=4yFyXA@mail.gmail.com>	<52471600.4090908@linux.com>	<CADLC3L0nr3FmyEikG+Vev18mskR7XbfMAqPStLoj8BaEPNX3qA@mail.gmail.com>	<CADLC3L3Bcv8B90eyroU7NemkHT3omechwP=0BCR3EG0Ko53yUg@mail.gmail.com>	<52582250.5040701@linux.com>	<CADLC3L0fieYC3tkEj3DnD6fvQNNHga-92etYh1vC6ajVJrEnHA@mail.gmail.com>	<52591 681.1020001@linux.com>	<CADLC3L2hfLrCiMNPGMpcYrio17rmo7uXaBLy4R6FgpW=P=0VWA@mail.gmail.com>	<525A
 8BC9.2000306@linux.com> <CADLC3L1ckJeussKQ5mh5vhAb6bsTOi+pLnPh9sju+7tFnKzm7g@mail.gmail.com> <525EA5E4.1000008@linux.com> <5265D618.5060709@gmail.com> <5265DF0A.5020102@intel.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5265DF0A.5020102@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

2013-10-22 04:12 keltez=C3=A9ssel, Aaron Lu =C3=ADrta:
> On 10/22/2013 09:34 AM, Robert Hancock wrote:
>> On 10/16/2013 08:42 AM, Levente Kurusa wrote:
>>> 2013-10-16 02:16 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
>>>> On Sun, Oct 13, 2013 at 6:02 AM, Levente Kurusa <levex@linux.com> =
wrote:
>>>>> 2013-10-13 07:57 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
>>>>>> On Sat, Oct 12, 2013 at 3:29 AM, Levente Kurusa <levex@linux.com=
> wrote:
>>>>>>> 2013-10-12 04:06 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
>>>>>>>> On Fri, Oct 11, 2013 at 10:07 AM, Levente Kurusa <levex@linux.=
com> wrote:
>>>>>>>>> 2013-10-01 06:25 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
>>>>>>>>>> On Sat, Sep 28, 2013 at 7:21 PM, Robert Hancock <hancockrwd@=
gmail.com> wrote:
>>>>>>>>>>> On Sat, Sep 28, 2013 at 11:46 AM, Levente Kurusa <levex@lin=
ux.com> wrote:
>>>>>>>>>>>> 2013-09-28 06:55 keltez=C3=A9ssel, Robert Hancock =C3=ADrt=
a:
>>>>>>>>>>>>
>>>>>>>>>>>>> On Fri, Sep 27, 2013 at 7:24 AM, Levente Kurusa <levex@li=
nux.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 2013-09-25 08:31 keltez=C3=A9ssel, Robert Hancock =C3=AD=
rta:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Sun, Sep 22, 2013 at 1:13 AM, Levente Kurusa <levex@=
linux.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> 2013-09-21 19:04 keltez=C3=A9ssel, Robert Hancock =C3=AD=
rta:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Sat, Sep 21, 2013 at 1:35 AM, Levente Kurusa <leve=
x@linux.com>
>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> The following dmesg is stuck in an infinite lo=
op.
>>>>>>>>>>>>>>>>>>>>>>>> dmesg:
>>>>>>>>>>>>>>>>>>>>>>>> ata3: lost interrupt (Status 0x50)
>>>>>>>>>>>>>>>>>>>>>>>> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0=
 action 0x6
>>>>>>>>>>>>>>>>>>>>>>>> frozen
>>>>>>>>>>>>>>>>>>>>>>>> ata3.00: failed command: READ DMA
>>>>>>>>>>>>>>>>>>>>>>>> ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/=
e0 tag 0 dma 4096
>>>>>>>>>>>>>>>>>>>>>>>> in
>>>>>>>>>>>>>>>>>>>>>>>>                     res 40/00:00:00:00:00/00:0=
0:00:00:00/00
>>>>>>>>>>>>>>>>>>>>>>>> Emask
>>>>>>>>>>>>>>>>>>>>>>>> 0x4
>>>>>>>>>>>>>>>>>>>>>>>> (timeout)
>>>>>>>>>>>>>>>>>>>>>>>> ata3.00: status: { DRDY }
>>>>>>>>>>>>>>>>>>>>>>>> ata3: soft resetting link
>>>>>>>>>>>>>>>>>>>>>>>> ata3.00: configured for UDMA/33 (no error)
>>>>>>>>>>>>>>>>>>>>>>>> ata3.00: device reported invalid CHS sector 0
>>>>>>>>>>>>>>>>>>>>>>>> ata3: EH complete
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Patch that fixes the infinite loop:
>>>>>>>>>>>>>>>>>>>>>>>> diff --git a/drivers/ata/libata-eh.c b/drivers=
/ata/libata-eh.c
>>>>>>>>>>>>>>>>>>>>>>>> index f9476fb..eeedf80 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/ata/libata-eh.c
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/ata/libata-eh.c
>>>>>>>>>>>>>>>>>>>>>>>> @@ -2437,6 +2437,14 @@ static void ata_eh_link=
_report(struct
>>>>>>>>>>>>>>>>>>>>>>>> ata_link
>>>>>>>>>>>>>>>>>>>>>>>> *link)
>>>>>>>>>>>>>>>>>>>>>>>>                                   ehc->i.actio=
n, frozen,
>>>>>>>>>>>>>>>>>>>>>>>> tries_buf);
>>>>>>>>>>>>>>>>>>>>>>>>                       if (desc)
>>>>>>>>>>>>>>>>>>>>>>>>                               ata_dev_err(ehc-=
>i.dev, "%s\n",
>>>>>>>>>>>>>>>>>>>>>>>> desc);
>>>>>>>>>>>>>>>>>>>>>>>> +               ehc->i.dev->exce_cnt ++;
>>>>>>>>>>>>>>>>>>>>>>>> +               ata_dev_warn(ehc->i.dev, "Numb=
er of exceptions:
>>>>>>>>>>>>>>>>>>>>>>>> %d\n",
>>>>>>>>>>>>>>>>>>>>>>>> ehc->i.dev->exce_cnt);
>>>>>>>>>>>>>>>>>>>>>>>> +               /**
>>>>>>>>>>>>>>>>>>>>>>>> +                  * The device is failing ter=
ribly,
>>>>>>>>>>>>>>>>>>>>>>>> +                 * disable it to prevent dama=
ge.
>>>>>>>>>>>>>>>>>>>>>>>> +                 */
>>>>>>>>>>>>>>>>>>>>>>>> +               if(ehc->i.dev->exce_cnt > 2)
>>>>>>>>>>>>>>>>>>>>>>>> +                       ata_dev_disable(ehc->i=
=2Edev);
>>>>>>>>>>>>>>>>>>>>>>>>               } else {
>>>>>>>>>>>>>>>>>>>>>>>>                       ata_link_err(link, "exce=
ption Emask 0x%x
>>>>>>>>>>>>>>>>>>>>>>>> "
>>>>>>>>>>>>>>>>>>>>>>>>                                    "SAct 0x%x =
SErr 0x%x action
>>>>>>>>>>>>>>>>>>>>>>>> 0x%x%s%s\n",
>>>>>>>>>>>>>>>>>>>>>>>> diff --git a/include/linux/libata.h b/include/=
linux/libata.h
>>>>>>>>>>>>>>>>>>>>>>>> index eae7a05..fa52ee6 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/include/linux/libata.h
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/include/linux/libata.h
>>>>>>>>>>>>>>>>>>>>>>>> @@ -660,7 +660,8 @@ struct ata_device {
>>>>>>>>>>>>>>>>>>>>>>>>               u8
>>>>>>>>>>>>>>>>>>>>>>>> devslp_timing[ATA_LOG_DEVSLP_SIZE];
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>               /* error history */
>>>>>>>>>>>>>>>>>>>>>>>> -       int                     spdn_cnt;
>>>>>>>>>>>>>>>>>>>>>>>> +       int                     spdn_cnt; /* N=
umber of
>>>>>>>>>>>>>>>>>>>>>>>> speed_downs
>>>>>>>>>>>>>>>>>>>>>>>> */
>>>>>>>>>>>>>>>>>>>>>>>> +       int                     exce_cnt; /* N=
umber of
>>>>>>>>>>>>>>>>>>>>>>>> exceptions
>>>>>>>>>>>>>>>>>>>>>>>> that
>>>>>>>>>>>>>>>>>>>>>>>> happenned */
>>>>>>>>>>>>>>>>>>>>>>>>               /* ering is CLEAR_END, read comm=
ent above
>>>>>>>>>>>>>>>>>>>>>>>> CLEAR_END
>>>>>>>>>>>>>>>>>>>>>>>> */
>>>>>>>>>>>>>>>>>>>>>>>>               struct ata_ering        ering;
>>>>>>>>>>>>>>>>>>>>>>>>        };
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> This doesn't seem like a very good fix. It may =
prevent the
>>>>>>>>>>>>>>>>>>>>>>> apparent
>>>>>>>>>>>>>>>>>>>>>>> infinite loop but will just prevent that device=
 from functioning
>>>>>>>>>>>>>>>>>>>>>>> at
>>>>>>>>>>>>>>>>>>>>>>> all.
>>>>>>>>>>>>>>>>>>>>>>> It would be better if we could figure out what =
was actually
>>>>>>>>>>>>>>>>>>>>>>> going
>>>>>>>>>>>>>>>>>>>>>>> wrong.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> I have tested the problem with three different c=
omputers, all
>>>>>>>>>>>>>>>>>>>>>> switched
>>>>>>>>>>>>>>>>>>>>>> to legacy/IDE/compatibility mode, and they didn'=
t have this
>>>>>>>>>>>>>>>>>>>>>> problem.
>>>>>>>>>>>>>>>>>>>>>> Of
>>>>>>>>>>>>>>>>>>>>>> course, they could have been set to AHCI mode, a=
nd there the
>>>>>>>>>>>>>>>>>>>>>> kernel
>>>>>>>>>>>>>>>>>>>>>> would
>>>>>>>>>>>>>>>>>>>>>> boot normally. Feels strange, but so far I was o=
nly able to
>>>>>>>>>>>>>>>>>>>>>> reproduce
>>>>>>>>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>>>>>>>>> problem with a Toshiba MK8052GSX. On the topic o=
f my patch, I
>>>>>>>>>>>>>>>>>>>>>> still
>>>>>>>>>>>>>>>>>>>>>> don't
>>>>>>>>>>>>>>>>>>>>>> see why a device which fails so terribly that it=
 reports 3
>>>>>>>>>>>>>>>>>>>>>> exceptions
>>>>>>>>>>>>>>>>>>>>>> shouldn't be disabled. Like in this case, it cou=
ld cause infinite
>>>>>>>>>>>>>>>>>>>>>> loops.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> The problem is that this could happen in some cas=
es when you
>>>>>>>>>>>>>>>>>>>>> wouldn't
>>>>>>>>>>>>>>>>>>>>> want to disable the device, like an error that ju=
st happens
>>>>>>>>>>>>>>>>>>>>> sporadically and works on retry, or a device you'=
re trying to
>>>>>>>>>>>>>>>>>>>>> recover
>>>>>>>>>>>>>>>>>>>>> data from.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> What do you think if I edit the patch in a way, th=
at when an
>>>>>>>>>>>>>>>>>>>> operation
>>>>>>>>>>>>>>>>>>>> successfully completes, it resets exce_cnt to zero=
=2E Might as well
>>>>>>>>>>>>>>>>>>>> add
>>>>>>>>>>>>>>>>>>>> a
>>>>>>>>>>>>>>>>>>>> module_param, which can set the maximum value of e=
xce_cnt, while
>>>>>>>>>>>>>>>>>>>> having
>>>>>>>>>>>>>>>>>>>> zero
>>>>>>>>>>>>>>>>>>>> as an option to never disable the device. Please d=
on't think me
>>>>>>>>>>>>>>>>>>>> wrong,
>>>>>>>>>>>>>>>>>>>> I
>>>>>>>>>>>>>>>>>>>> don't want to force this patch, I just want to lea=
rn how all this
>>>>>>>>>>>>>>>>>>>> works,
>>>>>>>>>>>>>>>>>>>> and
>>>>>>>>>>>>>>>>>>>> in the process try to make it better. :-)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> That would be better, but I think you're still goin=
g to have an
>>>>>>>>>>>>>>>>>>> issue
>>>>>>>>>>>>>>>>>>> with what magic number to pick to avoid disabling d=
evices
>>>>>>>>>>>>>>>>>>> inappropriately.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Conceptually, disabling the device doesn't really m=
ake sense anyway.
>>>>>>>>>>>>>>>>>>> If someone in userspace wants to keep trying to rea=
d from that
>>>>>>>>>>>>>>>>>>> device,
>>>>>>>>>>>>>>>>>>> why would you stop them because of some arbitrary j=
udgement? The
>>>>>>>>>>>>>>>>>>> kernel itself isn't "locked up" during this process=
, anything not
>>>>>>>>>>>>>>>>>>> blocked on I/O to that device should be able to con=
tinue running, so
>>>>>>>>>>>>>>>>>>> that process is only hurting itself. If the system =
fails to boot
>>>>>>>>>>>>>>>>>>> from
>>>>>>>>>>>>>>>>>>> another device due to this, this would likely point=
 out some kind of
>>>>>>>>>>>>>>>>>>> problem in userspace or the distro boot process bei=
ng overly
>>>>>>>>>>>>>>>>>>> serialized.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I have been booting up with the initramfs from ubunt=
u 13.04,
>>>>>>>>>>>>>>>>>> and I have also tried to boot with the ubuntu instal=
l cd. They
>>>>>>>>>>>>>>>>>> couldn't
>>>>>>>>>>>>>>>>>> continue the boot process. I'm gonna spend the weeke=
nd trying to
>>>>>>>>>>>>>>>>>> figure
>>>>>>>>>>>>>>>>>> out where and why the interrupts don't happen. Wheth=
er it be a
>>>>>>>>>>>>>>>>>> routing
>>>>>>>>>>>>>>>>>> or a hardware issue, which I highly doubt due to the=
 fact that
>>>>>>>>>>>>>>>>>> Windows
>>>>>>>>>>>>>>>>>> XP SP2 was able to boot up without errors.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Are you able to get out full dmesg output from a boot=
 attempt and the
>>>>>>>>>>>>>>>>> contents of /proc/interrupts?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> As I said before, I am not able to get to the shell, w=
ithout my
>>>>>>>>>>>>>>>> 'symptom
>>>>>>>>>>>>>>>> cure'. With my patch I get the following dmesg output,=
 with
>>>>>>>>>>>>>>>> some of my debug messages turned off:
>>>>>>>>>>>>>>>> http://pastebin.com/5eb5G3Dx
>>>>>>>>>>>>>>>> /proc/interrupts is here:
>>>>>>>>>>>>>>>> http://pastebin.com/84CJey2D
>>>>>>>>>>>>>>>> After yesterday's research, I have come to ata_piix.c =
=2E That file looks
>>>>>>>>>>>>>>>> like
>>>>>>>>>>>>>>>> the real culprit, as my netbook's controller is an Int=
el ICH7M one,
>>>>>>>>>>>>>>>> The values I am getting from the device are very diffe=
rent than those
>>>>>>>>>>>>>>>> that are expected.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Things I have noticed, but ignored in dmesg:
>>>>>>>>>>>>>>>> There is a stack dump, because nobody cared about IRQ#=
20. I have
>>>>>>>>>>>>>>>> ignored
>>>>>>>>>>>>>>>> this because it is the EHCI IRQ, and I suppose it has =
nothing to do
>>>>>>>>>>>>>>>> with
>>>>>>>>>>>>>>>> ata. The problem is with ata3 or /dev/sdc, while the I=
RQ happens
>>>>>>>>>>>>>>>> with /dev/sda, which works fine.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I think it is likely related to the problem. The kernel=
 thinks this
>>>>>>>>>>>>>>> controller is on IRQ 16, but apparently something is ra=
ising
>>>>>>>>>>>>>>> un-acknowledged interrupts on IRQ 20 and nothing is com=
ing in on IRQ
>>>>>>>>>>>>>>> 16. It seems quite likely that this is actually the ATA=
 controller.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> You mentioned that Windows XP was able to work in this =
mode. I wonder
>>>>>>>>>>>>>>> if it was using the IOAPIC, as if not then the IRQ rout=
ing is
>>>>>>>>>>>>>>> different which might mask the problem. Do you know wha=
t IRQ Device
>>>>>>>>>>>>>>> Manager reported for this controller in Windows? And wa=
s it using any
>>>>>>>>>>>>>>> IRQs over 15 (which would indicate the IOAPIC was in us=
e)?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hmm, according to WinXP's Device manager for this contro=
ller,
>>>>>>>>>>>>>> it listens to IRQ# 20, and therefore it is using the I/O=
 APIC.
>>>>>>>>>>>>>> Now, one question remains where is the error that mismap=
s
>>>>>>>>>>>>>> controller?
>>>>>>>>>>>>>> I have created a simple patch which seems to fix this:
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> @@ -1704,6 +1767,8 @@ static int piix_init_one(struct pc=
i_dev *pdev,
>>>>>>>>>>>>>> const
>>>>>>>>>>>>>> struct pci_device_id *ent)
>>>>>>>>>>>>>>                  hpriv->map =3D piix_init_sata_map(pdev,=
 port_info,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> piix_map_db_table[ent->driver_data]);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> +       if(pdev->vendor =3D=3D 0x8086 && pdev->device =3D=
=3D 0x27C4)
>>>>>>>>>>>>>> +               pdev->irq =3D 20;
>>>>>>>>>>>>>>          rc =3D ata_pci_bmdma_prepare_host(pdev, ppi, &h=
ost);
>>>>>>>>>>>>>>          if (rc)
>>>>>>>>>>>>>>                  return rc;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However, I am more than sure that this is not the way
>>>>>>>>>>>>>> to solve this problem. Do you have any idea on where
>>>>>>>>>>>>>> the ideal place would be to implement a fix?
>>>>>>>>>>>>>> According to specs of ICH7M, which is essentially the
>>>>>>>>>>>>>> same as ICH6M, we need to check on what interrupt pin
>>>>>>>>>>>>>> is the SATA controller, and after that check which IRQ l=
ine
>>>>>>>>>>>>>> is connected to the I/O APIC and decide the IRQ's number
>>>>>>>>>>>>>> on those findings.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Specs of ICH7:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> http://www.intel.com/content/dam/doc/datasheet/i-o-contr=
oller-hub-7-datasheet.pdf
>>>>>>>>>>>>>> Device 31 Interrupt Route Register: Chapter 7.1.46
>>>>>>>>>>>>>> Device 31 Interrupt Pin Register: Chapter 7.1.41
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The SATA controller is always Device 31.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> It would appear that something is messing up with the ACP=
I IRQ routing
>>>>>>>>>>>>> on this machine that's causing us to think the controller=
 is on the
>>>>>>>>>>>>> wrong IRQ. CCing the linux-acpi list to see if anyone has=
 some
>>>>>>>>>>>>> additional debugging suggestions. I suspect that dumping =
the DSDT is
>>>>>>>>>>>>> likely the first step though. If you can get IASL install=
ed, you can
>>>>>>>>>>>>> do something like:
>>>>>>>>>>>>>
>>>>>>>>>>>>> cat /sys/firmware/acpi/tables/DSDT > dsdt.aml
>>>>>>>>>>>>> iasl -d dsdt.aml
>>>>>>>>>>>>>
>>>>>>>>>>>>> That should spit out a dsdt.dsl file which would hopefull=
y have the
>>>>>>>>>>>>> info needed to figure out what's going on.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Here is the disassembled DSDT table:
>>>>>>>>>>>> http://pastebin.com/LWNVht9H
>>>>>>>>>>>> The SATA controller is at line 5206.
>>>>>>>>>>>> I also disassembled the SSDT, but nothing interesting was =
there:
>>>>>>>>>>>> http://pastebin.com/fus5sxU8
>>>>>>>>>>>>
>>>>>>>>>>>> I disabled the usage of ACPI for IRQs with acpi=3Dnoirq,
>>>>>>>>>>>> and it successfully booted up setting itself to IRQ#3.
>>>>>>>>>>>> This makes me think that this is the BIOS's fault.
>>>>>>>>>>>> I think it would be possible to create a DMI check
>>>>>>>>>>>> and forcibly set the irq to 20 if the DMI matches.
>>>>>>>>>>>> Any comments on this?
>>>>>>>>>>>
>>>>>>>>>>> The BIOS may be doing something funky, but since Windows ap=
parently
>>>>>>>>>>> can figure out it's on IRQ 20, Linux presumably should be a=
ble to as
>>>>>>>>>>> well. DMI checks should be the last resort - Windows almost=
 certainly
>>>>>>>>>>> doesn't have any machine-specific logic here, and it's hard=
 to tell
>>>>>>>>>>> what other machine models could be affected. With ACPI stuf=
f, we
>>>>>>>>>>> generally just need to do the same thing Windows does for t=
hings to
>>>>>>>>>>> work reliably, and DMI checks are more of a hack workaround=
 than a
>>>>>>>>>>> real fix.
>>>>>>>>>>>
>>>>>>>>>>> I'll try and have a look at the DSDT within the next few da=
ys and see
>>>>>>>>>>> if I can figure anything out, unless someone beats me to it=
=2E
>>>>>>>>>>
>>>>>>>>>> I haven't gone into too much detail, but one thing I noticed=
 with the
>>>>>>>>>> DSDT is that there appear to be some _OSI checks for Windows=
 2006
>>>>>>>>>> (i.e. Vista) that seem to affect various things, including p=
otentially
>>>>>>>>>> the PCI IRQ routing table. It's possible that their IRQ rout=
ing table
>>>>>>>>>> is broken for legacy mode with an ACPI OS supporting Vista (=
as current
>>>>>>>>>> Linux versions do). Could be this slipped through testing if=
 they only
>>>>>>>>>> tested AHCI mode with Vista installed.
>>>>>>>>>>
>>>>>>>>>> You can try booting with the kernel parameters
>>>>>>>>>>
>>>>>>>>>> acpi_osi=3D! acpi_osi=3D"Windows 2001 SP3"
>>>>>>>>>>
>>>>>>>>>> That should make the BIOS think we are Windows XP and bypass=
 the Vista
>>>>>>>>>> code path. If that works, then you might want to check for a=
 BIOS
>>>>>>>>>> update on this machine.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> First of all, sorry for the late reply. I was kinda busy.
>>>>>>>>>
>>>>>>>>> I tried what you suggested but unfortunately the problem pers=
ists.
>>>>>>>>> This makes me believe that Windows XP does have somekind of D=
MI check here.
>>>>>>>>> Of course, while a BIOS update may solve this, I would prefer=
 that Linux
>>>>>>>>> should also be able to boot up with this broken BIOS as well.
>>>>>>>>>
>>>>>>>>> If you are certain that WinXP doesn't use DMI checks,
>>>>>>>>> it could be that WinXP's driver of ICH7M's SATA controller ap=
plies
>>>>>>>>> a quirk and sets that irq line to #20.
>>>>>>>>
>>>>>>>> Can you post the dmesg output from a bootup attempt with those=
 options?
>>>>>>>>
>>>>>>>> You may also want to try adding just: acpi_osi=3D!
>>>>>>>>
>>>>>>>
>>>>>>> None of the 3 possible combinations succeeded to boot.
>>>>>>>
>>>>>>> Here are a couple of dmesgs:
>>>>>>>
>>>>>>> Params: acpi_osi=3D"Windows 2001 SP3"
>>>>>>> http://pastebin.com/vF3BSuhc
>>>>>>>
>>>>>>> Params: acpi_osi=3D! acpi_osi=3D"Windows 2001 SP3"
>>>>>>> http://pastebin.com/BuUzc3es
>>>>>>>
>>>>>>> Params: acpi_osi=3D!
>>>>>>> http://pastebin.com/u7uRx8Ru
>>>>>>
>>>>>> I'm not sure the option is actually taking effect properly. Ther=
e
>>>>>> should be a message "Disabled all _OSI OS vendors" that shows up=
 in
>>>>>> dmesg with the ! option. Can you try:
>>>>>>
>>>>>> acpi_osi=3D"!" acpi_osi=3D"Windows 2001 SP3"
>>>>>>
>>>>>> (with the quotes around the ! character).
>>>>>>
>>>>>
>>>>> The following command line worked:
>>>>> acpi_osi=3D acpi_osi=3D"Windows 2001 SP3"
>>>>>
>>>>> So, it seems that the BIOS is broken. Is there any way to fix thi=
s,
>>>>> without resorting to the hackish DMI checks?
>>>>
>>>> Probably not really. Have you checked for a newer BIOS version on =
this machine?
>>>>
>>>> If not, this is likely similar to a number of other systems listed=
 in
>>>> acpi_osi_dmi_table in drivers/acpi/blacklist.c which need to disab=
le
>>>> reporting Vista support.
>>>>
>>>
>>>
>>> Yup, the attached patch fixed it.
>>> I will post it a little bit later, mind if I add your signed-off-by=
 line? :)
>>>
>>> I would do a BIOS update and see if it was fixed there, but it seem=
s that Toshiba's
>>> BIOS updater and the BIOS itself causes more trouble than the probl=
ems fixed.
>>
>> Sorry for the delay. Seems OK to me. When you submit the patch you=20
>> should include a link to this thread to the commit message, so someo=
ne=20
>> in the future would have a hope of knowing why this quirk is in here=
=2E
>=20
> Yes, a comment explainning why this blacklist is needed and if that
> whole system _OSI change has any other negative effect on this system=
,
> e.g. does the hotkey for backlight/bluetooth/suspend/etc. still work?
>=20

Yes, everything is in the same state as it was pre-patch, but now IDE m=
ode
also works.

>> You can add my:
>>
>> Reviewed-by: Robert Hancock <hancockrwd@gmail.com>

Thank you, will add.

--=20
Regards,
Levente Kurusa
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
