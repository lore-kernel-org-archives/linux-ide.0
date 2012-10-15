From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH 3/6] DRIVERS: ATA: SATA PHY utility framework
Date: Mon, 15 Oct 2012 15:16:51 +0530
Message-ID: <CAK1UHixH=CJXzhi=uDfQ5Yq78hQzOCXuJCzgUAC+X+Ogsx-qmQ@mail.gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
	<1349783332-18467-4-git-send-email-vasanthananthan@gmail.com>
	<2368802.eUtXvopXao@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2368802.eUtXvopXao@flatron>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hi Tomasz,

On Sat, Oct 13, 2012 at 4:00 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Vasanth,
>
> On Tuesday 09 of October 2012 17:18:49 Vasanth Ananthan wrote:
>> This patch adds SATA PHY utility framework APIs. The framework acts as
>> an interface between the SATA device and the PHY device. The SATA PHY
>> device registers itself with the framework through the APIs provided
>> and the SATA device finds and requests for an appropriate PHY device.
>>
>> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
>> ---
>>  drivers/ata/Kconfig    |    9 ++++
>>  drivers/ata/Makefile   |    1 +
>>  drivers/ata/sata_phy.c |   99
>> ++++++++++++++++++++++++++++++++++++++++++++++++ drivers/ata/sata_phy.h
>> |   44 +++++++++++++++++++++
>>  4 files changed, 153 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/ata/sata_phy.c
>>  create mode 100644 drivers/ata/sata_phy.h
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 27cecd3..0344b78 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -83,6 +83,15 @@ config SATA_AHCI_PLATFORM
>>
>>         If unsure, say N.
>>
>> +config SATA_EXYNOS
>> +     bool "Exynos SATA AHCI support"
>> +     depends on I2C_S3C2410
>> +     help
>> +          This option enables support for Exynos AHCI Serial ATA
>> +          controllers.
>> +
>> +          If unsure, say N.
>> +
>>  config SATA_FSL
>>       tristate "Freescale 3.0Gbps SATA support"
>>       depends on FSL_SOC
>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>> index a454a13..bf3fd91 100644
>> --- a/drivers/ata/Makefile
>> +++ b/drivers/ata/Makefile
>> @@ -9,6 +9,7 @@ obj-$(CONFIG_SATA_FSL)                += sata_fsl.o
>>  obj-$(CONFIG_SATA_INIC162X)  += sata_inic162x.o
>>  obj-$(CONFIG_SATA_SIL24)     += sata_sil24.o
>>  obj-$(CONFIG_SATA_DWC)               += sata_dwc_460ex.o
>> +obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o libahci.o
>
>
> If the framework introduced by this patch is supposed to be generic, maybe
> a new Kconfig entry should be created for it, like CONFIG_SATA_PHY, which
> would be selected by any drivers using it?
>

>> +int sata_add_phy(struct sata_phy *phy, enum sata_phy_type type)
>> +{
>> +     unsigned long flag;
>> +     unsigned int ret = -EINVAL;
>> +     struct sata_phy *x;
>
> If you need to handle the situation when phy is NULL here, then why not
> to:
>
>         if (!phy)
>                 return -EINVAL;
>
> and then make the code below unconditional?
>
I'll incorporate the suggestions.
-- 
Vasanth
