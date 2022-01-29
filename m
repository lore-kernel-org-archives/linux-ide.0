Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DC9C433FE
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jan 2022 05:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiA2FYN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jan 2022 00:24:13 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7816 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiA2FYN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2022 00:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643433854; x=1674969854;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Jk42hyb+rz6GmQspOYDsniFVs1IHst64qX8uGwXc6EI=;
  b=VjNGd6DBsVEuYdQ07sV2FaWoc+Ev33ttQ2p2s0IqK29UvkXohJPfUar8
   aZwUw6+JsH7uKTsz22Fni3Uvpirt1Xw3FZoLOVpIE5uOmqeW/N+kn+glL
   C3lwX24GawbOBbm/M8R8ZPSnjPgZ18MVF2MURnfjZ08S7/rqqWtYEqH9j
   lV/XR5vBZAiGntwDmgNeIUYucID1JR1CV/xEC03ufq5fLGFwV6De+D2kM
   BvW/NHsZL7WcPCM0oh9zQpjzaU8+fiO0ufiEhoTD3nU5BdD3SarzL42Ue
   WfkdkkXSluv0iGOsp2Y8y7HgfbfsB0+K6KEChqfdDmq9k8N1IyhLvyslG
   g==;
X-IronPort-AV: E=Sophos;i="5.88,326,1635177600"; 
   d="scan'208";a="192673058"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2022 13:24:13 +0800
IronPort-SDR: qNays7qF0TdjWoyrwPlPdp9NDOLFTNqXkWfdz9YinCoQeaLxeXNPy54lTCPyh9jhqWPQHMQwMG
 7vcHevWfoiOgM1HoFKfqIB8cQxk0ouuoelxSdIknu4dndynXuf/tjzv8tloYF9z+Xeb5swvC6d
 2w3qtMro+KOtbvGiprsTD0W3IO/18yV3amwkgaD87pcDTGNi6nja4MY2oCrPXpUSnZxA9ytxmF
 dhoqozA2QeGxjPXYhVEZEyW809vKVoYrRe+HYjLSO7Ev8BBh3dxEj6VJD/QRU35p0U/ln/H30b
 xJ6djYPatqQsne9pDNpWN5gj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 20:56:14 -0800
IronPort-SDR: JZNFVebdVs/+ZkuCijCCA/ikYFg9ricYzN7Kt6gv7WERvc681K2E3dydzVSOa6nju8rl6iLiPc
 mqijU+O+mJYJ24JUw3Taf/5WP53L+wiMeeZO89oDaUz62JobsMEHSpqdT1rewJnyeMKU/dpSDy
 P7seBQFBe8Wy9h2/o21OE0vVL7J84gpXqqCKGii9XKXRfyIPOsIZwTHuQJYodnha3B31Ej1Ky7
 MQtRV9NYSUAvZL6YDG8Gf0Jqae2KEGnIOQ2cXbWVCUi3KQlbsA6vsjw08ucCI9c0T/q7Xb+NfB
 yos=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 21:24:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jm2n81h18z1SHwl
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 21:24:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643433851; x=1646025852; bh=Jk42hyb+rz6GmQspOYDsniFVs1IHst64qX8
        uGwXc6EI=; b=hmKaqng6VCuBmUiFEcakuAiAvCbaOOc3yzAVWhQ1tfMbp12cl4k
        B/pZVEE637lzbCLgyZkejbI5bVvbYRR79PeaNwRnm3hdiWOQoiJeHw6/3U0lvnZ7
        sDIlO0vp0Yr+6eTF9Tp9PdSGlcln4MYzFXXgAkEhYcDpXqcJLeW5LSeC06Xxsbq4
        0yh+hJ0L2lH8BnxnCX4Ew4OEhmpRBDTvoYFqH1y79YvcUC7BvgFXpp5+NRAxdzEB
        CFaTIM7LOjuOQJukYyRgYUkUSyRJln9y8ZTpvrKXLPOo6iQOV9MF+Bxzblw7ux0y
        x6LOTgjqF7MPuiL+5Xsu1qieQHbJxN5EhLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8C45kbnvd-uC for <linux-ide@vger.kernel.org>;
        Fri, 28 Jan 2022 21:24:11 -0800 (PST)
Received: from [10.225.163.60] (unknown [10.225.163.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jm2n72Lbmz1RvlN;
        Fri, 28 Jan 2022 21:24:11 -0800 (PST)
Message-ID: <4c79f0c7-a147-f371-5c06-28a0827bbea2@opensource.wdc.com>
Date:   Sat, 29 Jan 2022 14:24:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: ata_{sff|std}_prereset() always return 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <d63ddc77-ddc8-d15a-030f-592cece64742@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d63ddc77-ddc8-d15a-030f-592cece64742@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/29/22 05:45, Sergey Shtylyov wrote:
> ata_std_prereset() always returns 0, hence the check in ata_sff_prereset()
> is pointless and thus it also can return only 0 (however, we cannot change
> the prototypes of ata_{sff|std}_prereset() as they implement the driver's
> prereset() method).
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git' repo.
> 
>  drivers/ata/libata-core.c |    2 +-
>  drivers/ata/libata-sff.c  |    6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -3568,7 +3568,7 @@ EXPORT_SYMBOL_GPL(ata_wait_after_reset);
>   *	Kernel thread context (may sleep)
>   *
>   *	RETURNS:
> - *	0 on success, -errno otherwise.
> + *	0 on success.
>   */
>  int ata_std_prereset(struct ata_link *link, unsigned long deadline)
>  {
> Index: libata/drivers/ata/libata-sff.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-sff.c
> +++ libata/drivers/ata/libata-sff.c
> @@ -1708,16 +1708,14 @@ EXPORT_SYMBOL_GPL(ata_sff_thaw);
>   *	Kernel thread context (may sleep)
>   *
>   *	RETURNS:
> - *	0 on success, -errno otherwise.
> + *	0 on success.

Well, since the function *always* return 0, I would just say so, since
"on success" can of imply that there may be failures.
Something like "0, always" would be better I think.

>   */
>  int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
>  {
>  	struct ata_eh_context *ehc = &link->eh_context;
>  	int rc;
>  
> -	rc = ata_std_prereset(link, deadline);
> -	if (rc)
> -		return rc;
> +	ata_std_prereset(link, deadline);

I am not a big fan of such change. If ata_std_prereset is changed to
actually return an error, the above change would result in a bug...

What about fixing things properly:
1) The ata_std_prereset comment says it: ata_std_prereset should not
fail, so let's make it a void function.
2) The only direct user of ata_std_prereset as the pmp_prereset port op
is libata-pmp.c, so let's just add a static function there that calls
ata_std_prereset and return 0.
3) ata_sff_prereset also always return 0. So ideally, we should also
make it void and have a wrapper for the drivers using it as the prereset
port op. But there are more places to change than for ata_std_prereset,
so not sure this makes the code cleaner. Worth looking into it though.

Thoughts ?

>  
>  	/* if we're about to do hardreset, nothing more to do */
>  	if (ehc->i.action & ATA_EH_HARDRESET)


-- 
Damien Le Moal
Western Digital Research
