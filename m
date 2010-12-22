From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH 1/1] ARM: cns3xxx: ahci: Fixup for softwreset failures
 with direct connected disks with CONFIG_SATA_PMP enabled.
Date: Wed, 22 Dec 2010 17:27:20 +0800
Message-ID: <AANLkTi=Lk1vAxxTJQpXNvtbLCFs0Gy+ZAJadxv_mLQ6C@mail.gmail.com>
References: <1291481021-23317-1-git-send-email-mkl0301@gmail.com>
	<20101220170217.GA1333@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:63595 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0LVJ1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2010 04:27:22 -0500
Received: by fxm18 with SMTP id 18so5347547fxm.2
        for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2010 01:27:20 -0800 (PST)
In-Reply-To: <20101220170217.GA1333@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

2010/12/21 Anton Vorontsov <cbouatmailru@gmail.com>:
> On Sun, Dec 05, 2010 at 12:43:41AM +0800, mkl0301@gmail.com wrote:
> [...]
>
> Thanks for the patch!
>
> There are few issues though.
>
>> +static int cns3xxx_ahci_init(struct device *dev, void __iomem *addr=
)
>> +{
>> + =A0 =A0 u32 tmp;
>> +
>> + =A0 =A0 DPRINTK("ENTER\n");
>> +
>> + =A0 =A0 tmp =3D __raw_readl(MISC_SATA_POWER_MODE);
>> + =A0 =A0 tmp |=3D 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mod=
e */
>> + =A0 =A0 tmp |=3D 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mod=
e */
>> + =A0 =A0 __raw_writel(tmp, MISC_SATA_POWER_MODE);
>> +
>> + =A0 =A0 /* Enable SATA PHY */
>> + =A0 =A0 cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_S=
ATA_PHY0);
>> + =A0 =A0 cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_S=
ATA_PHY1);
>> +
>> + =A0 =A0 /* Enable SATA Clock */
>> + =A0 =A0 cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
>> +
>> + =A0 =A0 /* De-Asscer SATA Reset */
>> + =A0 =A0 cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
> [...]
>> -void __init cns3xxx_ahci_init(void)
>> -{
>> - =A0 =A0 u32 tmp;
>> -
>> - =A0 =A0 tmp =3D __raw_readl(MISC_SATA_POWER_MODE);
>> - =A0 =A0 tmp |=3D 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mod=
e */
>> - =A0 =A0 tmp |=3D 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mod=
e */
>> - =A0 =A0 __raw_writel(tmp, MISC_SATA_POWER_MODE);
>> -
>> - =A0 =A0 /* Enable SATA PHY */
>> - =A0 =A0 cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_S=
ATA_PHY0);
>> - =A0 =A0 cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_S=
ATA_PHY1);
>> -
>> - =A0 =A0 /* Enable SATA Clock */
>> - =A0 =A0 cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
>> -
>> - =A0 =A0 /* De-Asscer SATA Reset */
>> - =A0 =A0 cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
>> -
>> - =A0 =A0 platform_device_register(&cns3xxx_ahci_pdev);
>> -}
>
> This is not good because cns3xxx_pwr_*() calls aren't thread-safe.
> We must use them only from the "single-threaded" platform code,
> i.e. very early.
> Once we add proper clocks (clkapi) and power management (regulators)
> support for CNS3xxx, we may move this into ahci->init() callback.
Almost every device driver needs to change those power/clk/reset bits,
and it's strange to enable everything on init phase. BTW, the  EHCI
and OHCI that I sent previously also used these cns3xxx_pwr_*() calls.

Would they be supported in near future? If not, I would like look into =
those.

> Plus, unfortunately this patch breaks build when AHCI_PLATFORM is
> set to =3Dm.
> arch/arm/mach-cns3xxx/built-in.o: In function 'cns3xxx_ahci_softreset=
':
> cns3420vb.c:(.text+0x36c): undefined reference to 'ahci_do_softreset'
> cns3420vb.c:(.text+0x390): undefined reference to 'ahci_do_softreset'
> cns3420vb.c:(.text+0x3a0): undefined reference to 'ahci_check_ready'
> arch/arm/mach-cns3xxx/built-in.o:(.data+0x35c): undefined reference t=
o 'ahci_ops'
> make: *** [.tmp_vmlinux1] Error 1
Sorry that I didn't notice this. I was trying to reuse ahci-platform
as possible.
Building platform device as module seems strange to me, therefore I
would add a new ahci-platform alike platform driver.

Best Regards,
Mac Lin
