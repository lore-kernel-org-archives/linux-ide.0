From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v3 2/2] ahci_platform: add support for CNS3xxx SoC devices
Date: Fri, 7 Jan 2011 02:04:33 +0800
Message-ID: <AANLkTinO-feQkpfoZhmOV7VyPbyL=f8KV1_Qysps04ve@mail.gmail.com>
References: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
	<1294336393-920-3-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48686 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1AFSEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 13:04:35 -0500
Received: by fxm20 with SMTP id 20so16239122fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 10:04:34 -0800 (PST)
In-Reply-To: <1294336393-920-3-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mac Lin <mkl0301@gmail.com>, cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

Hi Jeff,

2011/1/7  <mkl0301@gmail.com>:
> From: Mac Lin <mkl0301@gmail.com>
>
> CNS3xxx override the softreset function of ahci_platform ahci_softres=
et by
> cns3xxx_ahci_softreset, which would retry ahci_do_softreset again wit=
h pmp=3D0 if
> pmp=3D15 failed, for the controller has problem receiving D2H Reg FIS=
 of the
> different PMP setting of the previous sent H2D Reg FIS.
>
> Following describe the isssue with original ahci_platform driver on
> linux-2.6.37-rc3, arm/cns3xxx.
>
> If CONFIG_SATA_PMP is enabled, while not using multiplier and connect=
 the disks
> directly to the board, the disk cannot be found due to software reset=
 always
> failed.
>
> =A0 =A0ahci ahci.0: forcing PORTS_IMPL to 0x3
> =A0 =A0ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl p=
latform mode
> =A0 =A0ahci ahci.0: flags: ncq sntf pm led clo only pmp pio slum part=
 ccc
> =A0 =A0scsi0 : ahci_platform
> =A0 =A0scsi1 : ahci_platform
> =A0 =A0ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status=
 changed irq 65
> =A0 =A0ata2: SATA max UDMA/133 mmio [mem 0x83000000-0x83ffffff] port =
0x180 irq 65
> =A0 =A0ata2: SATA link down (SStatus 0 SControl 300)
> =A0 =A0ata1: link is slow to respond, please be patient (ready=3D0)
> =A0 =A0ata1: softreset failed (device not ready)
> =A0 =A0ata1: link is slow to respond, please be patient (ready=3D0)
> =A0 =A0ata1: softreset failed (device not ready)
> =A0 =A0ata1: link is slow to respond, please be patient (ready=3D0)
> =A0 =A0ata1: softreset failed (device not ready)
> =A0 =A0ata1: limiting SATA link speed to 1.5 Gbps
> =A0 =A0ata1: SATA link down (SStatus 1 SControl 310)
>
> While using multiplier with CONFIG_SATA_PMP enabled, or using disks d=
irectly
> without CONFIG_SATA_PMP have no issue. It seems the device is sending=
 D2H Reg
> FIS, but controller is not reflecting it on any known means.
>
> Signed-off-by: Mac Lin <mkl0301@gmail.com>
> ---
> =A0arch/arm/mach-cns3xxx/devices.c | =A0 =A02 +-
> =A0drivers/ata/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +++++++++++
> =A0drivers/ata/ahci_platform.c =A0 =A0 | =A0 39 +++++++++++++++++++++=
++++++++++++++++++
> =A03 files changed, 51 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/=
devices.c
> index 50b4d31..b496f02 100644
> --- a/arch/arm/mach-cns3xxx/devices.c
> +++ b/arch/arm/mach-cns3xxx/devices.c
> @@ -40,7 +40,7 @@ static struct resource cns3xxx_ahci_resource[] =3D =
{
> =A0static u64 cns3xxx_ahci_dmamask =3D DMA_BIT_MASK(32);
>
> =A0static struct platform_device cns3xxx_ahci_pdev =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ahci",
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ahci-cns3xxx",
> =A0 =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D cns3xxx_ahci_resource,
> =A0 =A0 =A0 =A0.num_resources =A0=3D ARRAY_SIZE(cns3xxx_ahci_resource=
),
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 36e2319..5d8b1a3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -75,6 +75,17 @@ config SATA_AHCI_PLATFORM
>
> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>
> +config SATA_AHCI_CNS3XXX
> + =A0 =A0 =A0 bool "AHCI Support on the Cavium Networks CNS3xxx SOC"
> + =A0 =A0 =A0 depends on ARCH_CNS3XXX
> + =A0 =A0 =A0 depends on SATA_AHCI_PLATFORM
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option enables AHCI platform driver to support=
 CNS3xxx
> + =A0 =A0 =A0 =A0 System-on-Chip devices. This is only needed when us=
ing CNS3xxx AHCI
> + =A0 =A0 =A0 =A0 controller.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> =A0config SATA_FSL
> =A0 =A0 =A0 =A0tristate "Freescale 3.0Gbps SATA support"
> =A0 =A0 =A0 =A0depends on FSL_SOC
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.=
c
> index 25d98c8..7d6957f 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -176,8 +176,47 @@ static int __devexit ahci_remove(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#ifdef CONFIG_SATA_AHCI_CNS3XXX
> +/*
> + * TODO: move cns3xxx_ahci_init to here after cns3xxx_pwr*() calls a=
re
> + * thread-safe
> + */
> +
> +static int cns3xxx_ahci_softreset(struct ata_link *link, unsigned in=
t *class,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long deadl=
ine)
> +{
> + =A0 =A0 =A0 int pmp =3D sata_srst_pmp(link);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D ahci_do_softreset(link, class, pmp, deadline, a=
hci_check_ready);
> + =A0 =A0 =A0 if (pmp && ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ahci_do_softreset(link, class, 0=
, deadline,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ahci_check_ready);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct ata_port_operations cns3xxx_ahci_ops =3D {
> + =A0 =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &ahci_ops,
> + =A0 =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cns3xxx_ahci_=
softreset,
> +};
> +
> +static const struct ata_port_info cns3xxx_ata_port_info =3D {
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D AHCI_FLAG_COMMON,
> + =A0 =A0 =A0 .pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
> + =A0 =A0 =A0 .udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
> + =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &cns3xxx_ahci_ops,
> +};
> +
> +struct ahci_platform_data cns3xxx_ahci_platform_data =3D {
> + =A0 =A0 =A0 .ata_port_info =A0=3D &cns3xxx_ata_port_info,
> +};
> +#endif
> +
> =A0static const struct platform_device_id ahci_pltfm_ids[] =3D {
> =A0 =A0 =A0 =A0{ "ahci", },
> +#ifdef CONFIG_SATA_AHCI_CNS3XXX
> + =A0 =A0 =A0 { "ahci-cns3xxx", (kernel_ulong_t)&cns3xxx_ahci_platfor=
m_data},
> +#endif
> =A0 =A0 =A0 =A0{ },
> =A0};
> =A0MODULE_DEVICE_TABLE(platform, ahci_pltfm_ids);
> --
> 1.7.3
>
>
The code is less readable with macro here and there. It would be more
complicated if more SoC-specific code added.
I really prefer the original way.

Best Regards,
Mac Lin
