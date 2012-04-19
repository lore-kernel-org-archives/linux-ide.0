From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Thu, 19 Apr 2012 19:28:02 +0200
Message-ID: <4F904B22.3080905@fold.natur.cuni.cz>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>  <4F8DD834.5070000@teksavvy.com> <4F8DDA53.206@teksavvy.com>  <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>  <4F8EF57E.4070603@fold.natur.cuni.cz> <4F8EF9F7.5040202@pobox.com>  <4F8EFD89.2080603@fold.natur.cuni.cz> <4F8F08D7.6050809@fold.natur.cuni.cz>  <CAF1ivSYqzjv10F+sdYkR_jdTZvzKP1=_ZwgNDj2njnmb6uaenA@mail.gmail.com> <1334823362.11188.172.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:56432 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755828Ab2DSR2H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Apr 2012 13:28:07 -0400
In-Reply-To: <1334823362.11188.172.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Jeff Garzik <jgarzik@pobox.com>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Gwendal Grignou <gwendal@google.com>, Grant Grundler <grundler@google.com>

Could be the 3Gbps vs. 1.5Gbps link speed negotation be related to the
"Intel=C2=AE 6 Series Express Chipset B2 stepping" chips issue? Applies=
 to those
having enabled SATA ports 2-5. And this is my case:

[    3.037832] ahci 0000:00:1f.2: version 3.0
[    3.037880] ahci 0000:00:1f.2: irq 44 for MSI/MSI-X
[    3.037906] ahci: SSS flag set, parallel bus scan disabled
[    3.048233] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbp=
s 0x31 impl SATA mode
[    3.048335] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo=
 pio slum part ems sxs apst=20
[    3.048371] ahci 0000:00:1f.2: setting latency timer to 64
[    3.088902] scsi0 : ahci
[    3.089010] scsi1 : ahci
[    3.089098] scsi2 : ahci
[    3.089185] scsi3 : ahci
[    3.089272] scsi4 : ahci
[    3.089361] scsi5 : ahci
[    3.090528] ata1: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f=
06100 irq 44
[    3.091400] ata2: DUMMY
[    3.092262] ata3: DUMMY
[    3.093112] ata4: DUMMY
[    3.093952] ata5: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f=
06300 irq 44
[    3.094803] ata6: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f=
06380 irq 44

http://support.dell.com/support/topics/global.aspx/support/kcs/document=
?c=3Dus&cs=3D04&docid=3D389728&l=3Den&s=3Dbsd
http://www.intel.com/support/chipsets/6/sb/CS-032521.htm
http://www.intel.com/support/chipsets/6/sb/CS-032521.htm

Martin



Lin Ming wrote:
> On Thu, Apr 19, 2012 at 2:32 AM, Martin Mokrejs <mmokrejs@fold.natur.=
cuni.cz> wrote:
>> Martin Mokrejs wrote:
>>>
>>>
>>> Jeff Garzik wrote:
>>>> On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
>>>>> Fix: I got my 3TB disk detected by this single command:
>>>>>
>>>>> # echo on>   /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/cont=
rol
>>>>> #
>>>>>
>>>>> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-r=
c3 kernel.
>>>>>
>>>>> I can do some more testing if you want me to.
>>>>> Best,
>>>>> Martin
>>>>
>>>>
>>>> Can you test this one-line patch from Lin Ming?  Hopefully there i=
s zero sysfs twiddling required with this one...
>>>>
>>>> --- a/drivers/ata/libata-transport.c
>>>> +++ b/drivers/ata/libata-transport.c
>>>> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>>>>      device_enable_async_suspend(dev);
>>>>      pm_runtime_set_active(dev);
>>>>      pm_runtime_enable(dev);
>>>> +    pm_runtime_forbid(dev);
>>>>
>>>>      transport_add_device(dev);
>>>>      transport_configure_device(dev);
>>
>>
>> There is one more minor issue. I cannot get my disk re-dectected at =
3Gbps. Here is when I plugged it in
>> for the very first time after bootup (plain 3.4-rc3 with the above o=
ne-line fix):
>=20
> I did bisect and found that this is a really old regression introduce=
d
> in 2.6.37-rc1 with below commit.
>=20
> commit d9027470b88631d0956ac37cdadfdeb9cdcf2c99
> Author: Gwendal Grignou <gwendal@google.com>
> Date:   Tue May 25 12:31:38 2010 -0700
>=20
>     [libata] Add ATA transport class
>=20
>     This is a scheleton for libata transport class.
>     All information is read only, exporting information from libata:
>     - ata_port class: one per ATA port
>     - ata_link class: one per ATA port or 15 for SATA Port Multiplier
>     - ata_device class: up to 2 for PATA link, usually one for SATA.
>=20
>     Signed-off-by: Gwendal Grignou <gwendal@google.com>
>     Reviewed-by: Grant Grundler <grundler@google.com>
>     Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
>=20
>=20
> Here is the patch to fix it.
>=20
> Gwendal and Grant,
>=20
> Would you help to review it?
>=20
>=20
>>From f696daec7ff63e9b3697e8f7ef8f985152667965 Mon Sep 17 00:00:00 200=
1
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Thu, 19 Apr 2012 15:45:51 +0800
> Subject: [PATCH] libata: clear error mask of old error history
>=20
> The old error history was cleared in ata_ering_clear().
> It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not cleare=
d.
> So ata_ering_map() still iterates the old error history.
>=20
> This causes problem, for example, wrong probe trials count were retur=
ned in
> ata_eh_schedule_probe(), which in turn causes SATA link speed to be s=
lowed down
> to 1.5Gbps.
>=20
> Reported-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/ata/libata-eh.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c61316e..4c6f49b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -419,9 +419,10 @@ int ata_ering_map(struct ata_ering *ering,
>  	return rc;
>  }
> =20
> -int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
> +static int ata_ering_clear_cb(struct ata_ering_entry *ent, void *voi=
d_arg)
>  {
>  	ent->eflags |=3D ATA_EFLAG_OLD_ER;
> +	ent->err_mask =3D 0;
>  	return 0;
>  }
> =20
