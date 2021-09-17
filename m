Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205ECC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 17 Sep 2021 11:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E47611C8
	for <linux-ide@archiver.kernel.org>; Fri, 17 Sep 2021 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhIQLWb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Sep 2021 07:22:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8369 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhIQLWb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2021 07:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631877669; x=1663413669;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fw4xa9xepMpGamCD+e5caMq0zjIaQr2kunX3DwHfCN4=;
  b=KpK+NfxlI9H6ImjpDAg/mf1ZnwkGKtKDjIrf+xf9kzkjbLWTryGw5W7i
   DLzCzCOGN8AJgeffwJiipZFgFZxTVAdczibT5VhGeYrhhi4Lxcs9RFAnI
   8ewcA4mHeI56HsGGi5BtZT+1KbE3s2Qpxgp+0leOM20I0AP8h9ueAFqlB
   IxiXwlU+GkDJHdAKsCiIkkHy1JcgeUXDTLjK1LkLaf5RWOc9kpPy0zwhP
   X4HyrrtI0sWufl0kz/xuohVrkoFO/vJ7ai3O19wWmNvwH2qoficOAvLDK
   15nulT5Ks+ukOpQgiy574zHNbMRfR1lcm2H8F/Zn87p9dviQKU64XqAso
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,301,1624291200"; 
   d="scan'208";a="179335429"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2021 19:21:08 +0800
IronPort-SDR: 7Of+JGp7WIuAifsDh+/YAl+x5rOM4T5pcDOJEmXJn/vC/zje2Nj7bvszu9RxbX5oqsx7cjZs+Q
 DNDCcgppRkTzAhR2R00upQtUhJ0AXzVCiiZDnqUvitA+9eU0gRVuaMjLIklMkdFpuLlIY9pqkW
 6I3B4mWG3VPY5I3/BGFB9nmhETkqTk4THOY7ydodnX9gbfDDgvCFNsO5qnCl38yhXQbULeO1BJ
 fpfW6gJ9N0qAWVOCeSy6fECo3QQn+0UwrNyYne7yZzXFa+4YfaiPNF9C9+FivxBd4b8njD6r1L
 DuO0y4zUv6WJHD9KhGFP7H0p
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 03:55:54 -0700
IronPort-SDR: Nxv3SI3+q09s+DZcTKPKl5mZ42jYCZ1YHuVs82I9Wb2NhbwaDfw+qZEmQ7izTExWiuWEqyb4+K
 nJY1QN5dHeblf+C8wPYNQvnzE1PJK0IK0ohRL7YQre0XMcIkmT6Q/7OWU3xNF5N4I6cX1T5z2J
 VQCpKi+SplZ/m6501RAGCriw/KUofysuC0HS5Z7OrYzz9CY1ND/zEPs78H0XusL8ydI6iu/7BJ
 yi3cz58dgce/VY8BMCNEtv3hvRBA6JryFtKdRoWGDIp11GACD5HhnMb1akcD/KGVazSqh5Lth/
 vSg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 04:21:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H9s2q6Bvgz1RvlV
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2021 04:21:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1631877666; x=1634469667; bh=fw4xa9xepMpGamCD+e5caMq0zjIaQr2kunX
        3DwHfCN4=; b=a7GBgwuiscbOJi6IvaBn7VoXD7v9bqCtm//tFc1XYPJfYJUP+TI
        TL+HPti0jnvqphBTHO2Tn5/XKreurX7iuDlWqTFdbAe67S3HMDtl8NtvH5BlYlSk
        ab5dcdC+eAEbjp4gaQQjPsHMWdPIMAKcXJ1f3poyh6cod4Snf0m5HDMkn9w5u1sr
        ViAZbyKzzuoZnbzgGL7b2nq+Vuc5k3dlHI6tWGMnc8qNIjPkEENxG/i6VUr3+G45
        V03QvvbedxPzm0l/4Cmv7QbeOGdc1IS4TPmiMMUMx43DpSKGjHogCHmm7GWvTUyT
        hjixGdjJgdY8dDW/zuSiQR1WJm8zDVxqKBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C5_GlVpsfFgh for <linux-ide@vger.kernel.org>;
        Fri, 17 Sep 2021 04:21:06 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H9s2p2y3Lz1RvlP;
        Fri, 17 Sep 2021 04:21:06 -0700 (PDT)
Message-ID: <dbfab8de-487d-a5ea-6397-7e16c5eb5185@opensource.wdc.com>
Date:   Fri, 17 Sep 2021 20:21:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH] ahci: remove duplicated PCI device IDs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210917102442.24818-1-krzysztof.kozlowski@canonical.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20210917102442.24818-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/17 19:24, Krzysztof Kozlowski wrote:
> Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
> as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
> has board_ahci_nosntf (for ICH8).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Not tested.

I cannot test this either. I do not have this hardware. No chance of getting
this tested by someone ?

Changes for 0x2823, 0x2826 and 0x2827 seem OK, but 0x2822 is weird.
Since it is replicated, I think that the second entry was in fact never used as
the first one would be a hit before the second. So shouldn't we keep the first
entry with board_ahci_nosntf and remove the second one with board_ahci ?

> ---
>  drivers/ata/ahci.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 186cbf90c8ea..5f257064fcd8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -258,7 +258,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
>  	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
>  	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
> -	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
>  	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
>  	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
>  	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
> @@ -316,7 +315,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
>  	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
> @@ -358,8 +356,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
> @@ -395,9 +391,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
> -	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
> 


-- 
Damien Le Moal
Western Digital Research
