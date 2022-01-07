Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DECC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Jan 2022 06:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiAGGla (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Jan 2022 01:41:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56465 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiAGGl1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2022 01:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641537686; x=1673073686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iwQYZhPpwMpxea++iPye//jg3r0vrEscM38jEzj1QnI=;
  b=FTLY5u093fhoG7unfyih2Hq3ezGhA6G4gggbXCymePqGwUMpPaudsfo2
   vvTwG/BbZETjPPt9BRRPMBBiDfCqudO0tiqpupMLkQREiBRJpmNuvC+Cc
   V7gYHdx8UBRtsGB9l4bPK0ysnLbmDOmx65XXEJTyRjjGPKS/JLKV6IQ71
   hlX8ireAYKVp9wRGs69PURffQEIU/z1e3dvlKxXVBMU+ceooqsTDKlySv
   vtjOnSVHhYS+iUP01ckidN0/OvLovlszCkB2Cv0hmKMVy+BuqfQuOpciN
   Ee8sGixoXcbtU61ma1DJvdUkxi6dORQd8zNjDxz2UXKE3Kmwy5DkKYCDg
   g==;
X-IronPort-AV: E=Sophos;i="5.88,268,1635177600"; 
   d="scan'208";a="194707190"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 14:41:23 +0800
IronPort-SDR: hXwXW1HUrqVHmGVvscMP0Utj13eLbZHpWqlrpmCqcFgrzkuBinR6Utcd9mSrHxOPtwZeCETOdk
 dQITh91mxPoui/+TNHwX9gStdpB0XIxPfpHdC1CUkSYB3yOW1VBkoujZ80Gnxd3kyDv4FoAyPU
 9IY72p6PunGqwVZtvQHXbuv2zQ2F0FwyJqWgaEe8lhNSp63R50WDLVzq+4saLOhux+Ic691auz
 xezHXfbeMnAESSSiJIv4XSYA/qscOwga4ZZ6RT7eYQj2OdW2RdvLwaqtLRZLEadkrHQzgZp/Rh
 Fk6hj7ofb64auJQtpfaqsoRE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 22:15:12 -0800
IronPort-SDR: LBJLCxrHN0DkfHqvJIcUMZtPGGAAAcSQh6X4X1V2SUgsO+dgQfquT/30n6UOlxvu0qYSqJJPHD
 37KKz9SWToocZvBUsH5qv31kbAwKxOmz4jCwTaEDG78z98wWVZOrtFYNQ/qguZxxWt7INg76KD
 D7cmijqsSkpAw1fIInumb+cadjnP1lwkdm+cX8tqrpUQry3parOrif3B4wVStlxI8gAA+aOOqX
 XZEdcdvXHXMF3Z/AoGA010d6hwOSf/zHF9GSZ+Uu+45Uwt1NLozzQbqrjwOFvBWECKxyueitfS
 JNA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 22:41:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVYXL2X0Zz1VSkZ
        for <linux-ide@vger.kernel.org>; Thu,  6 Jan 2022 22:41:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641537681; x=1644129682; bh=iwQYZhPpwMpxea++iPye//jg3r0vrEscM38
        jEzj1QnI=; b=FXUQSxx/q2w+qVeECbYZ+2vlBPqSBl2kERh4AzX+/o/B2BSFcOI
        MF9Vwl5c7wBxUXEZMps+cVBND5LdbGxAXwzkFB/scMZBYjEAeSMjiGvKHx7fTvNs
        RpT2K8bqVL9aQS898USNKwHKBl7SnhOXG/utbJLhLNgyOGZRGS3Viy+13wprSxbf
        iELxm6n55wqW5sn2kaT1ZLM2B7TJ2C3bK+GY5NVGZ0bYYV/GK9mnmcQJfBp5+FIk
        7265RomK7Ynqrs1Qnahvd2fV2tO2eYHC5rPom1PEEUfHI+K6/nu5GYAGAfnvaMOF
        yZlVWq9D7a96025Cl75fRPaZQRGU+Yvg0SA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nutG_8FoYWS6 for <linux-ide@vger.kernel.org>;
        Thu,  6 Jan 2022 22:41:21 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVYXK27NRz1VSkV;
        Thu,  6 Jan 2022 22:41:21 -0800 (PST)
Message-ID: <bcd92fb0-8b2a-99b8-e2d3-80882b904d2a@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 15:41:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107062814.3611747-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220107062814.3611747-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/01/07 15:28, Jiasheng Jiang wrote:
> On Fri, Jan 07, 2022 at 01:30:35PM +0800, Damien Le Moal wrote:
>> There is no such file... What kernel is this patch against ?
> 
> Thanks, this patch is based on linux-stable-5.13.9.
> And I just notice that in Jun 16 2021, this file was removed.
> Anyway, this patch can be applied to the previous version, which still
> has the `drivers/ide/ide_platform.c`.

Kernel 5.13 is EOL. No new patches are applied to this kernel. If you need this
fixed, then please check the latest kernel first and mark the patch for
backporting (fixes + cc: stable tags) to the latest stable (5.15) and LTS
kernels (5.15, 5.10 etc).


> 
> Sincerely thanks,
> Jiang
> 


-- 
Damien Le Moal
Western Digital Research
