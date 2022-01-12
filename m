Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F5AC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 12 Jan 2022 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349532AbiALJtO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Jan 2022 04:49:14 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23039 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349507AbiALJtN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2022 04:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641980952; x=1673516952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JQDGrSW+eyxzTUel+uhuRcG3nVZP4C61sljAPMCmUZQ=;
  b=eim4uM9fNNoj8l+OmJsZ7M4bRBNNhUKLzS6M653CbmXJZ2WFVZadxR+4
   QN3xkDgwnJG4zsdEy9kzukT9B3XAbTwksNdAzsuVAzdUWYNoce2NYL+2n
   ZPRAE5y51HXGUE1Sujd2ZgrcMhdHhLdujlxCdWBTQeVH49nRXSruZdxzI
   81TnJ3/A/8BWw69x05nXQ82wHF7X+3wvbnK6W+EbminRbYACearGBlYj2
   J4hk2/PgMp9/RfMN8hzk0jRRwF5ag3zaUJIvaAhB8+fNO0VhtDBlDBLSf
   e8oNtXPEfm6K5fP3SZxlpcVf8OwdAKpAg/FLEr9u0mMLwNdzq4rb+smaW
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635177600"; 
   d="scan'208";a="190269247"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2022 17:49:11 +0800
IronPort-SDR: fjstvO11/6yVxTNkUtLqlzT1INVYHJGNt3/ZDXQbXq5dp3Np7I9oE7Q0bc5jK/cwEtDDD0NgQ1
 vYH/cp/GM5jPAMASVNXfeWOpA9Zc8fnC0nNAXMChmTeI7No12zTmbPDyJl4dr5ALdEE6fwQfcf
 Um3WFkQ1VXtkZCpoG5V4Xb8+RfcZX4U7vohnALpPooJBpwww8bm9YnA/5N7DwHpWs9T8NYF/2v
 41Yy+I8aGALsK/UCA5+KvSyqxVsTMJN215DQlMjjSNH1RZS3IPxFK8Uc9ZWsetdG4XmKjmDNex
 85t8OyLKhlJGGFbtE5/TRFXX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:21:35 -0800
IronPort-SDR: AWUzL4Ip6LPd75VE8PbzIW4psnpYdA6vVYEcMtjpzjaeA6Y0SjSixMAwzvy/VDoiBTjF9pdXSK
 iupzw3737lrfmNVGsycj22jrvC/ZZuSCL/QGoIh0Nvg6hTnEgFyddAwt8byMwBot8pHA7rEvWs
 Bg95bmdM/0UqFELjudSViyCfSZCrtAabbFOkLAnYzNW5O2YspH+nSTA6KJSLTY+S8bxhhM2HoX
 8Xk1yAOpWb1WTxVAsfh3lJHS/H58cQahc4ee0oKk0X3waowcaVJDMAdOBbLX8ILB52JMaBMLIx
 7b4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:49:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JYjSn0gSGz1VSkZ
        for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2022 01:49:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641980952; x=1644572953; bh=JQDGrSW+eyxzTUel+uhuRcG3nVZP4C61slj
        APMCmUZQ=; b=IxIt4AgvJtD9i2g/3w07Kbv9WkwW4lfVaZwW2Olx4RVHSCFbIPp
        E8dTY3Kzin5gnrcSSS3QrOjBtHP0EXNWabhN7OL8l2mHFjctCCSJUG+e7sxz3u2O
        +n38NKvkUSwCPFCQjDnclanynxKojQHXYr4h1GQGzlFNXp/DFGEKQ6pl6AFSSzi1
        7k/XY5FmS56Rm/gYdvdwlp1rL0tq6ra6GrXtoThUVUwlnL2OyfclXMMJESlCQxWa
        5+9UNF867qm14MYXpVAmxkaeRqxboyUXqmw3KWTNbMsy7r7LxajACAQkVH8WWK1i
        ckVvW1IRpYBK/QllvWddsyO+odKwlCqRHfQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9KjeVX9kkJsy for <linux-ide@vger.kernel.org>;
        Wed, 12 Jan 2022 01:49:12 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JYjSm10nQz1VSkV;
        Wed, 12 Jan 2022 01:49:11 -0800 (PST)
Message-ID: <77ce7860-4857-a4e4-e7b3-08f56312cf87@opensource.wdc.com>
Date:   Wed, 12 Jan 2022 18:49:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/2] ahci: Rename flag `ATA_LFLAG_NO_DB_DELAY` to
 `ATA_LFLAG_NO_DEBOUNCE_DELAY`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/6/22 00:36, Paul Menzel wrote:
> The new name is longer, but clearer.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/ahci_brcm.c   | 2 +-
>  drivers/ata/libata-sata.c | 2 +-
>  include/linux/libata.h    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6e9c5ade4c2ea..649815c196ed0 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
>  
>  static const struct ata_port_info ahci_brcm_port_info = {
>  	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
> -	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
> +	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
>  	.pio_mask	= ATA_PIO4,
>  	.udma_mask	= ATA_UDMA6,
>  	.port_ops	= &ahci_brcm_platform_ops,
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b9c77885b8726..67b2e7cf3cc4e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
>  		 * immediately after resuming.  Delay 200ms before
>  		 * debouncing.
>  		 */
> -		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
> +		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
>  			ata_msleep(link->ap, 200);
>  
>  		/* is SControl restored correctly? */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2a8404b26083c..15802e644962d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -191,7 +191,7 @@ enum {
>  	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
>  	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
>  	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
> -	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
> +	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
>  
>  	/* struct ata_port flags */
>  	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */

I applied both patches to for-5.17 (sorry, I am late, this fell through
the cracks...).

I simplified the commit messages though, especially patch 2, since the
main point of that patch is to introduce support for a new controller
rather than discussing the debounce delay thingy.

If you are OK with it, I will reuse your well written commit message for
a patch removing the debounce delay though :) Working on it now, I will
post something by week end after testing.


-- 
Damien Le Moal
Western Digital Research
