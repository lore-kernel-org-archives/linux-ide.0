Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498FC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 06:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiBPG1h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 01:27:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBPG1g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 01:27:36 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF42BB15
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644992838; x=1676528838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H5ECCjkXSSgDUxcG23d+Ni4yyGGh694Y32vEzWgKcuE=;
  b=ATHC+NqgzjlThYIvYXhmMnPtOf/hnTJaBH+54Hq4gKlzwdGpDwUI0Epz
   TQnG68Rdd+bAz4ni2+KGWsz/4eHr3FO7GgOnvyVjQr9gDwLEp4h0L7jlk
   jzsxQuqiJ1eTPvsgVzqJrRjGfqD1ggSBhwC9gRZGoJbQ1sxY+X44Y9wX+
   hUmJjhyYUqjiQ5egievK4SUIphg6zXp1zxavmaX4qz+RkSJxiXy9Hq3Fs
   tDdy/t0+qxWdrXuyLxeNLyC6qvSQEQvhrTHXyVTg5dfoz3Vv33n4pDrnc
   TJ85zqeFhfhjPUaLFmvHy5Upmb9JAjn2B6LA8c+tXjl4XeIjCGmek6vk4
   A==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="192004178"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 14:26:46 +0800
IronPort-SDR: gGxrYwOrHauCbA5I8EkIOgVbIUYgujlqp8OMasfJwYg/T9kwVFfvJJtmzqix4xTL8sXJ/rOqWm
 EncPi7vbPn1jS9HmvkpRuM9MfrGahq5BlIEntN5p0PpUEijG7gOcNj5wu/xMgkjHesKg7MBHzV
 pQOirxwfZ9ItKbnn0QYsu9HFYYR+x5mbBCtIRJ3N4GjWsimF/gABIJ4RZws4lFZiXfrTfsXG8y
 hAlklD+8d8TYRnw0MF1GJod0SrUeIYmpcDeVpeYws5TFHfdo/ubvgfB/5yn8v9KwH4LYG8JCxu
 rGeUwA/9Dtca/t0sl+r9FAlK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 21:58:27 -0800
IronPort-SDR: 3URbt9GiraqXvvdYy2ALpigzjcbQ76/uj2z9O/Iqz2bTaHvf0rHcpwBf1BRtNBwHXqGc/7yWwf
 Uq1XLJDDD1cHphMbY2pRfvhMG+jgvu98Y2p0IBvE85yD6RCAU2SVc6kr3lis9DG16G36NFc3Zp
 fne4E35fMlR4Boy9ISC0cM+YEU3IPSSZCmkEzhxlMojcgYAKBT47FaZB6OcZNSDh5F8SL1EnIE
 Mb1coxDMqZ3jnd+25SzmDA6rKvmlVgVpGi7QGEgrG/FUUdDG/vWoDxvx4sdk8mSrX+us94UPSu
 mLk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:26:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz7K22b3Mz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 22:26:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644992805; x=1647584806; bh=H5ECCjkXSSgDUxcG23d+Ni4yyGGh694Y32v
        EzWgKcuE=; b=tZg6sdWcT7M0nL5Zl7bs0acxQROCxEJR2PrPs8yNiTsmQ+l/oP8
        UEv2A9say+4bEBOjvLUGF/buIlO8pIEMTDR75lgem0zAXkMJdIhd4JdnL+6fsIO3
        kzzKAVnLTL4vnDh23R1kkT5YcvucX6uZIjBFWYuaGP1cylv+IRCgLJrkX5uVSNI3
        oECJD5e9iUikPrgqYMDgqJylb2ypm82VCXvkuKLN/U/gmrmHhtMNbqftf1qTgnW3
        GYYavYKmXlUteIN4NDhguXlP+u42yk7r+O7n9CUxhaTiGLNRpiA6raiBLYYLJhsO
        KqkYO0fIDoDmWDn7R4a36rhCwwElooRXqsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id REJPOhLO1oOv for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 22:26:45 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz7K03gj0z1Rwrw;
        Tue, 15 Feb 2022 22:26:44 -0800 (PST)
Message-ID: <91c6d9a0-b81f-fa3d-c69e-5f3d23c01ec9@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 15:26:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pmenzel@molgen.mpg.de, hdegoede@redhat.com
References: <20220216025934.1892723-1-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220216025934.1892723-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/16/22 11:59, Mario Limonciello wrote:
> This board definition was originally created for mobile devices to
> designate default link power managmeent policy to influence runtime
> power consumption.
> 
> As this is interesting for more than just mobile designs, rename the
> board to `board_ahci_default_lpm` to make it clear it is about default
> policy.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/ahci.c | 96 +++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ab5811ef5a53..67f3b3b23639 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -49,8 +49,8 @@ enum {
>  enum board_ids {
>  	/* board IDs by feature in alphabetical order */
>  	board_ahci,
> +	board_ahci_default_lpm,
>  	board_ahci_ign_iferr,
> -	board_ahci_mobile,
>  	board_ahci_no_debounce_delay,
>  	board_ahci_nomsi,
>  	board_ahci_noncq,
> @@ -135,7 +135,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> -	[board_ahci_mobile] = {
> +	[board_ahci_default_lpm] = {

What about simply calling this "board_ahci_lpm" ? Shorter :)


>  		AHCI_HFLAGS	(AHCI_HFLAG_IS_MOBILE),
>  		.flags		= AHCI_FLAG_COMMON,
>  		.pio_mask	= ATA_PIO4,
> @@ -275,13 +275,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_mobile }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_default_lpm }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_default_lpm }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_default_lpm }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_default_lpm }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_default_lpm }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_mobile }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_default_lpm }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
> @@ -291,9 +291,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_mobile }, /* PCH M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_default_lpm }, /* PCH M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_default_lpm }, /* PCH M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
> @@ -316,9 +316,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_default_lpm }, /* CPT M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_mobile }, /* CPT M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_default_lpm }, /* CPT M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
> @@ -327,29 +327,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_default_lpm }, /* Panther M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_mobile }, /* Panther M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_default_lpm }, /* Panther M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_mobile }, /* Lynx M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_default_lpm }, /* Lynx M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_mobile }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_default_lpm }, /* Lynx M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_mobile }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_default_lpm }, /* Lynx M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_mobile }, /* Lynx M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_mobile }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_mobile }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_default_lpm }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_default_lpm }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_default_lpm }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_default_lpm }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_default_lpm }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_default_lpm }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_default_lpm }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_default_lpm }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_default_lpm }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_default_lpm }, /* Cannon Lake PCH-LP AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
> @@ -381,26 +381,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_mobile }, /* Wildcat LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_mobile }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_mobile }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_mobile }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_default_lpm }, /* Wildcat LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_default_lpm }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_default_lpm }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_default_lpm }, /* Wildcat LP RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_mobile }, /* 9 Series M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_default_lpm }, /* 9 Series M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_mobile }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_default_lpm }, /* 9 Series M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_mobile }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_default_lpm }, /* 9 Series M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_mobile }, /* 9 Series M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_mobile }, /* Sunrise LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_mobile }, /* Sunrise LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_mobile }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_default_lpm }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_default_lpm }, /* Sunrise LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_default_lpm }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_default_lpm }, /* Sunrise LP RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
> -	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_mobile }, /* Sunrise M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_default_lpm }, /* Sunrise M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_default_lpm }, /* Sunrise M RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
> @@ -413,13 +413,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
> -	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_mobile }, /* Comet Lake PCH-U AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_default_lpm }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_default_lpm }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_default_lpm }, /* Cherry Tr. AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_default_lpm }, /* ApolloLake AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_default_lpm }, /* Ice Lake LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_default_lpm }, /* Comet Lake PCH-U AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_default_lpm }, /* Comet Lake PCH RAID */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> @@ -447,7 +447,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>  	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> -	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_default_lpm }, /* AMD Green Sardine */
>  	/* AMD is using RAID class only for ahci controllers */
>  	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },


-- 
Damien Le Moal
Western Digital Research
