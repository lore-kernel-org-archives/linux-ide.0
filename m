Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616CC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 07:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiBPHUO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:20:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiBPHUN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 02:20:13 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3611E4494
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644996001; x=1676532001;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xS2DorLYZCnBHTY5nc5Iy846gs/5jXvdLYF0NW5f5ZE=;
  b=AOk/siY418QyT4W3haB/nkS88Nv/EK3tTinJRk+E291PJI1+t8k69yPM
   4OKMFBSZbOfuoga+tVghCFWjJi5bcGQjsnnYH5tOO863f5kw5OO2KfbCX
   XfuMc6/JUMfyoo7zZyr/7ZveiWCvlh+/yIzStDVz1nrpVQEppLCOEvVxZ
   AvFlfRtLqYvA7koJDBdHkFztwu22K/l8w9ERviFtJ+bujfoCT42SuWn3z
   kaNuq6YShLYSBafyz/MDoA4JnE29ASqRunzLGibQF0HO2/31PkSv9k/MA
   A/LvPPqgUIndsckkgP4+8JFsCWOh/YD0IlcJ4Jd1gI3xosBV6Pd/CHKnP
   A==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="197895620"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 15:20:01 +0800
IronPort-SDR: NzhPUZnPDgOXJqnXhLidHC14YDiJq6tOeLO7gYAf9GO9RV1b+eYqLkpC9bYb4XFoQkz6brfz84
 j/7DR0FIOD1uvnkEMQwTLGt80b4WoCWXnAyv4v4dR7vrK44QkW7guugDbLLUHHQVxwWeYILPSI
 ATi7tLUkK6o0DYSQ+TXqZCDfNcCx4mlOhBxsgzR7QpmkVidPFVaeUwovAJXXHKoDQMn3GEqkZz
 IIyYYeWxFvEK2DVTrkVMO2JXiqgHP7q4Au9siPUIj/jAPcIUcyjktu9JrPrgewBmVBn7tG3aLW
 S9An6HXlIgNzdhetDzNr3B9a
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:52:49 -0800
IronPort-SDR: nCKMYzQ4zNWrh+WuMaOOMa7aU0mm82n/HEKwY2Kmd8AIoQUetCMvA8irKBOZRPcA+Oa5+45S2D
 I3OXFydYYe+unabYeXhx1Edks23qSiMfWvx7fINTJmchRI5O3FrqHhp+fKts95EYUvN0pjuNIL
 VgMjGHpkrSVUZri0FkbBT8ZhNNFNA0VKafo+4EI6+A93a9hxoQbRDLle0rE9pHdO+7JXVQwfgu
 /4AUqvDX9S6mclQm91bSJP4ReUj8joPrGQBd4ZS3/YNda5kAzKswVJVVwoA9o5i6LEtNudzYbT
 ZhY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:20:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz8VT1ybgz1SHwl
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:20:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644996001; x=1647588002; bh=xS2DorLYZCnBHTY5nc5Iy846gs/5jXvdLYF
        0NW5f5ZE=; b=e7Vtk4cakMFu+NTadsv8cE7leS/cATlnWVin0hJmm0xC8qvgUOl
        MEQLsQQVtcEFgl0z2LxFcusl8EjrdlcEcbGOlpW2Bv6vi0bdI3Wc55p8XwJOgAZj
        PpEvXGeKai8jHKisRNx3jzaIDNmCVmPgsG5FYql4QzO77Ty2w/9XdAqHG9AGcw2f
        ffJuEBhrPZtixqFkPs2C7w5051bQaFD4NhUtvHNNlKTFH8biTqgtA4sUZC6v1FkO
        zQ7vQe6VwpNZ0pFUfWrg4EfooYn4AxBePWdvx3VVeoDebYmc6LcMKO13FE0L35/s
        nfp0XH//B9EDCOG6BST7R/4nY3GJ5CS5b2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FpiRDLT8CuDS for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 23:20:01 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz8VS4lgNz1Rwrw;
        Tue, 15 Feb 2022 23:20:00 -0800 (PST)
Message-ID: <a00e1978-2cf0-5512-731e-36a4b79db629@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 16:19:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: libata-sff: make ata_resources_present() return
 'bool'
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <7f7ed86e-16a4-3f5c-67d8-8fbc49bb626c@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7f7ed86e-16a4-3f5c-67d8-8fbc49bb626c@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/13/22 20:50, Sergey Shtylyov wrote:
> ata_resources_present() returns 1 if the primary/secondary channel's PCI
> resources are present,  0 if not -- the 'bool' type fits somewhat better
> here than 'int'...
> 
> Use the *= operator, while at it...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !

-- 
Damien Le Moal
Western Digital Research
