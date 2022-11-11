Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D42AC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 08:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiKKIzF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 03:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiKKIzE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 03:55:04 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FFD2F5
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 00:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668156903; x=1699692903;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ggfeDU7/dlJebznHUQ6K4gjNcUVin55kdXfCA34oNMA=;
  b=I8zIJcuTGF4Cj0qkDMFck8PpLK6UhokbV85wMJI847Z2bnLcieuBj/Qi
   +Zn0Lkf+cUI2m6ASBLi6g0EGO2PW9y8ZD7/sgP8wQFS9b68AmO0yzUkmu
   U7AViPRf/IHLzYwugwa4NrRQiUZvFAo2g7uH3kwvzXLBnZarGbpavrKLV
   PNATHCmLC6xU6gJgdECyDShZKEePlCY53lLneQA+Ib1jmXfSoCs6SSSK/
   +WB3mX2h6ooQ0s3Nm1WAbwydrNABn7boL426e9Qbm4JiTGS68L+R128GL
   Bk015/NE8MPzbPwF64RZyQdGndG7V82jfAzfxz4j8UvNMFQeI23MV36/N
   g==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="216369185"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 16:55:03 +0800
IronPort-SDR: TyQtBAdCq2dfAYEEPdvSDVbzqe/BDAowdJkVLy79rYY2GjtjpLzRPdUtQPXzViv6KmVRKwWEyG
 +5Uo/CH2EfBG2OSNmST6fUr+iVU9S7j9tq5iutdhldp0JGS4CBXImC5PGhnw9sJgI0VHBHEi6c
 Sga9eC6uJOEyIVETX3zvcZJ2MBWd3O7Gdj1M1xLkNdxDEB414EVTJq/bvH3+lRZsUYK7H6EBsX
 DKSigZXHXvBslLq9Mfmy0VY0jMtTAq6GQuypdx34Dt3v5eyT6oP3c3kUOLXWx1yEPS3oiqnY5b
 IM8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 00:14:05 -0800
IronPort-SDR: bwF70WM0mBY2KEXv+zYuJmOBfFbZAwW7aoUDhLtY97xGzqc51lNXuBmXIqwqj359Vm8Vt2xsdJ
 O4IBDbtx/FKe8aCrXuVLB7I4KWh1l40aVwydTMDI7kC4qdX2gVZt658JbuL1n2xaNgPWKONnFK
 2HqoLZNsvCp5JsMIH8uzqK5R+ff/NBGnIkwsfF1Ohfh+Eq6e8j8Ox4bNt0mhbwQijKAlbTwz1v
 tMwsZDy9ZnpqVqwco3eWdmF5U+9Hk5TSmyASbEj0HO/LmsB+xBVYJi2Xzta3PYnTYB8KlrEwW/
 fXo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 00:55:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N7swR0JwTz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 00:55:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668156902; x=1670748903; bh=ggfeDU7/dlJebznHUQ6K4gjNcUVin55kdXf
        CA34oNMA=; b=fK5SfO+9Ui8wA50qUMD43gJER1TRNedZ1GC/S6t5YN/yqjTu7KL
        0HeJVcLrnH6caFtBHzzaKcVjSN5Rbfqh4c6udQC15zIRl6Dtt0GfS5j+yZ13ZQ/l
        dGyx99mV83FIov8UsSJTgkZxBBKv28vxTJfyf+x0toaU/JhGKpwTfekiRbwwlREk
        cVweimkb3PGqEExlZrBAOr1M/Rf/ZcdA0P3eR+jkXU/KNIjO/U2VkB6iZt36ncOd
        kAepLhmmPJCup2sXvf8/HojlZ72RhTMhg2vBP6s8Rc+BciHApnC2ecvs4iEZHJ9F
        9fyKMTva7SSg0QJA8eAD6kiRxi4+hQGMgzg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SE0v0HgvWl_T for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 00:55:02 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N7swQ2bvRz1RvLy;
        Fri, 11 Nov 2022 00:55:02 -0800 (PST)
Message-ID: <4c7313ad-df6e-68d3-4fc5-74b960a1ed7e@opensource.wdc.com>
Date:   Fri, 11 Nov 2022 17:55:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/4] ata: libata-transport: fix some error handlings
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221108134004.1079981-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221108134004.1079981-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/8/22 22:40, Yang Yingliang wrote:
> patch #1 fix a null-ptr-deref problem that caused by double put refcount.
> 
> patch #2 ~ #4 handle error case of transport_add_device(), if it's
> ignored, it will lead kernel crash because of trying to delete not
> added device in transport_remove_device().
> 
> v2 -> v3:
>   Update commit message of patch #2 ~ #4 to more clear.
> 
> v1 -> v2:
>   Update commit message that suggested by Damien.
> 
> Yang Yingliang (4):
>   ata: libata-transport: fix double ata_host_put() in ata_tport_add()
>   ata: libata-transport: fix error handling in ata_tport_add()
>   ata: libata-transport: fix error handling in ata_tlink_add()
>   ata: libata-transport: fix error handling in ata_tdev_add()
> 
>  drivers/ata/libata-transport.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 

Applied to for-6.1-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

