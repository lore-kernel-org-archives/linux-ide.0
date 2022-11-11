Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4DAC4332F
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 08:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKKIXi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 03:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiKKIXg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 03:23:36 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29D634F
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 00:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668155014; x=1699691014;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gLM1pw1lxESUSO1QrGsLjt7aw1yn9IkJ0ehJ8/TBJcA=;
  b=bH54WAscjLxhqec2BtbAwpdHc/ICZwCBNAiex0/dZ8Ww8zFT75DAHsmd
   vC4DiLPfRrHyMUkxp/wu5jh1A5U0fswF+3jAw/KjjTSruO8CLfhsxsiQ0
   Qq/0ZxVUw/p8mbKKhIJHpxG7HnVGsia19LVB6AwXRwQB6KdL6i4mTUI6L
   rRK0k6o8d8RQCuaOo9t179cSGgJEJhTbi6akuzMTPFKEwxi73GYY/kkpV
   R4+Ah+f1SrPTGrMcp9QJF/9XNi4bauw7aWO7fSlQp+m1GAkVVy+pyjlNu
   2pJOlJQ16KgDdHewAC6U8KsNhC+t1R5jBmMalwwQoN5R9XowSWkkYX/xJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="216366801"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 16:23:33 +0800
IronPort-SDR: ZVmwJctQ+mBHV+nHHmKR35jAjlzI0/4bQivKL2Ot9cmJjY4+lEdC+fGMq2IDuPT8g/7l9IgPGO
 m+7SmBNKKDiyL27KVQbkQ/WWnD3QJlVaNpyLMVkehrcf6joTZv9Q3y8pKjnYVZ+3rglpnr/p6g
 aqCg6doPcRvsh9CUpMO1e2vTRAIQnWYoQBp/ama4Y4LB/Fmnx6qfCPrtu32KniIL5OxbCGRskP
 kLlBM0M0fYOtdi4n4GvpDr3WRWg3VMbzjMmSESVijUqKnQnZuzcbMsvurrZnLhcaaPfcBvyMxI
 U+0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2022 23:42:35 -0800
IronPort-SDR: ozBkFLjv9qJlEoWSyL+EbOhyhyDcokRMQqmV2azEIL0YkZNKzoT9xRvg/cwNrt+pdp+IGjI0j8
 W/jwFQjdywQzeljsAJujcFtOui+Zhoj6B8XG6NkeA3wa6GaVNHAGvjbQZ7gQikQD/mDBUPfPDF
 POmNHjaMvnJQ7vujvyL96l9Fmy6QB/phns0JrPTHy6J0xDFB3H3fdlNnAKMF0tSTIRwAhmzkl9
 PKdolvi0g8NAY4fETWqIQMEX6hUDj0BOrAR2BIaBBTg4d4erEZxlvvp1y0vaHenOlSy5vPSEa2
 66A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 00:23:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N7sD46ph7z1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 00:23:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668155012; x=1670747013; bh=gLM1pw1lxESUSO1QrGsLjt7aw1yn9IkJ0eh
        J8/TBJcA=; b=iBg+2vLJBL9+ysdtKVETjwp0kv2m77usaERzjWRQYK7LgbYR9RC
        geQbzZunpYLrNpOTqdEJgARj5RRWFrINbDptdAEFGxccZQTyU5k7vBk3Msht6oQi
        CuJ2xIqDKkVloaBdHvygb2t1q5dPod+Of25zd5h9lmgsG+kwpSeNTaDH61OcqIu8
        +DATm9Mz3FRrQ2kVj5Ia3D0jj4Q5oNHMquG66wq9KqZMouR8X2XqCVK2rg1SH8NX
        mDVFq1/1QuPsAC625otkj/2Zq1jXQS5jgCw3QB150uWywvVGC/mBZrN5E/RGDQ7v
        m/V/ndi/JHwjaxLefmOGuTBS8uQOFMSJxeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pcNSrLcqoX9j for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 00:23:32 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N7sD4158zz1RvLy;
        Fri, 11 Nov 2022 00:23:31 -0800 (PST)
Message-ID: <77a207bb-3fa7-58fd-e5d1-84b5f3f63967@opensource.wdc.com>
Date:   Fri, 11 Nov 2022 17:23:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ata: libata-sff: kill unused ata_sff_busy_sleep()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <aaf9372f-a166-8ad1-53a1-a6d38aed031f@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <aaf9372f-a166-8ad1-53a1-a6d38aed031f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/10/22 06:47, Sergey Shtylyov wrote:
> Nobody seems to call ata_sff_busy_sleep(), so we can get rid of it...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-6.2. Thanks !

> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-sff.c |   56 -----------------------------------------------
>  include/linux/libata.h   |    2 -
>  2 files changed, 58 deletions(-)
> 
> Index: libata/drivers/ata/libata-sff.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-sff.c
> +++ libata/drivers/ata/libata-sff.c
> @@ -184,62 +184,6 @@ void ata_sff_dma_pause(struct ata_port *
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_dma_pause);
>  
> -/**
> - *	ata_sff_busy_sleep - sleep until BSY clears, or timeout
> - *	@ap: port containing status register to be polled
> - *	@tmout_pat: impatience timeout in msecs
> - *	@tmout: overall timeout in msecs
> - *
> - *	Sleep until ATA Status register bit BSY clears,
> - *	or a timeout occurs.
> - *
> - *	LOCKING:
> - *	Kernel thread context (may sleep).
> - *
> - *	RETURNS:
> - *	0 on success, -errno otherwise.
> - */
> -int ata_sff_busy_sleep(struct ata_port *ap,
> -		       unsigned long tmout_pat, unsigned long tmout)
> -{
> -	unsigned long timer_start, timeout;
> -	u8 status;
> -
> -	status = ata_sff_busy_wait(ap, ATA_BUSY, 300);
> -	timer_start = jiffies;
> -	timeout = ata_deadline(timer_start, tmout_pat);
> -	while (status != 0xff && (status & ATA_BUSY) &&
> -	       time_before(jiffies, timeout)) {
> -		ata_msleep(ap, 50);
> -		status = ata_sff_busy_wait(ap, ATA_BUSY, 3);
> -	}
> -
> -	if (status != 0xff && (status & ATA_BUSY))
> -		ata_port_warn(ap,
> -			      "port is slow to respond, please be patient (Status 0x%x)\n",
> -			      status);
> -
> -	timeout = ata_deadline(timer_start, tmout);
> -	while (status != 0xff && (status & ATA_BUSY) &&
> -	       time_before(jiffies, timeout)) {
> -		ata_msleep(ap, 50);
> -		status = ap->ops->sff_check_status(ap);
> -	}
> -
> -	if (status == 0xff)
> -		return -ENODEV;
> -
> -	if (status & ATA_BUSY) {
> -		ata_port_err(ap,
> -			     "port failed to respond (%lu secs, Status 0x%x)\n",
> -			     DIV_ROUND_UP(tmout, 1000), status);
> -		return -EBUSY;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(ata_sff_busy_sleep);
> -
>  static int ata_sff_check_ready(struct ata_link *link)
>  {
>  	u8 status = link->ap->ops->sff_check_status(link->ap);
> Index: libata/include/linux/libata.h
> ===================================================================
> --- libata.orig/include/linux/libata.h
> +++ libata/include/linux/libata.h
> @@ -1918,8 +1918,6 @@ extern void ata_sff_dev_select(struct at
>  extern u8 ata_sff_check_status(struct ata_port *ap);
>  extern void ata_sff_pause(struct ata_port *ap);
>  extern void ata_sff_dma_pause(struct ata_port *ap);
> -extern int ata_sff_busy_sleep(struct ata_port *ap,
> -			      unsigned long timeout_pat, unsigned long timeout);
>  extern int ata_sff_wait_ready(struct ata_link *link, unsigned long deadline);
>  extern void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
>  extern void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf);

-- 
Damien Le Moal
Western Digital Research

