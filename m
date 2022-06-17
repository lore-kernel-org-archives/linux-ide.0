Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4283BC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 07:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380504AbiFQHoq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFQHop (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2022 03:44:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203D674EF
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655451884; x=1686987884;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=w9+wevCwVeBxjyV1soOKFKxiLCScjVIVm+goE6IZiAo=;
  b=KYHSKOEKiTs6rCjGWtPXzBC+EXlfqpX2L9d5oz7CG1/c0BHH37DqphVb
   TqpH7hYPTbxxAhEYJx0EJfzaeQwHdJ3c07QNmkIhO7fW5Icj/+VYg1cBn
   pB65ArFPy1cfzwhHPx73X/nHG3ndK58Yk1+6GUnTSMeSP/hH6uU1C9AtP
   pA1ubJgUeSTEaGIpNw8bmt2s/qEgkJ4amzHF/19wmf5bQbmx1/INpxUo4
   tyU+n792uSHKct+3NSTn+iu8j3Lz3FOwaZBfiRD1nEyJnhUK/77Kc5LhG
   4dIKYSvAlFSwYHp8BTeyLN+ToB5hKx1oHnmSOuWGg2KCLYSvwqxoNjimm
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="315493737"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 15:44:44 +0800
IronPort-SDR: r2TJEIDYITHICRn8qrEWoqAM4qGJVEUcH8+F//sOG7MmyEbgm4udejhBOoBGNMZiZz3CGA4pGW
 I3zzNGN9M6xqAPqjaTFxPyIAjolWOHZFADmw1dmT1rdYulIe+jw7n73uijpk9Cmkyr/F5UGOF0
 pm2U+rypF5hrynyhLjB6FEJQ8FEAViI83lXHkyeM3cgb2EUwb/DeJrOFrCL1+R0NlvGTcurt+r
 KNv9CZzTcgUzZsMP6z8bKr/sOO5A48r2poktNT/p+N4KgOvrVPnQ+kc3JDnALX8Gg3FptoWi4X
 wp/VExkTJonvcR+jzvaqWIhs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:07:20 -0700
IronPort-SDR: a1K5s5OQjWj/rBA73PMor9Sp6CPba6sQQNq8Hg2StRSOIufcepePt2kCYPro57Xo5vLgG551tP
 k3gpYww60UARnNsrAe6lFrzBDahg4T0pOuMyCtdgvF0yR4uOosJj/oq36Z+Qgub1L4K/NzfSF2
 iaDuI3/kHk3gJDUuwYd2vWlOqyRZuLHaq/jXOnwu1g+7uBmuQOQAftCiEeLaqHcWIhjHEZL1zV
 tSuZ2+ZYb7CCZ5sayDr6AIs/Iq8MDtrje+ye1AHvgS2W3jiygiwG53tKDG39nnXMZiU82rqyuH
 gWE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:44:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPWK81pcDz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:44:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655451883; x=1658043884; bh=w9+wevCwVeBxjyV1soOKFKxiLCScjVIVm+g
        oE6IZiAo=; b=btr3BKljMt9aPDdvngM4UUQhxZUuScXUk4jb3W2XP/EwNFu1DJx
        JIh43CVz/WachBmbTOMrdYAXfslltapSI4UUX9cs9FGTUqpXigcebizabtNdDEnX
        +dCWDWpTfBuMVNM2/PwQLs5vtkA7Rs+Sf9HcSgKDOV91vc6BZWeRcCZQwWjdXUzW
        CGRbmT6VF1EALxKLMY3VomG3/rkXw5i7+IGbwV7k23DbRzBlD4PQjFHte3eRQnox
        9W8mDdNW58aPqAuJ/zNm0qX4lsK+TQQ5SXdigqbc3enjUn6YabOWYtGxtmBS95/s
        7k32ErDsUBabOQcbC3G7+bbcKON4f4i5X9A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id agnayAGDuRmZ for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 00:44:43 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPWK73YCwz1Rvlc;
        Fri, 17 Jun 2022 00:44:43 -0700 (PDT)
Message-ID: <849f65c3-007e-8f01-2412-e91b3fd6d254@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 16:44:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] ata: libata-core: fix sloppy parameter type in
 ata_exec_internal[_sg]()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
 <20220615193821.9235-3-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615193821.9235-3-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/16/22 04:38, Sergey Shtylyov wrote:
> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
> milliseconds. Then follow the suit with ata_exec_internal(), its only
> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
> caller  that explicitly passes *unsigned long* variable for timeout...

Checking this, struct ata_eh_cmd_timeout_ent uses an unsigned long timeout
and ata_internal_cmd_timeout() returns an unsigned long which is stored
into the unsigned int timeout variable. So it may be good to add another
prep patch before this one to cleanup the auto_timeout stuff (struct
ata_eh_cmd_timeout_ent and ata_internal_cmd_timeout()).

Hmm ? Thoughts ?

> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Changes in version 2:
> - rebased atop of the new patch #1.
> 
>  drivers/ata/libata-core.c | 6 +++---
>  drivers/ata/libata.h      | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3cc1312a2622..03a08d1e666a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1470,7 +1470,7 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>  static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  				     struct ata_taskfile *tf, const u8 *cdb,
>  				     int dma_dir, struct scatterlist *sgl,
> -				     unsigned int n_elem, unsigned long timeout)
> +				     unsigned int n_elem, unsigned int timeout)
>  {
>  	struct ata_link *link = dev->link;
>  	struct ata_port *ap = link->ap;
> @@ -1645,7 +1645,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  unsigned ata_exec_internal(struct ata_device *dev,
>  			   struct ata_taskfile *tf, const u8 *cdb,
>  			   int dma_dir, void *buf, unsigned int buflen,
> -			   unsigned long timeout)
> +			   unsigned int timeout)
>  {
>  	struct scatterlist *psg = NULL, sg;
>  	unsigned int n_elem = 0;
> @@ -4342,7 +4342,7 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
>  {
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
> -	unsigned long timeout = 0;
> +	unsigned int timeout = 0;
>  
>  	/* set up set-features taskfile */
>  	ata_dev_dbg(dev, "set features - SATA features\n");
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 1446a482835d..8292d4cdc22b 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -52,7 +52,7 @@ extern u64 ata_tf_read_block(const struct ata_taskfile *tf,
>  extern unsigned ata_exec_internal(struct ata_device *dev,
>  				  struct ata_taskfile *tf, const u8 *cdb,
>  				  int dma_dir, void *buf, unsigned int buflen,
> -				  unsigned long timeout);
> +				  unsigned int timeout);
>  extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
>  			  int (*check_ready)(struct ata_link *link));
>  extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,


-- 
Damien Le Moal
Western Digital Research
