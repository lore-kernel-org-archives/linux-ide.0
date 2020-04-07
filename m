Return-Path: <SRS0=Xbu2=5X=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827ADC2BABC
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 06:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632522051A
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 06:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDGGIR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:08:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDGGIR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2020 02:08:17 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLhPD-0005Zn-JG
        for linux-ide@vger.kernel.org; Tue, 07 Apr 2020 06:08:15 +0000
Received: by mail-pf1-f197.google.com with SMTP id s8so1630038pfd.23
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2020 23:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Ugp4stwtf/wNgGldSIENqPT9PoLpHxx5Ki/Pa6V0pE=;
        b=TJSVXOnMQhaBO7/vqnL2i1oePeig/6SjZx96c0bdGMpfvEyHoU73B3cbcD12/CHylq
         1/f2vlQXez3ubemi4u6ac3ph8tCAWQ+5haBJPckT9ldG006Px4/UIjONNGzwcrv5uFe/
         Dkh82vhbM8PrOJMhuQ8UveofFf29qhIqo0gcBHbib9oerlDW1ZvTTTC0GUlXtBohyvI+
         QfAmQVogEwcG04qqdrzy9Oi4+XD+bPatxc5TLk6OWE4m9sVMTUfuDMYzAAWPZWqupwNT
         TNSFuU6SjsGKibQ+yxbjtgMTUxV8EuouKiivTBX5b82fnRuOImeCSRqrjtsVXbRS1Ipx
         Kp8Q==
X-Gm-Message-State: AGi0PuaCGuFwHG7xlfKhHZytmWZzJdMds//wE5j8rhOnU3HJF3MR76CI
        5WWCpM67sEdK//OwJgpR3XxYe40+ZMTJvqw9QQK6bWXsG4qK7H79zY4s2xF2Is9dPwLwGyUWVeS
        aeF0sMEkg7yCBa80hpZa7wThefsTQGLETWP/qRA==
X-Received: by 2002:a65:6412:: with SMTP id a18mr517484pgv.322.1586239694101;
        Mon, 06 Apr 2020 23:08:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypKm7WeWP+BQJP2ssXkJwPYZCnGokYAzGuDaiDSKMicHiRR++pICN6i+unNEnOmLnyrafpR1WA==
X-Received: by 2002:a65:6412:: with SMTP id a18mr517468pgv.322.1586239693796;
        Mon, 06 Apr 2020 23:08:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 8sm13108207pfv.65.2020.04.06.23.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 23:08:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] ata: ahci: Add sysfs attribute to show remapped NVMe
 device count
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <D1CCEA35-D7D4-40E3-85C4-E82FD1154AB7@canonical.com>
Date:   Tue, 7 Apr 2020 14:08:12 +0800
Cc:     anthony.wong@canonical.com,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C378B48F-FA41-4ED2-9B94-1E3102C75136@canonical.com>
References: <20200207100016.32605-1-kai.heng.feng@canonical.com>
 <D1CCEA35-D7D4-40E3-85C4-E82FD1154AB7@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

> On Feb 20, 2020, at 13:45, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
>> On Feb 7, 2020, at 18:00, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> Add a new sysfs attribute to show how many NVMe devices are remapped.
>> 
>> Userspace like distro installer can use this info to ask user to change
>> the BIOS setting.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

Any improvement I can make for this patch?

Kai-Heng

> 
>> ---
>> drivers/ata/ahci.c | 28 ++++++++++++++++++++++++----
>> drivers/ata/ahci.h |  1 +
>> 2 files changed, 25 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 11ea1aff40db..cdbd995a7a6b 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1488,7 +1488,7 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
>> static void ahci_remap_check(struct pci_dev *pdev, int bar,
>> 		struct ahci_host_priv *hpriv)
>> {
>> -	int i, count = 0;
>> +	int i;
>> 	u32 cap;
>> 
>> 	/*
>> @@ -1509,13 +1509,14 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
>> 			continue;
>> 
>> 		/* We've found a remapped device */
>> -		count++;
>> +		hpriv->remapped_nvme++;
>> 	}
>> 
>> -	if (!count)
>> +	if (!hpriv->remapped_nvme)
>> 		return;
>> 
>> -	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
>> +	dev_warn(&pdev->dev, "Found %u remapped NVMe devices.\n",
>> +		 hpriv->remapped_nvme);
>> 	dev_warn(&pdev->dev,
>> 		 "Switch your BIOS from RAID to AHCI mode to use them.\n");
>> 
>> @@ -1635,6 +1636,18 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
>> 	}
>> }
>> 
>> +static ssize_t remapped_nvme_show(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  char *buf)
>> +{
>> +	struct ata_host *host = dev_get_drvdata(dev);
>> +	struct ahci_host_priv *hpriv = host->private_data;
>> +
>> +	return sprintf(buf, "%u\n", hpriv->remapped_nvme);
>> +}
>> +
>> +static DEVICE_ATTR_RO(remapped_nvme);
>> +
>> static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>> {
>> 	unsigned int board_id = ent->driver_data;
>> @@ -1735,6 +1748,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>> 	/* detect remapped nvme devices */
>> 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
>> 
>> +	sysfs_add_file_to_group(&pdev->dev.kobj,
>> +				&dev_attr_remapped_nvme.attr,
>> +				NULL);
>> +
>> 	/* must set flag prior to save config in order to take effect */
>> 	if (ahci_broken_devslp(pdev))
>> 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>> @@ -1886,6 +1903,9 @@ static void ahci_shutdown_one(struct pci_dev *pdev)
>> 
>> static void ahci_remove_one(struct pci_dev *pdev)
>> {
>> +	sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +				     &dev_attr_remapped_nvme.attr,
>> +				     NULL);
>> 	pm_runtime_get_noresume(&pdev->dev);
>> 	ata_pci_remove_one(pdev);
>> }
>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>> index 3dbf398c92ea..d991dd46e89c 100644
>> --- a/drivers/ata/ahci.h
>> +++ b/drivers/ata/ahci.h
>> @@ -336,6 +336,7 @@ struct ahci_host_priv {
>> 	u32 			em_loc; /* enclosure management location */
>> 	u32			em_buf_sz;	/* EM buffer size in byte */
>> 	u32			em_msg_type;	/* EM message type */
>> +	u32			remapped_nvme;	/* NVMe remapped device count */
>> 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>> 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
>> 	struct reset_control	*rsts;		/* Optional */
>> -- 
>> 2.17.1
>> 
> 

