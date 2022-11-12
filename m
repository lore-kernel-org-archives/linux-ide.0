Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1408C433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Nov 2022 01:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKLBlY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 20:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiKLBlW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 20:41:22 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C339A65870
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668217281; x=1699753281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gs2YRkzZLbS47YgittNgNPxxJjj2CxiVTQ/tgpbsM7U=;
  b=Dl+zWGXCusHJxaEvJCdBCax9TYfO2TvkKY7pgGTPPU6e2meJ53xqrZV8
   2sSLHFERP/q09tY4sIrrYF2D9Evxu2bBBN+1M1wujz4vMLZImqj8AHDC7
   1urNQtSWwEJkxRmOsNkF/3dnx25xg+PIMQxMzFsT/Q/I4fPlLhmHe86c5
   qSzHB4aZfUyUow4Z1HontOc2riwC5IXOUlg4dwgISRU19+C+GmzwbJhSm
   MpjQ2fQwHV1txZQXYfgsPSce4TteCP4UJYbDtEv+5IioKz/uClOqzvBex
   yIVZ7CuZ3r2VTuoey5T42VauOvnahWVPwe91Op0yVMas+MGCPSApFSqRp
   g==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="221252501"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:41:21 +0800
IronPort-SDR: RFFMnyHPjHB0adqqjYK4fridtnXcHw70ZhPH68Zq5pMY4ppMhPrexV3HDUu8CZp1d2rWV/JQFI
 5SAmFcj+gSLuTYiYUr1mUvCPlkkmdA4/MiRNuF0uDFNsmkmPcGvfYnF+VcdD7FXG5ngt3kAlyC
 0KifbK9z02xZ+n0hVdxp8NA/A3xifLaNJqQplC4k5x3Y0t7OAPbnqxxlyNeb6655sXblb2gWMU
 +JjxTHSniZJI951WjBL76HH7628m2BOSWWWFefe0T+C993SJHzwVSeydWcpaZl1l3tsj0d6hgO
 s0c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 16:54:37 -0800
IronPort-SDR: IyGEz17J1A7046PY7AReg+WXdhW+prNSSQfnIU/pHFYqQ9+h87YG1YhtXsegDJPBBlVsDkxR+t
 4aSq1dwPQoaI3p+Xvr4evn+WlF7llsOOTtqugKZee3kK79lbiZ2MBEKLOYRqiRXM+c+zyNwl+C
 LnOw+NOvm2W2bKlidzJV9g8sQpjcn+sN98Pef9IkGhFsx0Xbsw0wFu6OsCWVb2DSH2GPHgBWoC
 MK0Q2uBmKfm2/Rk6J1aKpoa01AjXzEkABvFp4yfQN4adIy98Ab/AAQybPOY2a2saOsmGjjkmq6
 +Rs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:41:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8JFX6SQTz1RwqL
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 17:41:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668217280; x=1670809281; bh=gs2YRkzZLbS47YgittNgNPxxJjj2CxiVTQ/
        tgpbsM7U=; b=pTpJZL6l9kJXC8kRggox9E7+JzsKPzj43TN/qQOGddWI/YtDjRY
        Dzk/Usle0jlpnU9E5BhccbAwp4y7xKgAc+TepD+DuA0s5s9s3hoXv9F1GbB51jxW
        YsKFUFc338I31B48zeTJ5w60JeSlM+8UfRP9YSHcaM8kNcbN32YGRlH+C3D3vcUC
        sHrFkWfPzxhn8wFBrzaDglxxh5xQXrQtAeh2y0sUupLryghj4Uro/yqquznWcq30
        rQ2DkgvbOxR/tZYG/C58NLkJNxjVtZ1pLOGEcV2rqlSCCHnC3rJu5OXvudxYe2rV
        qz31HH1WErU27Rpu6f2u9OZE+YWDjdmF/zw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JHdcSQBU0ZAT for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 17:41:20 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8JFW5YqDz1RvLy;
        Fri, 11 Nov 2022 17:41:19 -0800 (PST)
Message-ID: <e231e822-6146-d0d0-c99b-1da0c98a4d96@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 10:41:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] ata: libata-core: do not issue non-internal commands
 once EH is pending
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Niklas Cassel <niklas.cassel@wdc.com>, tj@kernel.org,
        hare@suse.de
Cc:     linux-ide@vger.kernel.org
References: <20221108231534.982516-1-niklas.cassel@wdc.com>
 <8a9a84da-13fc-04e9-ec23-807933b616e4@opensource.wdc.com>
 <863efa99-320e-0f50-73d3-56727528be4d@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <863efa99-320e-0f50-73d3-56727528be4d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/11/22 19:11, John Garry wrote:
> On 11/11/2022 08:55, Damien Le Moal wrote:
>>> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
>>> Signed-off-by: Niklas Cassel<niklas.cassel@wdc.com>
>> Applied to for-6.1-fixes. Thanks !
>>
> 
> If not too late, I tested this with that NCQ QEMU model again:
> 
> Tested-by: John Garry <john.g.garry@oracle.com>
> 
> Thanks!

Not too late. Thanks !

-- 
Damien Le Moal
Western Digital Research

