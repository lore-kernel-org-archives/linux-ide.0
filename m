From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ahci: sata hotplug doesn't work after suspend
Date: Mon, 27 Feb 2012 09:05:51 +0800
Message-ID: <CAF1ivSaQU1MXbExbtRkXy5YcbymCM_9DdR9d4BqMbti2rbvehg@mail.gmail.com>
References: <4F415775.7060003@suse.cz>
	<20120219211709.GA30809@homac.suse.de>
	<1329726646.3368.2.camel@minggr>
	<4F42420E.2010301@suse.cz>
	<1329964013.18070.3.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59181 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2B0BFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Feb 2012 20:05:52 -0500
In-Reply-To: <1329964013.18070.3.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Holger Macht <holger@homac.de>, Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, Feb 23, 2012 at 10:26 AM, Lin Ming <ming.m.lin@intel.com> wrote=
:
> On Mon, 2012-02-20 at 13:52 +0100, Jiri Slaby wrote:
>> On 02/20/2012 09:30 AM, Lin Ming wrote:
>> > On Sun, 2012-02-19 at 22:17 +0100, Holger Macht wrote:
>> >> On So 19. Feb - 21:11:33, Jiri Slaby wrote:
>> >>> Hi,
>> >>>
>> >>> ahci hotplug stopped working here. It always worked (-next-20111=
206 is
>> >>> the last known working for sure). I'm using -next and after plug=
ging a
>> >>> sata disk in, nothing happens. I don't *think* (in the traffic, =
it's
>> >>> hard to tell for sure) an interrupt is generated either. I also =
*think*
>> >>> that it works before suspend/resume, but not after. (Or maybe up=
time
>> >>> matters?)
>> >>>
>> >>> This happens before suspend on plug-in:
>> >>> ata3: exception Emask 0x50 SAct 0x0 SErr 0x40d0800 action 0xe fr=
ozen
>> >>> ata3: irq_stat 0x00000040, connection status changed
>> >>> ata3: SError: { HostInt PHYRdyChg CommWake 10B8B DevExch }
>> >>> ata3: hard resetting link
>> >>> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> >>> ata3.00: ATA-8: ST31000528AS, CC38, max UDMA/133
>> >>> ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> >>> ata3.00: configured for UDMA/133
>> >>> ata3: EH complete
>> >>> scsi 2:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0ST31000528AS =
=A0 =A0 CC38 PQ: 0 ANSI: 5
>> >>> sd 2:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/9=
31 GiB)
>> >>> sd 2:0:0:0: [sdc] Write Protect is off
>> >>> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>> >>> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doe=
sn't
>> >>> support DPO or FUA
>> >>> =A0sdc: sdc1 sdc2
>> >>> sd 2:0:0:0: [sdc] Attached SCSI disk
>> >>>
>> >>> After suspend/resume and plug-in, nothing appears in dmesg. Stor=
ing "- -
>> >>> -" to /sys/class/scsi_host/host*/scan doesn't help. It looks lik=
e the
>> >>> line is completely dead, because only ata1 and ata2 say "hard re=
setting
>> >>> link" after this (and another two disks are connected there).
>> >>>
>> >>> I tried 'echo adapter >host_reset', but I get 'write error: Inva=
lid
>> >>> argument'.
>> >>>
>> >>> 00:1f.2 SATA controller [0106]: Intel Corporation 82801IR/IO/IH
>> >>> (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] [8086:2922] (re=
v 02)
>> >>> (prog-if 01 [AHCI 1.0])
>> >>> =A0 =A0 =A0 =A0 Subsystem: Intel Corporation 82801IR/IO/IH (ICH9=
R/DO/DH) 6 port
>> >>> SATA Controller [AHCI mode] [8086:2922]
>> >>> =A0 =A0 =A0 =A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
>> >>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>> >>> =A0 =A0 =A0 =A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium >TAbort-
>> >>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >>> =A0 =A0 =A0 =A0 Latency: 0
>> >>> =A0 =A0 =A0 =A0 Interrupt: pin B routed to IRQ 43
>> >>> =A0 =A0 =A0 =A0 Region 0: I/O ports at cc00 [size=3D8]
>> >>> =A0 =A0 =A0 =A0 Region 1: I/O ports at c880 [size=3D4]
>> >>> =A0 =A0 =A0 =A0 Region 2: I/O ports at c800 [size=3D8]
>> >>> =A0 =A0 =A0 =A0 Region 3: I/O ports at c480 [size=3D4]
>> >>> =A0 =A0 =A0 =A0 Region 4: I/O ports at c400 [size=3D32]
>> >>> =A0 =A0 =A0 =A0 Region 5: Memory at feb7c800 (32-bit, non-prefet=
chable) [size=3D2K]
>> >>> =A0 =A0 =A0 =A0 Capabilities: [80] MSI: Enable+ Count=3D1/16 Mas=
kable- 64bit-
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address: fee0100c =A0Data: 4171
>> >>> =A0 =A0 =A0 =A0 Capabilities: [70] Power Management version 3
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1- D2- AuxC=
urrent=3D0mA
>> >>> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 NoSoftRst+ PME-Enable=
- DSel=3D0 DScale=3D0 PME-
>> >>> =A0 =A0 =A0 =A0 Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D0=
0000004
>> >>> =A0 =A0 =A0 =A0 Capabilities: [b0] Vendor Specific Information: =
Len=3D06 <?>
>> >>> =A0 =A0 =A0 =A0 Kernel driver in use: ahci
>> >>>
>> >>> Any ideas what that could be?
>> >>
>> >> I suspect this is caused by commit
>> >> 9ee4f3933930abf5cc34f8e9d69fe0e08c18f602. Maybe you could verify?=
 I
>> >> bisected this a couple of days ago but didn't have time to look i=
nto it
>> >> further. Maybe Lin can help here if this is the problematic commi=
t.
>> >
>> > I'll try to re-produce this issue first.
>>
>> Ok, just a few more information. Suspend/resume cycle is needed to s=
ee
>> the issue. Reverting of 9ee4f3933930 helps when this is applied too =
(I
>> haven't tried one or the other alone):
>
> For now, the simple fix is to disable runtime pm for hotpluggable por=
t.
>
> Could you please try below patch?
>
> And please also show the debug info.
> dmesg |grep "DEBUG: port"

Hi Jiri,

Will you get a chance to test this patch?

Thanks,
Lin Ming

>
> From 28bf2f0592f231c2caba816428beaffc28873d8e Mon Sep 17 00:00:00 200=
1
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Thu, 23 Feb 2012 10:21:18 +0800
> Subject: [PATCH] libata: disable runtime pm for hotpluggable port
>
> ---
> =A0drivers/ata/ahci.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0drivers/ata/ahci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0drivers/ata/libahci.c =A0 =A0 =A0 =A0 =A0| =A0 21 ++++++++++++++++=
+++++
> =A0drivers/ata/libata-transport.c | =A0 =A06 ++++--
> =A0include/linux/libata.h =A0 =A0 =A0 =A0 | =A0 =A04 +++-
> =A05 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index d07bf03..02e93ff 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1145,6 +1145,9 @@ static int ahci_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> =A0 =A0 =A0 =A0if (hpriv->cap & HOST_CAP_PMP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pi.flags |=3D ATA_FLAG_PMP;
>
> + =A0 =A0 =A0 if (hpriv->cap & HOST_CAP_SXS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_EXTERNAL;
> +
> =A0 =A0 =A0 =A0ahci_set_em_messages(hpriv, &pi);
>
> =A0 =A0 =A0 =A0if (ahci_broken_system_poweroff(pdev)) {
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index b175000..92f7172 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -172,6 +172,9 @@ enum {
> =A0 =A0 =A0 =A0PORT_CMD_ALPE =A0 =A0 =A0 =A0 =A0 =3D (1 << 26), /* Ag=
gressive Link PM enable */
> =A0 =A0 =A0 =A0PORT_CMD_ATAPI =A0 =A0 =A0 =A0 =A0=3D (1 << 24), /* De=
vice is ATAPI */
> =A0 =A0 =A0 =A0PORT_CMD_FBSCP =A0 =A0 =A0 =A0 =A0=3D (1 << 22), /* FB=
S Capable Port */
> + =A0 =A0 =A0 PORT_CMD_ESP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 21), /* E=
xternal SATA Port */
> + =A0 =A0 =A0 PORT_CMD_MPSP =A0 =A0 =A0 =A0 =A0 =3D (1 << 19), /* Mec=
hanical Presence Switch Attached to Port */
> + =A0 =A0 =A0 PORT_CMD_HPCP =A0 =A0 =A0 =A0 =A0 =3D (1 << 18), /* Hot=
 Plug Capable Port */
> =A0 =A0 =A0 =A0PORT_CMD_PMP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 17), /* =
PMP attached */
> =A0 =A0 =A0 =A0PORT_CMD_LIST_ON =A0 =A0 =A0 =A0=3D (1 << 15), /* cmd =
list DMA engine running */
> =A0 =A0 =A0 =A0PORT_CMD_FIS_ON =A0 =A0 =A0 =A0 =3D (1 << 14), /* FIS =
DMA engine running */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index a72bfd0..a0222e9 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1097,6 +1097,24 @@ static void ahci_port_init(struct device *dev,=
 struct ata_port *ap,
> =A0 =A0 =A0 =A0writel(1 << port_no, mmio + HOST_IRQ_STAT);
> =A0}
>
> +static bool ahci_port_pluggable(struct ata_port *ap)
> +{
> + =A0 =A0 =A0 void __iomem *port_mmio =3D ahci_port_base(ap);
> + =A0 =A0 =A0 u32 cmd;
> +
> + =A0 =A0 =A0 cmd =3D readl(port_mmio + PORT_CMD);
> + =A0 =A0 =A0 printk(KERN_ERR "DEBUG: port %d, PORT_CMD=3D0x%x\n", ap=
->port_no, cmd);
> +
> + =A0 =A0 =A0 if ((ap->flags & ATA_FLAG_EXTERNAL) &&
> + =A0 =A0 =A0 =A0 =A0 (cmd & PORT_CMD_ESP))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 if (cmd & (PORT_CMD_MPSP | PORT_CMD_HPCP))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 return false;
> +}
> +
> =A0void ahci_init_controller(struct ata_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct ahci_host_priv *hpriv =3D host->private_data;
> @@ -1112,6 +1130,9 @@ void ahci_init_controller(struct ata_host *host=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ata_port_is_dummy(ap))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ahci_port_pluggable(ap))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->flags |=3D ATA_FLAG=
_PLUGGABLE;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_port_init(host->dev, ap, i, mmio,=
 port_mmio);
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-tran=
sport.c
> index 74aaee3..a7166b9 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -292,8 +292,10 @@ int ata_tport_add(struct device *parent,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0device_enable_async_suspend(dev);
> - =A0 =A0 =A0 pm_runtime_set_active(dev);
> - =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 if (!(ap->flags & ATA_FLAG_PLUGGABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_set_active(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0transport_add_device(dev);
> =A0 =A0 =A0 =A0transport_configure_device(dev);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index cafc09a..e8221cf 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -207,8 +207,10 @@ enum {
> =A0 =A0 =A0 =A0ATA_FLAG_SW_ACTIVITY =A0 =A0=3D (1 << 22), /* driver s=
upports sw activity
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0* led */
> =A0 =A0 =A0 =A0ATA_FLAG_NO_DIPM =A0 =A0 =A0 =A0=3D (1 << 23), /* host=
 not happy with DIPM */
> + =A0 =A0 =A0 ATA_FLAG_EXTERNAL =A0 =A0 =A0 =3D (1 << 24), /* control=
ler supports external SATA */
> + =A0 =A0 =A0 ATA_FLAG_PLUGGABLE =A0 =A0 =A0=3D (1 << 25), /* port is=
 hotpluggable */
>
> - =A0 =A0 =A0 /* bits 24:31 of ap->flags are reserved for LLD specifi=
c flags */
> + =A0 =A0 =A0 /* bits 26:31 of ap->flags are reserved for LLD specifi=
c flags */
>
>
> =A0 =A0 =A0 =A0/* struct ata_port pflags */
> --
> 1.7.9
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
