Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2261C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 02:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiCXCUH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 22:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348111AbiCXCSs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 22:18:48 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B2692D1F
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 19:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648088238; x=1679624238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C8ZC1JfJidJGGKJTTvn2HdT8RQJSx0oDAfiC+lrKKkQ=;
  b=l1RMvyKgiZ6mOntXpAZNYuLT5TTjXXVx2N9fLCQe1IoKQH0aIOqLDhHs
   D6YdzS9Gjox94+QDTXjtZhc34DwbLPCLilNKVtvmhUe1L0E+O6XRtpuST
   S+BzgqAUsboBoISfJniS/QOCQaQSd8KTFDFyoccK2t6QJ2ndx+d+G/J08
   I/Rdue0XSepwApEfPNut1+iSkmbCovcHhVHE3B56wYhCAWB/zfsmhDvAM
   qcMMZuo+1rKjsbkzBkorSHx5qKJT+3fcp7yJtCX8qq5F32r6S3jjMw2yh
   QSVL/iTaRibpdnMp7bbqeSbldmfhVGYTtqggWgiEvcvpvu6qZN59/gURs
   A==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="197043558"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 10:17:16 +0800
IronPort-SDR: Yt9FDHSR6N+m/qCAm3NWWYzELhhWFitzWm8HAt8rNh/fRceEBA6MUz39AvknKzn8wvMxMZNULO
 bBrQajm9433GqcnfRmUt/qTnMloJH0OtNTHPRf9ztOLKEs1Sy7Wmvv02wmf8fh7g0RYyixnWIT
 DH2/qSazHjAn/UqDpsmI5JVcm8IlIgydqsK1VTXSVLBM5WPHSwd2iNPfhT5H0m3uuVpaoIxHHX
 +lVlziQyR+lSKTd/ftyIEorDIBLXDtLUPEAefCn1iPUvB9w5OFekg0SrhwLCaxTLg2KakaVfW7
 w71zbOUmiuvHmP0z0pIVlB50
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:48:13 -0700
IronPort-SDR: bEPKXy4gBfhYTgMYOIx15ToKQ4qC2JfmcjrOUj6FRDrs1ciSkSPCkh9t0SXe6obJu5GfrrBb/w
 TrKd2I5Agoq0bzt4ORyZaP3d/xQfz0/2ghWH7TnoF2laHWa/XCLGMfbvXTkEzaRi373XIGAFsa
 JPdBaHVbUmhYd8FjGA2/XhQ/FCMhxzDzeneeU8bl2NI0vYi2qGxqZ9R+qRCJDXyTsMmkNOhIDo
 d7ju3esnTgchbpBfhtkn8IWsW3OGZcb2pm4aX2G838PWeNxH3gdeRiLl5HChlZjQaMlr6FrR9a
 Lyc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 19:17:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP84W4VkJz1SVp3
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 19:17:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648088235; x=1650680236; bh=C8ZC1JfJidJGGKJTTvn2HdT8RQJSx0oDAfi
        C+lrKKkQ=; b=FOT3gXpA129jN1eIYX1gm4o4xXeh6hGGrS9RAlqa9cBRLQpamPj
        cNozjURXZZw2im8fsdHtruWvNVtspQQseIg/1biNx6MMYTU4eNmVIG0GyUSigCDC
        qvgeoslr9zwLma/RngLlX1RTMT3XIoY8MC65m6gn4etU7zUvno/pHhicGbzdUNcN
        MJZheP9x46R38zMhdAFsaRnBkPcZy88q2jjm+p6VmziWuvT+wIoBN8NjSvxXlSJ3
        HXoSykoyTDBvftfMyHoP5JTtIrjInxqSufRtd5QcCVUJGBnFAyWy1qG9IBitildH
        EWPwkyg1Ceg1Sk8YlxUjdm65Kgbzmlas+gQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2_YMdKAFrbcf for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 19:17:15 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP84T2DKKz1Rvlx;
        Wed, 23 Mar 2022 19:17:13 -0700 (PDT)
Message-ID: <eb79ee49-53aa-57eb-94af-90997aa6cbed@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 11:17:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 21/21] MAINTAINERS: Add maintainers for DWC AHCI SATA
 driver
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-22-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-22-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Add myself as a maintainer of the new DWC AHCI SATA driver and
> its DT-bindings schema.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0f68d4a34a..19c9ea0758cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10919,6 +10919,15 @@ F:	drivers/ata/ahci_platform.c
>  F:	drivers/ata/libahci_platform.c
>  F:	include/linux/ahci_platform.h
>  
> +LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-ide@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

Wrong tree. This should be libata tree.

> +F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> +F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +F:	drivers/ata/ahci_dwc.c
> +
>  LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
>  M:	Mikael Pettersson <mikpelinux@gmail.com>
>  L:	linux-ide@vger.kernel.org


-- 
Damien Le Moal
Western Digital Research
