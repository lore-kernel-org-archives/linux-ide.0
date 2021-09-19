Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C947C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463A861205
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 13:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhISNIc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhISNIb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2021 09:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632056826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSV1fiiQiqM7zkda1AZckSbb14ibuCt8qjVoxm4AB3Y=;
        b=a32ZjCy7S+3HxUAdQpTN699Ff4qw2brkca8xH0TauZG/j8gkej9p+MNDtetoiKfaDv2/cn
        manWBYRX4BOTMlR9hcodKie2DdXuFkglJ4/DI0MDKm6uxhhb6C10XJIRfGIkiXqHOAJD3g
        ck6D81P9P4ZCt6hHimoeaVCxz2dVuLU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-oPIlAF3mNkCnXPn2qSPkjQ-1; Sun, 19 Sep 2021 09:07:04 -0400
X-MC-Unique: oPIlAF3mNkCnXPn2qSPkjQ-1
Received: by mail-ed1-f70.google.com with SMTP id w24-20020a056402071800b003cfc05329f8so13367973edx.19
        for <linux-ide@vger.kernel.org>; Sun, 19 Sep 2021 06:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSV1fiiQiqM7zkda1AZckSbb14ibuCt8qjVoxm4AB3Y=;
        b=gtkM9KgfezLnvv63Uop7CqbDCGwXX6RG11/GSk5iey1fn1b5q7xUa1CxX7S9zcENkb
         jWFaaJHucEGMuFpxbm4OJZX9OS46aBZGaoKILe4kjFxSqVwhRkRG4TNGQ63IZZBA+/Nn
         mlqZ5apa/X4OIQr9nPIQby+kphar/8Ie6V6C1AkGQHBDRPgglteethDGdqVu3jILfyKV
         nJMZAw8+C64YcKW4IB4LyCF8crx2J/8x3J+OKHXtGK+g784GjbdVFVbPmr/EYyI9Abm7
         u3P7jiAVx0thSCN/EIAZDIW/WeBBcgXWosO8eFDGwIsDavuaQCSCBik4YZkoXTjNxGEW
         5E0w==
X-Gm-Message-State: AOAM533zUFjl5jWWVjmjy7Szykn+pxXwLNTQPTEtffKQp6eCpUW1w76m
        IApU9MSPUMWOjfxJ9/LvvBVMUiIploswgtnby42HkWaQe9F/wwykq3+tvYb1eJpzoDLztSBEvfE
        cTD1Iqa+OXyz1lroeMmpY
X-Received: by 2002:a17:906:7147:: with SMTP id z7mr22792355ejj.94.1632056823715;
        Sun, 19 Sep 2021 06:07:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYMen7qgiNk2u2tBQGaLCtCtuL2r5BFu8S8KRJrLVgAcI5XJi6KUoNjPlKAimk5kZ/PFmu/A==
X-Received: by 2002:a17:906:7147:: with SMTP id z7mr22792328ejj.94.1632056823478;
        Sun, 19 Sep 2021 06:07:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p8sm4877375ejo.2.2021.09.19.06.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 06:07:03 -0700 (PDT)
Subject: Re: [PATCH v2] ahci: remove duplicated PCI device IDs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexandra Yates <alexandra.yates@linux.intel.com>
References: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bf0e4e5f-4638-ad1e-d4a4-32a4475b247e@redhat.com>
Date:   Sun, 19 Sep 2021 15:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 9/19/21 11:43 AM, Krzysztof Kozlowski wrote:
> Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
> as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
> has board_ahci_nosntf (for ICH8).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> ---
> 
> Not tested.
> 
> Changes since v1:
> 1. Use still board_ahci_nosntf for 0x2822.
> ---
>  drivers/ata/ahci.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 186cbf90c8ea..63198ad95ed9 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -258,7 +258,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
>  	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
>  	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
> -	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
> +	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
>  	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
>  	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
> @@ -316,7 +316,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
> @@ -358,8 +358,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
> @@ -394,10 +394,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
> -	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
> 

