Return-Path: <SRS0=Dme/=AS=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E018C433E0
	for <linux-ide@archiver.kernel.org>; Tue,  7 Jul 2020 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492B020720
	for <linux-ide@archiver.kernel.org>; Tue,  7 Jul 2020 20:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594154524;
	bh=AnGRUUPwqzcwpLs6pEvzN/rJFDFLsWpe3uIVEGqiWr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=rTvXhloW2COIh3s2muC6Fo7tpzNKo8p0OAxA+Rib/6/zkI7wuSfEQ9A80fGbdqL7O
	 GYuH8Qu3WHW8dyQYJXED9nOtU20tbPHqFxwTa4oA7s3aDPOk9jcN9i2aDAvXdz2pIV
	 LwCI5uPs+GYV7S7B07B+yxQlPHuBj/a6QQ1Z2YNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGGUmE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGUmD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 7 Jul 2020 16:42:03 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988CC206F6;
        Tue,  7 Jul 2020 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594154523;
        bh=AnGRUUPwqzcwpLs6pEvzN/rJFDFLsWpe3uIVEGqiWr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j2EUy+Xh9X4HarBCOIEDlDUsFtpmrZdVwzS2NDWjlKi4VsuWloS9i5zmnmiW5oSTG
         K3EXcBM9inuude2+oF3BTJOtX9Gb83ucYZnVtHsEn5l4gxgJAUJaEsBiIF0RN4JuNz
         ze09c/EdDdu7pfVYHQ39lSmUG5z8HoARoOkS6lfc=
Date:   Tue, 7 Jul 2020 15:42:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ide: triflex: use generic power management
Message-ID: <20200707204201.GA382915@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703081428.1011527-3-vaibhavgupta40@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jul 03, 2020 at 01:44:26PM +0530, Vaibhav Gupta wrote:
> While upgrading ide_pci_suspend() and ide_pci_resume(), all other source
> files, using same callbacks, were also updated except
> drivers/ide/triflex.c. This is because the driver does not want to power
> off the device during suspend. A quirk was required for the same.
> 
> This patch provides the fix. Another driver,
> drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c, makes use of
> a quirk for similar goal. Hence a similar quirk has been applied for
> triflex.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/ide/triflex.c | 45 +++++++++++--------------------------------
>  1 file changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
> index 1886bbfb9e5d..f707f11c296d 100644
> --- a/drivers/ide/triflex.c
> +++ b/drivers/ide/triflex.c
> @@ -100,48 +100,25 @@ static const struct pci_device_id triflex_pci_tbl[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
>  
> -#ifdef CONFIG_PM
> -static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
> -{
> -	/*
> -	 * We must not disable or powerdown the device.
> -	 * APM bios refuses to suspend if IDE is not accessible.
> -	 */
> -	pci_save_state(dev);
> -	return 0;
> -}
> -
> -static int triflex_ide_pci_resume(struct pci_dev *dev)
> +/*
> + * We must not disable or powerdown the device.
> + * APM bios refuses to suspend if IDE is not accessible.
> + */
> +static void triflex_pci_pm_cap_fixup(struct pci_dev *pdev)
>  {
> -	struct ide_host *host = pci_get_drvdata(dev);
> -	int rc;
> -
> -	pci_set_power_state(dev, PCI_D0);
> -
> -	rc = pci_enable_device(dev);
> -	if (rc)
> -		return rc;
> -
> -	pci_restore_state(dev);
> -	pci_set_master(dev);
> -
> -	if (host->init_chipset)
> -		host->init_chipset(dev);
> -
> -	return 0;
> +	dev_info(&pdev->dev, "Disable triflex to be turned off by PCI CORE\n");

I would change this message to "Disabling PCI power management" to be
more like existing messages:

  "PM disabled\n"
  "Disabling PCI power management to avoid bug\n"
  "Disabling PCI power management on camera ISP\n"

> +	pdev->pm_cap = 0;
>  }
> -#else
> -#define triflex_ide_pci_suspend NULL
> -#define triflex_ide_pci_resume NULL
> -#endif
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_COMPAQ,
> +			PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
> +			triflex_pci_pm_cap_fixup);

I don't think this needs to be a fixup.  This could be done in the
probe routine (triflex_init_one()).

Doing it as a fixup means the PCI core will check every PCI device
to see if it matches PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE, which is a
little extra useless overhead and quirks are a little bit magic
because it's not as obvious how they're called.

But since triflex_init_one() is called only for the devices we care
about, you can just do:

  static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
  {
        dev->pm_cap = 0;
	dev_info(...);
        return ide_pci_init_one(dev, &triflex_device, NULL);
  }

>  static struct pci_driver triflex_pci_driver = {
>  	.name		= "TRIFLEX_IDE",
>  	.id_table	= triflex_pci_tbl,
>  	.probe		= triflex_init_one,
>  	.remove		= ide_pci_remove,
> -	.suspend	= triflex_ide_pci_suspend,
> -	.resume		= triflex_ide_pci_resume,
> +	.driver.pm	= &ide_pci_pm_ops,
>  };
>  
>  static int __init triflex_ide_init(void)
> -- 
> 2.27.0
> 
