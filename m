Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F011C43334
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jun 2022 23:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiFSXMV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jun 2022 19:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiFSXMU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jun 2022 19:12:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE706150
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655680337; x=1687216337;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=BNGXodo6bsaRQsownTQhqIEIhLDFmYlphFv7/iV53Vc=;
  b=X4o4489DE2xEcleOpK9zo52qFvDxew6NyvQkdCVg9BmPvULBAFK/w54U
   +zlZ4XAXSdlL8Ai5gpA1Y/Jc2AdIRGHaGLH2mKafozCXI1MAQD6XlVUpY
   qmnmBTWEkPmiBzTOrvqqBxuh2NBug+edxG1+rxT0I7zCRmmZ031trZ80h
   UcSbEP4AzSsA/jYq7/my15LjEImV2Fesv46AhHIae8gtmGOWuCGchxfLy
   wZ1sF3MLQpsuJHdwxI1jZ3Z4T5EJv/OgYpsF1Xr8Sg3bRoxrXn51h9e2U
   N9GegIm6yyQtZInqeOydkpuLichgOaFcjtfjP+8G2sQuU8714sjqaqabF
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="203573538"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:12:17 +0800
IronPort-SDR: S25WR2f+rURQ/xs51iLP9TEE+GD4t2DOODOCZ7DE3ztN/j0JMh4uX9ZJo2KeG9PtpKabOhLnxf
 YMLahnh2kumQZjNXT8/Z5slxdsAWzGPfPtpLZSuk1e/66tcdTrPyZF0393m2t90zvxuh8qOb+v
 MAGpm2Ljat88uh60YZxQJgn+7hBQ11R7QICyn3DHgJ0cbng7WhSiGaDOuGdFiAqzfwgLxipfkw
 tkLMKlTXNOjaZ9C+cS6M+QUs/07Dv8yOLGnnVtjASRmldl74v6mrkqmmEDA2pWLJ+AX0IaPQJ4
 rzuGamqV6wt7grujpjILd9kf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 15:30:27 -0700
IronPort-SDR: SAYhZTzSydee+/BcMKs0W5eh+MfkxNssp7FAsa3bLi2QSXZ7LDX13et68xDg2ydBDjK+hK9wqT
 YFTD2V+RsobIgf7m5aFKvLeMLXcPtqgMi7fFTbmo7i1MfuIiFDCrt3b0GIJh/i//s1FKxr7nO4
 vvvCuoRXAO+hb4Hpho1vi13FxWm0tq77rxAl3R7238Vn6rzh385ujz0gaPfe+R9la/Y0LTXzx9
 hlruxomx/SZ+++qeCHRugaJ5ufTBq1wNbj3AdGvHNyjJ4x7EUqGVtedmxHG9Gz3MgUPrJ7ecWC
 FZg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:12:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR7pV061pz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:12:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655680337; x=1658272338; bh=BNGXodo6bsaRQsownTQhqIEIhLDFmYlphFv
        7/iV53Vc=; b=MUopLY90qBDe6l9/scLnFIfKNXZzx3T3xC0MGYV5j6x4zKcqbb+
        97KhFHz+wrfi22dkdtNc8csDYTW0nmdklZohC3B3krh6CQIob6mC4JPQpcm115LB
        3JrA6N+cfrwLsiU8yvMo0IlKGfVjd+aEde4jdDAG2w1TjUWaDJG3ffRhO+mSo3p4
        0Jef2cKBao3f0RS/LPfy1R4A09ee43uiYxjiys0iMWgleM5bJzgStf3/Nx6aF47l
        CpWJt5nhRF1ogP7JkLmS1M58dLrGWRTegobaTpeWBzxRzmxep475tcluLB6dDeAy
        2nDvdkz2d3VsK1XisUKQNmARHw+GB8zslJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nnEsxWnnolVs for <linux-ide@vger.kernel.org>;
        Sun, 19 Jun 2022 16:12:17 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR7pT24RDz1Rvlc;
        Sun, 19 Jun 2022 16:12:17 -0700 (PDT)
Message-ID: <d653908c-1270-9c2f-eceb-2572e9c9d339@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:12:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-scsi: fix sloppy result type of ata_ioc32()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <4a695619-2de7-671e-7b67-2afddf22423f@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4a695619-2de7-671e-7b67-2afddf22423f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/18/22 04:30, Sergey Shtylyov wrote:
> While ata_ioc32() returns *int*, its result gets assigned to and compared
> with the *unsigned long* variable 'val' in ata_sas_scsi_ioctl(), its only
> caller, which implies a problematic implicit cast -- fix that by returning
> *unsigned long* instead.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-scsi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: libata/drivers/ata/libata-scsi.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-scsi.c
> +++ libata/drivers/ata/libata-scsi.c
> @@ -539,7 +539,7 @@ int ata_task_ioctl(struct scsi_device *s
>  	return rc;
>  }
>  
> -static int ata_ioc32(struct ata_port *ap)
> +static unsigned long ata_ioc32(struct ata_port *ap)
>  {
>  	if (ap->flags & ATA_FLAG_PIO_DMA)
>  		return 1;

Actually, this should be a bool I think and the ioctl code cleaned to use
that type since the val argument of the ioctl is also used as a bool.

-- 
Damien Le Moal
Western Digital Research
