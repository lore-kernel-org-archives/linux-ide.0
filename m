Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B9C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Feb 2022 21:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiBYVUu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiBYVUt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Feb 2022 16:20:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F7021F081D
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645824016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ugb72Q212gn7WpEYqytVF4bxguHX/b09etPHHCFO4RA=;
        b=h3vPx5tuHdft9/KgoEnR22UY9eocf5vxeXw8n73SST0Cc7siCS6BJ6yS/2K9Uozp/eBlJg
        5CTcc33vGAFbt+wtv3yXVyoL8I8EqtKQpOo2QPQrpt3EP9z+ezJJfO/zlW/X4fg43EB52Q
        PaZqq6Q/bKpQC9cF1jmk+tcp6qBHkRE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-y2S2uEiHNLmIDn6WnnKhzw-1; Fri, 25 Feb 2022 16:20:15 -0500
X-MC-Unique: y2S2uEiHNLmIDn6WnnKhzw-1
Received: by mail-ed1-f72.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so2863361edo.22
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 13:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ugb72Q212gn7WpEYqytVF4bxguHX/b09etPHHCFO4RA=;
        b=6RGT3gX/lcJS/MQIMlFfGkcActfphfgeg6ZtOFJv1TJBVc/hu/K9YTuxlOW7bbbH+j
         yPaP30iBgTcXnzMGjjZh4JfYBirnF7jdXOhvwfrwb3NHrQTssErYc8iYSef0CYl8lo59
         cOYslFWsuecQ+6nqG1ZQjq/4qNbGwRSNn6/wKeW6eWaGOiL7uC8x9U+f74a9wwO1B8oP
         3jdbsJAlgwPgC/D7m/Pa31dmm3+OCxgNuVxozL+47mFd/u1R7d9DP+td6zoLFy6gMFnO
         GEsoABxoiICs47AnLkWV4jxABdWIk5MckjRqVdWXMkq6ivaxBczqh2QGowYQL/G2+Q2r
         ltCg==
X-Gm-Message-State: AOAM532tQuKh11liIBg821ZtOWFcggeNohMocIlT8CVGTsWoyJJyfsAA
        BSUi5v/UX8qMiYoLDaMLZ1m2CveBPVtMDzz9jqTPXSBuBuE8QkUDdGjhb/8lSnRh2t+ZAsegbCe
        OZWu0FD5bN82Fbip6AstI
X-Received: by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id o3-20020a170906358300b006d10c07fac0mr7518604ejb.749.1645824013702;
        Fri, 25 Feb 2022 13:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7SsVEDi1/MAB8+gG92lpoC4RvLkLfpYUxil0fJrTsJ8dUE7+sBLp6j68kF83ByiyCQXbQOg==
X-Received: by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id o3-20020a170906358300b006d10c07fac0mr7518595ejb.749.1645824013482;
        Fri, 25 Feb 2022 13:20:13 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906951600b006cf03c6af99sm1411726ejx.193.2022.02.25.13.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:20:13 -0800 (PST)
Message-ID: <7381d145-ac6f-60f4-296a-7b191296964a@redhat.com>
Date:   Fri, 25 Feb 2022 22:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220225181030.980223-1-mario.limonciello@amd.com>
 <20220225181030.980223-2-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225181030.980223-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/25/22 19:10, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policy for the
> ATA port be `min_power` or `min_power_with_partial`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/ahci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 17d757ad7111..af8999453084 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1584,8 +1584,16 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  					   struct ahci_host_priv *hpriv)
>  {
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	int policy = CONFIG_SATA_LPM_POLICY;
>  
> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +	   !(hpriv->cap & HOST_CAP_SSC)) {
> +		dev_warn(&pdev->dev,
> +			 "This drive doesn't support slumber; ignoring default SATA policy\n");
> +		return;
> +	}
> +

Don't the capabilties get checked later when the policy gets applied ?

At least I think they do get checked later, but I have not looked
at this code for years  ...  ?

Regards,

Hans


>  	/* user modified policy via module param */
>  	if (mobile_lpm_policy != -1) {
>  		policy = mobile_lpm_policy;

