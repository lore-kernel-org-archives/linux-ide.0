From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH 6/6] ARM: EXYNOS5: SATA PHY controller driver
Date: Tue, 16 Oct 2012 12:03:47 +0530
Message-ID: <CAK1UHiw8+ebzGyjV53Y9efpMFPbCL9RR_o9ZSw=NTuRw_9gRwg@mail.gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
	<1349783332-18467-7-git-send-email-vasanthananthan@gmail.com>
	<10179968.slaZyPIETn@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45653 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab2JPGds (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2012 02:33:48 -0400
In-Reply-To: <10179968.slaZyPIETn@flatron>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>

Hi Tomasz,

On Sat, Oct 13, 2012 at 4:20 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
> On Tuesday 09 of October 2012 17:18:52 Vasanth Ananthan wrote:
>> This patch adds a platform driver and I2C client driver for SATA PHY
>> controller
>>
>> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
>> ---
>>  drivers/ata/Makefile          |    2 +-
>>  drivers/ata/sata_exynos_phy.c |  303
>> +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 304
>> insertions(+), 1 deletions(-)
>>  create mode 100644 drivers/ata/sata_exynos_phy.c
>>
[ ... ]
>> +
>> +     phy->init = sataphy_init;
>> +     phy->shutdown = sataphy_shutdown;
>> +     phy->priv_data = (void *)sataphy;
>> +     phy->dev = &pdev->dev;
>> +
>> +     ret = sata_add_phy(phy, SATA_PHY_GENERATION3);
>> +     if (ret < 0)
>> +             goto err4;
>
> Do you have any warranties that phy callbacks won't get called before i2c
> device probes and sets i2c_client?
>
>> +
>> +     ret = i2c_add_driver(&sataphy_i2c_driver);
>> +     if (ret < 0)
>> +             goto err5;
>> +
>> +     platform_set_drvdata(pdev, phy);

I shall register my i2c client driver before assigning the SATA PHY
call backs. Would that guarantee the calling of phy callbacks after
the i2c device probes?

--
Vasanth Ananthan
