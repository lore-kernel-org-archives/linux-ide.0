From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH v2] libata: disable runtime pm for hotpluggable port
Date: Thu, 5 Apr 2012 09:12:44 +0800
Message-ID: <CAF1ivSajbUnP05qVz8SaSmQ4XSxhT75qp5yGCGfa1TDk6T9V9g@mail.gmail.com>
References: <1331603857.3436.24.camel@minggr>
	<4F78BF08.2090709@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59574 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab2DEBMp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2012 21:12:45 -0400
In-Reply-To: <4F78BF08.2090709@suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>, cwillu@cwillu.com, jackdachef@gmail.com, Sergei Shtylyov <sshtylyov@mvista.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Apr 2, 2012 at 4:48 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 03/13/2012 02:57 AM, Lin Ming wrote:
>> Currently, hotplug doesn't work if port is already runtime suspended=
=2E
>> For now, we simply disable runtime pm for hotpluggable port.
>> Later, we should add runtime pm support for hotpluggable port too.
>>
>> Bug report:
>> https://lkml.org/lkml/2012/2/19/70
>>
>> v2:
>> - Use bit 2 and 3 for flags ATA_FLAG_EXTERNAL and ATA_FLAG_PLUGGABLE=
=2E
>>
>> TODO: add similar hotpluggable port check for controllers other than
>> AHCI.
>
> Any updates on this? The patches which introduced the bug are in -rc1
> now. Unlike this patch.

Jeff,

Any concern to apply this patch?

Regards,
Lin Ming

>
>> Reported-and-tested-by: Jiri Slaby <jslaby@suse.cz>
>> Reported-and-tested-by: cwillu@cwillu.com
>> Reported-and-tested-by: jackdachef@gmail.com
>> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>> ---
>> =A0drivers/ata/ahci.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
>> =A0drivers/ata/ahci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
>> =A0drivers/ata/libahci.c =A0 =A0 =A0 =A0 =A0| =A0 20 +++++++++++++++=
+++++
>> =A0drivers/ata/libata-transport.c | =A0 =A06 ++++--
>> =A0include/linux/libata.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
>> =A05 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index d07bf03..02e93ff 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1145,6 +1145,9 @@ static int ahci_init_one(struct pci_dev *pdev,=
 const struct pci_device_id *ent)
>> =A0 =A0 =A0 if (hpriv->cap & HOST_CAP_PMP)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_PMP;
>>
>> + =A0 =A0 if (hpriv->cap & HOST_CAP_SXS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_EXTERNAL;
>> +
>> =A0 =A0 =A0 ahci_set_em_messages(hpriv, &pi);
>>
>> =A0 =A0 =A0 if (ahci_broken_system_poweroff(pdev)) {
>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>> index b175000..92f7172 100644
>> --- a/drivers/ata/ahci.h
>> +++ b/drivers/ata/ahci.h
>> @@ -172,6 +172,9 @@ enum {
>> =A0 =A0 =A0 PORT_CMD_ALPE =A0 =A0 =A0 =A0 =A0 =3D (1 << 26), /* Aggr=
essive Link PM enable */
>> =A0 =A0 =A0 PORT_CMD_ATAPI =A0 =A0 =A0 =A0 =A0=3D (1 << 24), /* Devi=
ce is ATAPI */
>> =A0 =A0 =A0 PORT_CMD_FBSCP =A0 =A0 =A0 =A0 =A0=3D (1 << 22), /* FBS =
Capable Port */
>> + =A0 =A0 PORT_CMD_ESP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 21), /* Exte=
rnal SATA Port */
>> + =A0 =A0 PORT_CMD_MPSP =A0 =A0 =A0 =A0 =A0 =3D (1 << 19), /* Mechan=
ical Presence Switch Attached to Port */
>> + =A0 =A0 PORT_CMD_HPCP =A0 =A0 =A0 =A0 =A0 =3D (1 << 18), /* Hot Pl=
ug Capable Port */
>> =A0 =A0 =A0 PORT_CMD_PMP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 17), /* PM=
P attached */
>> =A0 =A0 =A0 PORT_CMD_LIST_ON =A0 =A0 =A0 =A0=3D (1 << 15), /* cmd li=
st DMA engine running */
>> =A0 =A0 =A0 PORT_CMD_FIS_ON =A0 =A0 =A0 =A0 =3D (1 << 14), /* FIS DM=
A engine running */
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index a72bfd0..7d72d3c 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -1097,6 +1097,23 @@ static void ahci_port_init(struct device *dev=
, struct ata_port *ap,
>> =A0 =A0 =A0 writel(1 << port_no, mmio + HOST_IRQ_STAT);
>> =A0}
>>
>> +static bool ahci_port_pluggable(struct ata_port *ap)
>> +{
>> + =A0 =A0 void __iomem *port_mmio =3D ahci_port_base(ap);
>> + =A0 =A0 u32 cmd;
>> +
>> + =A0 =A0 cmd =3D readl(port_mmio + PORT_CMD);
>> +
>> + =A0 =A0 if ((ap->flags & ATA_FLAG_EXTERNAL) &&
>> + =A0 =A0 =A0 =A0 (cmd & PORT_CMD_ESP))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> +
>> + =A0 =A0 if (cmd & (PORT_CMD_MPSP | PORT_CMD_HPCP))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> +
>> + =A0 =A0 return false;
>> +}
>> +
>> =A0void ahci_init_controller(struct ata_host *host)
>> =A0{
>> =A0 =A0 =A0 struct ahci_host_priv *hpriv =3D host->private_data;
>> @@ -1112,6 +1129,9 @@ void ahci_init_controller(struct ata_host *hos=
t)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ata_port_is_dummy(ap))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ahci_port_pluggable(ap))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->flags |=3D ATA_FLAG_PL=
UGGABLE;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ahci_port_init(host->dev, ap, i, mmio, p=
ort_mmio);
>> =A0 =A0 =A0 }
>>
>> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-tra=
nsport.c
>> index 74aaee3..a7166b9 100644
>> --- a/drivers/ata/libata-transport.c
>> +++ b/drivers/ata/libata-transport.c
>> @@ -292,8 +292,10 @@ int ata_tport_add(struct device *parent,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 device_enable_async_suspend(dev);
>> - =A0 =A0 pm_runtime_set_active(dev);
>> - =A0 =A0 pm_runtime_enable(dev);
>> + =A0 =A0 if (!(ap->flags & ATA_FLAG_PLUGGABLE)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_set_active(dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 transport_add_device(dev);
>> =A0 =A0 =A0 transport_configure_device(dev);
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index cafc09a..f46961d 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -187,6 +187,8 @@ enum {
>> =A0 =A0 =A0 ATA_FLAG_SLAVE_POSS =A0 =A0 =3D (1 << 0), /* host suppor=
ts slave dev */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* (doesn't imply presence) */
>> =A0 =A0 =A0 ATA_FLAG_SATA =A0 =A0 =A0 =A0 =A0 =3D (1 << 1),
>> + =A0 =A0 ATA_FLAG_EXTERNAL =A0 =A0 =A0 =3D (1 << 2), /* Controller =
supports external SATA */
>> + =A0 =A0 ATA_FLAG_PLUGGABLE =A0 =A0 =A0=3D (1 << 3), /* Port is hot=
pluggable */
>> =A0 =A0 =A0 ATA_FLAG_NO_ATAPI =A0 =A0 =A0 =3D (1 << 6), /* No ATAPI =
support */
>> =A0 =A0 =A0 ATA_FLAG_PIO_DMA =A0 =A0 =A0 =A0=3D (1 << 7), /* PIO cmd=
s via DMA */
>> =A0 =A0 =A0 ATA_FLAG_PIO_LBA48 =A0 =A0 =A0=3D (1 << 8), /* Host DMA =
engine is LBA28 only */
>>
> --
> js
> suse labs
