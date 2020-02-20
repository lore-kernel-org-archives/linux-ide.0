Return-Path: <SRS0=dJ96=4I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5CAC34031
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 05:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D3424656
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 05:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgBTFpm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:45:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBTFpm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Feb 2020 00:45:42 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4eea-0003Ew-8V
        for linux-ide@vger.kernel.org; Thu, 20 Feb 2020 05:45:40 +0000
Received: by mail-pl1-f197.google.com with SMTP id t17so1594208plr.13
        for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2020 21:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r+7eTHe8KL+VeIoWLw3hko3fa/QAiy+7oilQugEJ+og=;
        b=QhFmUTBbX0v9Roza6KBg+T/6H505O8xkcEcZgNJlIrg9qrxNGunVSdcUlhPfe2oXOy
         tS1R12jr78x6yBXKsYYyQxmB+88ydhG22jB+lEz6tYgOCwe3d914yaT5DJS15EWu5s9t
         BzH43dXfGLPwqMxbHbsRX+B3FHRuREgPnuWPIemuWCOuSUJ3ZQMuW0zLfFMKyhw6Pbuh
         CC4zO2DCe4uCkItGNOWLCXdbw3Euwf7UfQeknfQVq9iYzyGlWXE6g8LYNL+rG7uCPly0
         APL5zOntEbgh8EnubuSZ0B2XhOK3ZyLO459jaBr+IWXjxbCksEGaMTQdcThEArf/rD/c
         HYAw==
X-Gm-Message-State: APjAAAUKmoHQeUMBOFs6guqdj0xUsyxPcNrmXgaHZfSgbXeHDiIAmirT
        4mx2j2/nluLEVJA3qbDCEr1usD5P2MYffq0LHRupY9kEl3/oehPVLDUEfScTnFZlxMaUT9YRx0i
        XPr4fSYA17/zcBxkcSEh+QC2r/kr3ccrpbwjohA==
X-Received: by 2002:a63:de0d:: with SMTP id f13mr32467302pgg.12.1582177538612;
        Wed, 19 Feb 2020 21:45:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2DlR3aide/wjBmgWYBGl91XfJf+GJLWBQ3TEMQbtUy+spD7m3Ptf6W65rzIuhL93pK8cH6Q==
X-Received: by 2002:a63:de0d:: with SMTP id f13mr32467283pgg.12.1582177538290;
        Wed, 19 Feb 2020 21:45:38 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 64sm1572652pfd.48.2020.02.19.21.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 21:45:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] ata: ahci: Add sysfs attribute to show remapped NVMe
 device count
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200207100016.32605-1-kai.heng.feng@canonical.com>
Date:   Thu, 20 Feb 2020 13:45:36 +0800
Cc:     anthony.wong@canonical.com,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D1CCEA35-D7D4-40E3-85C4-E82FD1154AB7@canonical.com>
References: <20200207100016.32605-1-kai.heng.feng@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


> On Feb 7, 2020, at 18:00, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Add a new sysfs attribute to show how many NVMe devices are remapped.
> 
> Userspace like distro installer can use this info to ask user to change
> the BIOS setting.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> drivers/ata/ahci.c | 28 ++++++++++++++++++++++++----
> drivers/ata/ahci.h |  1 +
> 2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 11ea1aff40db..cdbd995a7a6b 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1488,7 +1488,7 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
> static void ahci_remap_check(struct pci_dev *pdev, int bar,
> 		struct ahci_host_priv *hpriv)
> {
> -	int i, count = 0;
> +	int i;
> 	u32 cap;
> 
> 	/*
> @@ -1509,13 +1509,14 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
> 			continue;
> 
> 		/* We've found a remapped device */
> -		count++;
> +		hpriv->remapped_nvme++;
> 	}
> 
> -	if (!count)
> +	if (!hpriv->remapped_nvme)
> 		return;
> 
> -	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
> +	dev_warn(&pdev->dev, "Found %u remapped NVMe devices.\n",
> +		 hpriv->remapped_nvme);
> 	dev_warn(&pdev->dev,
> 		 "Switch your BIOS from RAID to AHCI mode to use them.\n");
> 
> @@ -1635,6 +1636,18 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
> 	}
> }
> 
> +static ssize_t remapped_nvme_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	return sprintf(buf, "%u\n", hpriv->remapped_nvme);
> +}
> +
> +static DEVICE_ATTR_RO(remapped_nvme);
> +
> static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> {
> 	unsigned int board_id = ent->driver_data;
> @@ -1735,6 +1748,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> 	/* detect remapped nvme devices */
> 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
> 
> +	sysfs_add_file_to_group(&pdev->dev.kobj,
> +				&dev_attr_remapped_nvme.attr,
> +				NULL);
> +
> 	/* must set flag prior to save config in order to take effect */
> 	if (ahci_broken_devslp(pdev))
> 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
> @@ -1886,6 +1903,9 @@ static void ahci_shutdown_one(struct pci_dev *pdev)
> 
> static void ahci_remove_one(struct pci_dev *pdev)
> {
> +	sysfs_remove_file_from_group(&pdev->dev.kobj,
> +				     &dev_attr_remapped_nvme.attr,
> +				     NULL);
> 	pm_runtime_get_noresume(&pdev->dev);
> 	ata_pci_remove_one(pdev);
> }
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 3dbf398c92ea..d991dd46e89c 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -336,6 +336,7 @@ struct ahci_host_priv {
> 	u32 			em_loc; /* enclosure management location */
> 	u32			em_buf_sz;	/* EM buffer size in byte */
> 	u32			em_msg_type;	/* EM message type */
> +	u32			remapped_nvme;	/* NVMe remapped device count */
> 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> 	struct reset_control	*rsts;		/* Optional */
> -- 
> 2.17.1
> 

