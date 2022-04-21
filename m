Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0373EC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 10:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388599AbiDUK4f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388595AbiDUK4e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 06:56:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4929820
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650538424; x=1682074424;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0nT52HKSD5XypZFB6WpRQMozkp5u7xkY6Ho5vUtY7Z4=;
  b=j7SHduuI75Fa6Pg5jD9oIq6GJMYgWxOVetDei2rh7An6OKkG0IiGzbpa
   kNcbpxgineEtIQ3BdpN+5etnr98d0rTSksrD9daez0UboK1UmrZZFHphr
   VeShpoAJZANPiHMDXZmMZhFhHzm08BVAyG92f9m9MdBPmOsTSypcqmFvg
   LmA1Onvck0skUTExmxtAzETYcwSL9i5I0cg44W2DyK7bUWZvxoH6GGp/1
   s34J/3owUQMZSlPYatJQiHb3jJBUi5Z3648qkU7gXzjHjt24IwF1faxGO
   HP51tabSWWo31Ke3PFZb8ZZyp+dY8YsqMltRjV/v8P7R8icCdEVfe1HQw
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643644800"; 
   d="scan'208";a="203326035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 18:53:42 +0800
IronPort-SDR: hJ4GbsElChzopi9NqUUVtYJ3wUHpa/P73uqfFxRDcRYtpaJBGJ8kG4KgZS9vjE8BJU0k6LNys0
 Km6ls818NKyEpvm12wX2pcdBPOEaBUn1FUdZhYtkGpKzIu1C6/TBYunC6Im/VKJX8lLKHwYMs5
 qaUxk7zqVbj+ln8iduK9mUK34tet6nOMOIEY0Pkd83DmdFH0SG5GtZgDUoqNiFTfV3WgqYf/K0
 VCZs7+PfJwQbc6qlt6gJm1UXNA2adAclBgSx+/v2Xor/SU9fqp4fiwz+F4BfzK1z48jk6qTAaU
 X9PnWTqHVa2QmqyuQlXmjuwj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 03:24:46 -0700
IronPort-SDR: yDwVunzvCP1xFkK73plgcKnhkOHofobDQ1GrSRIBrt2z9fu01RTrFulck1d6QpR0CuV0nG1Nme
 mcF2dpzocuRiTBm3tLr9nmYDjweQ0uGg34bPGSHXCG83IDjWL4yxKBYPHn1ArCmBiC6t0yhFAx
 CQiguy8xyfPncZrxIJZ3yvcLj24F9AyCyW61ecLCI5Ca0LYLiA3LfkkW3TjZmM3T5TrlL38i+/
 3PlU3SFCu3wUUDll+4qpsfIYolKHEeNgn2WVTLCdyL5jT9ap/WnrL9KlvuXlcSzwJ2HSfXGoLT
 7Ic=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 03:53:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkZCW21Xwz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 03:53:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650538422; x=1653130423; bh=0nT52HKSD5XypZFB6WpRQMozkp5u7xkY6Ho
        5vUtY7Z4=; b=PJSAJ94Sidw8yMw9AuQXjz9svpVAhgbuIURjHykJUKORTQuUXW0
        4Du2esjM+fEzXnqLN52ZKoLR+44B44DApc8dypMvTK1IVKo1NWy5DAkMdWu+MbMV
        4vMbMYg7RjAx0ckv6GkgOSdbzBecn8RtD8k+SOuFE65mfuyWmT3ok/cTV3TQu8UN
        5glzKGmmcL3qixBGPUBJmlAk002ZirptET3M9g+6wab8O8k3NUjzA+Y8Yd1vSSex
        b8eLpiE1Js8fLOWCWG4kVb7cw01qNiwxQRwrAyL0OWL/0UnfllZcl1pBsCc7lwEJ
        u5icw1GsjPHbLJIdkR03jV2Ao3KotktgHFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TMH-TInDxQVR for <linux-ide@vger.kernel.org>;
        Thu, 21 Apr 2022 03:53:42 -0700 (PDT)
Received: from [10.225.163.19] (unknown [10.225.163.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkZCV28tHz1Rvlx;
        Thu, 21 Apr 2022 03:53:42 -0700 (PDT)
Message-ID: <2a91c02d-4f7c-535b-e047-889df87ebebd@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 19:53:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] ahci: Add PxSCTL.IPM control on actual LPM capability
Content-Language: en-US
To:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-3-git-send-email-RunaGuo-oc@zhaoxin.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1650534217-14052-3-git-send-email-RunaGuo-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/21/22 18:43, Runa Guo-oc wrote:
> On some platform, when OS enables LPM by default (eg, min_power),
> then, DIPM slumber request cannot be disallowed if ahci's CAP.PSC
> is set to '1' and CAP.SSC is cleared to '0', which may cause ahci
> to be an uncertain state (same for Partial).
> 
> In ahci spec, when CAP.PSC/SSC is cleared to '0', the PxSCTL.IPM
> field must be programmed to disallow device initiated Partial/
> Slumber request.
> 
> Adds support to control this case on actual LPM capability.

s/Adds/Add

Overall, I need to reread the specs to confirm all this.

> 
> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
> ---
>  drivers/ata/libata-sata.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 7a5fe41..e6195cf 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -394,9 +394,19 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  	case ATA_LPM_MED_POWER_WITH_DIPM:
>  	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
>  	case ATA_LPM_MIN_POWER:
> -		if (ata_link_nr_enabled(link) > 0)
> +		if (ata_link_nr_enabled(link) > 0) {
>  			/* no restrictions on LPM transitions */>  			scontrol &= ~(0x7 << 8);

Given that the added code below adds restrictions, this comment is
strange. Better change it to something like:

			/* Assume no restrictions on LPM transitions */

> +
> +			/* if controller does not support partial, then disallows it,
> +			 * the same for slumber
> +			 */

Please correctly format the comment and check the grammar. Some like below
is easier to read.

			/*
			 * If the controller does not support partial or
			 * slumber then disallow these transitions.
			 */

> +			if (!(link->ap->host->flags & ATA_HOST_PART))
> +				scontrol |= (0x1 << 8);
> +
> +			if (!(link->ap->host->flags & ATA_HOST_SSC))
> +				scontrol |= (0x2 << 8);
> +		}
>  		else {

Please do not leave this else here. Put it on the same line as the closing
bracket and enclose the below statements in brackets too.

>  			/* empty port, power off */
>  			scontrol &= ~0xf;

		} else {
			/* empty port, power off */
 			scontrol &= ~0xf;
		}


-- 
Damien Le Moal
Western Digital Research
