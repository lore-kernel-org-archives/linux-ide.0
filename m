Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC40C43334
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jun 2022 00:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiFIA3l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 20:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFIA3j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 20:29:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2880D1B7029
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654734577; x=1686270577;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lXLGw+xyvnhl21a57727ZnSvmeYZoePnTRqP5JTa5Ns=;
  b=Fzi/2S3gMxSw3/aOb1zxe1hURjn3PL0HKXIkqf0/AJ8wxdTb9IJZrRLb
   UvYV2CepwxEsXD3K+TaMtmt9ai5Xl2AHI342phqWp7DKl9rqF4i7lY9HK
   7jTVFIR05ljlezxm1fUehlgd6lzQ55ua7K7BOV8qmtPe+pSxHXTrdqJNK
   k5KfAGRBDZxtrtF+n3b+6DCJbvh+CiynTTust5/BjPuNdr1XWcZ6A9BHe
   hEiAgOb946gdl8Wp9njn8UV1QA3tXc53wb+TvkT+ApA7RULEXjFy5eLdG
   0ZTHxNgV2cZ2WwSFOAbL43mEVSr6LndBl0+ygQl45NORPU4H3zuzVgTJm
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647273600"; 
   d="scan'208";a="207499568"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2022 08:29:37 +0800
IronPort-SDR: a3YPoi94LD5C7+5Ddaho2uYey8h1hvaQ+3RDA3WHbILmdXY5/wkZ/TCwVSBy+NHmOHzjal34Kw
 YcpHJWRHLNfL5CmsIM0GhG52kRYdkvPhPU8h19hKXoZQnEMCDSaGZdWfzMODBVKDirGSE3qQCV
 Sbr/7d6pGVyYsyxWnOadvQMQ+y8OVK5wkHwj3Smiva3t6qJ9lOv2bxAh4NCfPivnxEiPmiW2Bn
 9cyKWo1WYAukUsJ22BXTMmhwQxppgCbjW6K0cZtp1x+z2zSin7MzKndkAlSZMaBGKL0Pk28Dfz
 yu1p18wNpkcl5+3NS63at+S+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 16:48:26 -0700
IronPort-SDR: xj+DrqZcJnaxHzVzn5NNCN56sl67TTLprWIKHP2KasTa6RZXwlOAiTOhMNe0INtWwaLbGgmDWt
 oYiyC/r5U4uG7oCuT1xZMAvsVoF1AJwNtvNXs5eNCnNM+CAGClJLBFsUvvQxwgXy24LX7j3Mr6
 s3xAW+B3Od3LP/8p8RrGiWUgpA9QyREZNCvXGsTA/UvxQIT8yx8m+j23Rj/tk0GVkYofC5iT7n
 zQFnNtyTiHqs/WiskWCiDW5NzIt8Efme8jiivz+soL/9oMtyxi8unvqoXsg4it6pf3mDsI1531
 HVE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 17:29:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LJQ2p3lPzz1Rvlx
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 17:29:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654734578; x=1657326579; bh=lXLGw+xyvnhl21a57727ZnSvmeYZoePnTRq
        P5JTa5Ns=; b=jVaJ3aPhwSllx7iUd1b0Ns2j36JeqQgJabEvCy1QDyLR+EgykHt
        16huz5O/+0S+zOcTqwJ+96ZYipAswzBy7OeqH0DYyVBKDYoiuMv33wGR9D8ZfITg
        n7Vc9J6E3TZVqrE2FJhBpUCVPFHv7GhRYbFnA7paeIWO5GuTffkZUtArDTNeeZmS
        J/ChM12ApobyMAQcxp202lXRJFI4YoJXGgaQ5b9gj1P3uXWY5lFagsHgnaDTDi01
        NPuZ4SPIwvxjv9ynrLp9wLjcMMFbQei0u1/UYZtDy60m8xpcTyi65S/0+WZH6v8H
        NNgU/gHeB1/+qruNct91nqb2Fa2WaPQ/HyA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yG7QH_xjypwa for <linux-ide@vger.kernel.org>;
        Wed,  8 Jun 2022 17:29:38 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LJQ2n6PDNz1Rvlc;
        Wed,  8 Jun 2022 17:29:37 -0700 (PDT)
Message-ID: <6455721e-b415-3855-6518-76d2239bdb8b@opensource.wdc.com>
Date:   Thu, 9 Jun 2022 09:29:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <02321da6-5cd6-aad0-727b-7207d8e3fff5@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <02321da6-5cd6-aad0-727b-7207d8e3fff5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/9/22 04:51, Sergey Shtylyov wrote:
> The {dma|pio}_mode sysfs files are incorrectly documented as having a list
> of the supported DMA/PIO transfer modes, while the corresponding fields of
> the *struct* ata_device hold the transfer mode IDs, not masks.
> 
> To match these docs, the {dma|pio}_mode (and even xfer_mode!) sysfs files
> are handled by the ata_bitfield_name_match() macro which leads to reading
> such kind of nonsense from them:
> 
> $ cat /sys/class/ata_device/dev3.0/pio_mode
> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
> XFER_PIO_0
> 
> Using the correct ata_bitfield_name_search() macro fixes that:
> 
> $ cat /sys/class/ata_device/dev3.0/pio_mode
> XFER_PIO_4
> 
> While fixing the file misdocumentation, somewhat reword the {dma|pio}_mode
> file doc and add a note about being mostly useful for the PATA devices to
> the xfer_mode file doc...
> 
> Fixes: d9027470b886 ("[libata] Add ATA transport class")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org

Applied to for-5.19-fixes with the typo fixed. Thanks !

-- 
Damien Le Moal
Western Digital Research
