Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71AC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 08:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiBBIcg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 03:32:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35963 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbiBBIcg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 03:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643790756; x=1675326756;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IN/pKYwzp9rXdM5Hy5V+ymsIMiyr3YaretU2tRkF2fo=;
  b=IODhHyapfNoEFnm4xuQE99xB9ESdC6MTeh6FIJIHLulQ+e2p5AkYf9s1
   GQ0yk53E91S5iQjIPeNwf92VZOs7yxiC3gUJBb5WYgn6vVltG8hl74UyQ
   XJf1iJgjilC0xvXI9eYuJWAgkDM3oc0A6W3Ob8wIT40Gdr0ClprVomg4K
   wOp//evWJZnbTgbFWYhvQUui8ujvycIkEP3xmWlJR92jmSLQB5jzvgU8W
   xYBdbfpzYWAmJ1Emj8zhKQlAKLNs59G+hXPm+xZeKM8/U5HPNlV/Ex6a9
   IMYK7GzVZM1dAmo9k9uweCjUWuu27tiHQMuoYzg9IoEZsY4T5GyvmLD9t
   A==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="191960318"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 16:32:36 +0800
IronPort-SDR: WwSsvnqKDzJpW78F+mc3R/IisQTcFNJKmf5PayyeYM5WzRJ8vvPjwTR5ueQwfNA9HPWrXegi+c
 JPJwtcggBa3eF6zIlSqGodDMQnR4xWmDi79UxITmUhcfC2rEjssyxS4i0zTFMqsSp2cogo5T3h
 3ngIsxbEqucw/VISTloddqK3gyzYl5JohDkhasbNvtzsrKjyYW5WcId3mO9YcIic+IhMkWVZJt
 74cWViZkyV98M6igvgKiM508U/JEHwUwxop5hdJwXjomArs6MoACV1WHSv7tiPuQ+fBg6XchXS
 aLNCmtTQzDbY7n0WBcJN4fYQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:05:45 -0800
IronPort-SDR: NaPvrECYZAU0Ph7tFS+5zyIPB2jeKEWqJDCJH9DsORe4K1tPuu1Q19umMLMbLxMTuCfuCRSaTj
 W9IZKbOhL69UFIDAfkFmMf536QpcVQ6sFrTVbD2LPtt7q6oEcoKThjDNTh3KS9IeAidWIlDZDW
 wypLXC2zLxBeVDlvnNZoh3s1L7HcN50SoRUg90MJLGJhUkjDO10M1ZdS8QIiJAUoKxGAVON6C3
 TyXR804uvgiTS3BBsLJbRBMPqJ5ZQFcRrhKBQ9PuHAFBFE66QS+KaaOb6HOTkaxyjFFd40i82Q
 ZLk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:32:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpZmg6CNrz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 00:32:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643790755; x=1646382756; bh=IN/pKYwzp9rXdM5Hy5V+ymsIMiyr3YaretU
        2tRkF2fo=; b=dPSW/vf/PI6tP6+ZqoNivGQ/+8xxQVItD6bJo2kDJlInQ+z2PQi
        vYB2VvBIL4TjQDjIRTgeY81Qx9dSxBnXQIaUHvB1y4qbee0uB//2uMVjB9ZX2hRa
        oG2GVMECkyf86YjbOYdNvRSvegHz9d8gx5UuG8RFiRrmQHxByXVwxmcAOxzK/uCl
        FShJTKr6WJNsGXALw0XvbEfKNFzY++PjVcvebcotQ+bqwsoNcNSejMo4vbyT9DeE
        qog3xZcdlRagAW2K5TZ3hEY6+b8K182BhSmSMtEm62nYikdFAoFBlA9660GzNk1U
        zuGf/6CmHo9tzJcmNI08Jf3nrTjXdAsA68w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9znxkNZZzTHE for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 00:32:35 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpZmg1MMYz1RvlN;
        Wed,  2 Feb 2022 00:32:35 -0800 (PST)
Message-ID: <12c48940-c626-05e0-cd63-2c26f596d1c3@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 17:32:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] libata: ata_{sff|std}_prereset() always return 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <075a5bb1-b380-4735-3202-75a4ef565831@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <075a5bb1-b380-4735-3202-75a4ef565831@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/2/22 05:51, Sergey Shtylyov wrote:
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
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
> Changes in version 2:
> - fixed up the 'kernel-doc' comments on the function results.
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
> + *	Always 0.
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
> + *	Always 0.
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

Not a fan of removing the check here unless ata_std_prereset() is turned
into a void function. But doing that needs more changes with little
value. So at least can you add a comment above this call ? Something like:

	/* Standard prereset is best-effort and always return 0 */
	ata_std_prereset(link, deadline);

So that it is clear that we are aware that the function is non-void ?

>  
>  	/* if we're about to do hardreset, nothing more to do */
>  	if (ehc->i.action & ATA_EH_HARDRESET)


-- 
Damien Le Moal
Western Digital Research
