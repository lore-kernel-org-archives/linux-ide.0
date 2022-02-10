Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29231C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 03:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiBJDHV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiBJDHU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 22:07:20 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBE2B273
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644462440; x=1675998440;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HybhtefC308846jQWn/IctvlMxaMrSw/yHWx8EzS1iQ=;
  b=AcKKSuCqY3CdhbyDG9bQNLt2EELTCk73hzM9QvgPFQkUSbZqAy0ng6Bv
   7f5BvaZIhHJXjVSvFwSoxiQYmD3hPNN43iFPkawqKyYkteqSbvMSNb68U
   8DJxTbBkjbDoY+f17dDDHFEDYzl8YMbxwbhX8DbKCkPFxn3Y2QrIkxTUF
   GuphYVtt1pc0EJvXy0q0N7ls7IP/g/V7MhTVw2a0JgYWfpb51t0SysCLN
   rArAFGyExg9fed9/lB/eUMANThC5z92/yEZiuK0ztI6/D1p5J9p5RWkX0
   4eIdp5Ra/qfPUO6IDooL0wKM0KFRp4fSIJM+O843j2GdRhxpWBYPXwZWl
   A==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="197379374"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 11:07:20 +0800
IronPort-SDR: MOqPh6bEkawqu2rksZIg/12mm/OGCQ5lYFGREeubuYbcklTHlyeqr9Nbvn8HabLdU7E3R3xhzg
 KkLPOQOorhIgMkeOJwmpbb553yEPiTR2zoCp6Kk7jftp72U0+kutK1VmsO4okv1/DXer5L4m/e
 6daGCZbkr77pJMNcrjai6SOWesRQAXuhx8+NJCx7X8yeoSiWtkFRjNMkT3SAF4ufPndyJBX2lR
 9RX8T5mz3gX5ka3P+dfYktvDYljq7SqaUsDf6OhL/z89CK2ddtMq9wDd2FysWOFSsOIA2U3F6x
 8Gz6TQsq7PIm9RfndKGs3uN6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:40:18 -0800
IronPort-SDR: Z+HCJ3QpKRD0uq6t7VHZBhDZ8Gv/t6j/Xh++uOsDcsKii4vlCFqtfEThLe8v9m7dVc9jESRM+B
 ncOpBqRhzrt1SD06h5YE1axYDORYuNbPe/QrNw0f3ZFOOsb4CfqG3DeTIGbX4gmDvBM75KkniX
 E+2FAtWOxjqYG5E5vsUayl629mXgxLIUxocLoPifA0TD5lQI/wTJ6M4EEJ3eh0SL7a/HfyvtiX
 yuGmFfedHMdZqChsl75mYBZSp3pLhqOumd7Sg2qxQD/5k4Fus+RkqSiF0aKBLEiiykwIvjamLD
 2jg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:07:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvM9j0mY1z1SVnx
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:07:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644462440; x=1647054441; bh=HybhtefC308846jQWn/IctvlMxaMrSw/yHW
        x8EzS1iQ=; b=K4YMPdC/5rBFJiUOSwbJQ3aldm/76RDOaKbzsjYGNfCp44g/oee
        3xXDA0wEJmLOTMeXRJJvMBZreXtBQj7M1MDlmq6/GZBjoxbo1ZBUPRHYhhMsz5aP
        Z4Lrb0cY63M+1i10yIjlTSxwM41mvKmVRmlpbvpPWdSEwOL05/oflrMVNoL3dvW8
        3Ulcou7s1VMtUB7Yex7Q7altbnVkqBJ0UqC+/gZ7RbTwC+3zvZ6u8+s3ifi7HQaa
        MhbQD2S8cHskcyPInf32yOz4pJ0Xo35tD9T8/g63dm6xDzbepuw3RYaZAYJxvKuA
        otFkJpIl4CzFEXJ2zFFupcIRIPbqqMRF5UQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I0px3NJ3sdJR for <linux-ide@vger.kernel.org>;
        Wed,  9 Feb 2022 19:07:20 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvM9h2F7Mz1Rwrw;
        Wed,  9 Feb 2022 19:07:20 -0800 (PST)
Message-ID: <6e6e4cfb-3011-2d13-ac88-1370919a00b0@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 12:07:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] pata_hpt3x2n: fix writing to wrong register in
 hpt3x2n_bmdma_stop()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <2ce292b5-d49f-740e-1445-be7375963a58@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2ce292b5-d49f-740e-1445-be7375963a58@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/8/22 05:32, Sergey Shtylyov wrote:
> The driver's bmdma_stop() method writes to the wrong PCI config register
> (0x52 intead of 0x54) when trying to clear the state machine on secondary
> channel -- "luckily", the write falls on a read-only part of the primary
> channel MISC. control 1 register, so no collateral damage is done...
> 
> Alan Cox fixed the HPT37x driver in commit 6929da4427b4 ("[PATCH] hpt37x:
> Two important bug fixes") but forgot to check the HPT3x2N driver which has
> the same bug. :-/
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18 with commit message fixed. Please check. Thanks !


-- 
Damien Le Moal
Western Digital Research
