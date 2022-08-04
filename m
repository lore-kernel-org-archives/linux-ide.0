Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38000C3F6B0
	for <linux-ide@archiver.kernel.org>; Thu,  4 Aug 2022 22:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiHDWyy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiHDWyD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Aug 2022 18:54:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484AE74369
        for <linux-ide@vger.kernel.org>; Thu,  4 Aug 2022 15:52:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so1336058wru.8
        for <linux-ide@vger.kernel.org>; Thu, 04 Aug 2022 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y+8gnJ68hJod6uvQUR4L1wvFSKnRgzdO4yxaDxG616M=;
        b=dfd1RDzSjLjHExV+EaGPHEXW2HbH1qMEV5PNCZClRbql6yUUuCwFoQgJcS/SRTVrVN
         h7B2rJDg2Gy3V9EADURhz914xMJYqf4diGNP1Q5DQ0vsoVkiChDVBhu2pYeJ16+0Ew2r
         W+hhliRFKa9YT0AyAgqsFVeojh4oBpPHcyiiIcRdVa4uMhpT5rjKeeR6P/DStWG2fyio
         O8xedJQJzpnryKXIRo+azAVUH5qRcAJ4vqsZswN3RdCvQDulevNaAxQTQ6lzaRxlhbc8
         cvpCDIV9+6Jq9Dnh3E6KQLox6nn/KQMzCUPZKpC/lExk8aVzf8EVzGia+jmvGsHCFTYx
         AhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y+8gnJ68hJod6uvQUR4L1wvFSKnRgzdO4yxaDxG616M=;
        b=s8cAaYC0S0GrtMR7aA/5RO4jZUtp8AUpvEwjiLCbbDKq8cQHdlDYPS7MEvzNoDYA1/
         FKYEtsdJHeK9XQojTMG+pe5TfnVc/Zlg+63ldOLA/PaZh7u/ZcuserG/HSnB+9ffKfZO
         Z0rWq0umCDdWYvRGCblUnqcQUUfLGHrj+gQiGzAqEsXdbeo1e5S6lajNrQ8A7w39jx71
         m8SI1bpVPBd9mE3PQwZrrX0ZzcFjS/QRiYpXuwEs6QB3vj8ERnNWrBna5FekLfq3y6Sg
         mLY3u4cDTlmOOagpoAbzb4m6qidzJGWO9Hjsq/Pv9gJNqd0iBjEXPVoQyuC8Mx7G7nJy
         ZpUg==
X-Gm-Message-State: ACgBeo1TlWhvGcbdROF4qnraGamJ6V23z2Mv8FnUDFNuGbxm6kPNQ4aB
        Huw4Dd06wa00OUnV8zQu34NLmw==
X-Google-Smtp-Source: AA6agR5yGSclA5gFlTAnvgte1BCgtH6uZwtDoYlN40D/6jt4Q0TuIARi9wLNQjI3X6Ocf7C00QWqOA==
X-Received: by 2002:adf:fe0d:0:b0:220:5f88:ebef with SMTP id n13-20020adffe0d000000b002205f88ebefmr2462048wrr.349.1659653574611;
        Thu, 04 Aug 2022 15:52:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v5 25/33] ata/drivers/ahci_imx: Switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:41 +0200
Message-Id: <20220804224349.1926752-26-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.

So in order to change the function prototype for the get_temp ops which
does not take a void* but a thermal_zone_device* structure, this
function wraps the call.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_imx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 79aa9f285312..b734e069034d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
 }
 
 /* SATA AHCI temperature monitor */
-static int sata_ahci_read_temperature(void *dev, int *temp)
+static int __sata_ahci_read_temperature(void *dev, int *temp)
 {
 	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
 	u32 str1, str2, str3, str4;
@@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
 	return 0;
 }
 
+static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
+{
+	return __sata_ahci_read_temperature(tz->devdata, temp);
+}
+
 static ssize_t sata_ahci_show_temp(struct device *dev,
 				   struct device_attribute *da,
 				   char *buf)
@@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
 	unsigned int temp = 0;
 	int err;
 
-	err = sata_ahci_read_temperature(dev, &temp);
+	err = __sata_ahci_read_temperature(dev, &temp);
 	if (err < 0)
 		return err;
 
 	return sprintf(buf, "%u\n", temp);
 }
 
-static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
+static const struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
 	.get_temp = sata_ahci_read_temperature,
 };
 
@@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			ret = PTR_ERR(hwmon_dev);
 			goto disable_clk;
 		}
-		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
-					     &fsl_sata_ahci_of_thermal_ops);
+		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
+					      &fsl_sata_ahci_of_thermal_ops);
 		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
 	}
 
-- 
2.25.1

