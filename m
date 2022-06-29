Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EBC43334
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 01:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiF2Btw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Btv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2022 21:49:51 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756B2C651
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656467390; x=1688003390;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3HnBGY5hJl1WXq5cmlP//zs05lll7x07NHlJgZMJv9A=;
  b=hCQ8Hg5Xq+Xxrt/GAfII3RK2yHMuzTGbHESqHEGPuz9HnjeryqaXJ3qE
   GMp2wpKAGVqG+Dm+4zO9vrcqOG0RJ3cYkpKawzZPioIe9/58DYRCv9Dax
   4zieN0cxD3GXj+AQ1DF1aGl/viizW0HKSNnyrHxltwGKilUlAO+/6lWbp
   S1CSllaI+3Ps1IA8qQYxuNWVihGJdNzohuFX/LYzWBBTQ1YVswMyb9rhY
   Ciy2ul0aEeJ5pkLY395IwCp9WEClKeuiQcvaB7PTrL3LtV3u0JJ9XZ/Sj
   cWq/xUPWNJ6LvATys+OfByd5YhBSD6lhOAzaRQFmEML+dU9C2SPdsk0Kl
   A==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="209214737"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 09:49:50 +0800
IronPort-SDR: g5B57YvklRtEuykgAApQfqRx9RsnoeR2pxNDrVrj0FoCIdrTlxRwmi7MmtwGh56juw/KQnqkRo
 Fowf8/Vuc8yrrdZi5MB3wir5u9Gljtm9TD5/Tbr7Tv4nWnYeqASP5aL11QJNMCIzvD8O1gCoiC
 QV/PYxQaSrsCn6Op3A3Jv/N1hk2GINoTD6L+ZhQVj19Oo38C4+mmsrUhzKgNAj/NkNcezXhmig
 v65glaEqRvsAkfOQXLOE4lsu8L1zJvSpdpBBsukc/n1Ubz5JMidcDT70r3KAauVJKqyHYFzjWo
 0YARZTO8lW+0L/kpAK/X1PTY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:07:30 -0700
IronPort-SDR: 0orVxtoUJL+OFsrbRhOpJTYzAjZkzCF2j4aPKmVLkYu0vVzo7gwYguk29OIDgjgerY3B7OTPy7
 DptNJNPs2gB0sbdE1kkNZfknORTfjWm9IpOg5vnmhAatXjagZ94coo5tO+tySggM+PVzNpT0BR
 X8oqRJlqoaJQdsTA9qqCxPEkrR5muH1wislpeb/2ycHU3+uy15xWX7ryRz6+NUSkMd7ItlPwNN
 I97IKyXbwr5k4m24tSLlsAtlshf0Uu+k1mg7vR/b29mpGFqlT6QCmQO5Z/6xz04iA1VAocu24e
 NOM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:49:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXkt64s8bz1Rw4L
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 18:49:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656467390; x=1659059391; bh=3HnBGY5hJl1WXq5cmlP//zs05lll7x07NHl
        JgZMJv9A=; b=gTlpYetp7FpQf9WAYBibGnk4QdJBrgZ2VUbnykWhIgeC0A8Riq3
        YsyJ1e7tu9HjykMNR3c+wkNt7I+/TgNHqfvFehZuxNXzo5PPxLKecVexfgdkLmt5
        k64/TT58MjXp5T6FNrovzaYSwCM2SX13eEQ5hfJR+xvslSTVuQnALK4drW/LEMh1
        GrV7u/px/+Ty/hHXRFtnETXQc6I9oHzeiPOTHOvgsRRqMoFKxUR/srhv24ZI3gcN
        +g3SYFIJ9cF8FOWfkNkgm6YGt3J6Hs4vePgu3oYKu/AnlUkZeB9epDeg2AEfnaw0
        qsFQhEFiEoy47GCw/KQEFz5a1rDrlGlwTeA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ZjZrPIHb3sP for <linux-ide@vger.kernel.org>;
        Tue, 28 Jun 2022 18:49:50 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXkt601xwz1RtVk;
        Tue, 28 Jun 2022 18:49:49 -0700 (PDT)
Message-ID: <6af5fa70-89bc-9fc4-cef2-c96d0c036f71@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 10:49:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] ata: libata-scsi: fix result type of ata_ioc32()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <1e088333-7c7e-8e7b-7b85-12edd4355b92@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1e088333-7c7e-8e7b-7b85-12edd4355b92@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/25/22 05:39, Sergey Shtylyov wrote:
> While ata_ioc32() returns 'int', its result gets assigned to and compared
> with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
> caller, which implies a problematic implicit cast (with sign extension).
> Fix this by returning 'bool' instead -- the implicit cast then implies
> zero extension which is OK.  Note that actually the object code doesn't
> change because ata_ioc32() is always inlined -- I can see the expected
> code changes with 'noinline')...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.20 with the commit message fix. Thanks !

> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
> Changes in version 3:
> - refined the patch description.
> 
> Changes in version 2:
> - changed the result type of ata_ioc32() to 'bool', updating the 'return'
>   statements as well;
> - dropped "sloppy" from the patch subject;
> - added a note about the object code to the patch description;
> - changed * to ' in the patch description.
> 
>  drivers/ata/libata-scsi.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: libata/drivers/ata/libata-scsi.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-scsi.c
> +++ libata/drivers/ata/libata-scsi.c
> @@ -539,13 +539,13 @@ int ata_task_ioctl(struct scsi_device *s
>  	return rc;
>  }
>  
> -static int ata_ioc32(struct ata_port *ap)
> +static bool ata_ioc32(struct ata_port *ap)
>  {
>  	if (ap->flags & ATA_FLAG_PIO_DMA)
> -		return 1;
> +		return true;
>  	if (ap->pflags & ATA_PFLAG_PIO32)
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;
>  }
>  
>  /*


-- 
Damien Le Moal
Western Digital Research
