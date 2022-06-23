Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21CC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Jun 2022 22:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiFWWw1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Jun 2022 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFWWw0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2022 18:52:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79452E6F
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656024745; x=1687560745;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Gl+bjLJQNlKGHr4W4hkL8+WpjOzJ+AEwXBuJPGmo1r8=;
  b=ffV/rDBW0R7PbLAporsOKz24F2oQ0zCgghfddchtJL/VkOCBtoDX0yLA
   c9ACWhEzof2rOv1IsLTRaEejG0UOx7M/TVRs9G+2ZX8VwxhDq6NIjV3VY
   BOQG/Ampl9DfZT6eDTaul2keocJm80Cz0pzlHcM5nIHXHlva/T63u4gR8
   OhIA5Q7acZ9BOKmGmVV1nBOc2GpU+WwvsQ8XD+Jstj9P/C4NRTzMBpPJ/
   oFGPFcFtiaTX5jaBzVZh6Nz5jPP0a+g4avPPclHOUib1BDbMFhVA8E04k
   ZafgL8z1xwBcA/sElV145C6jhgcsUAikGbRV6UJuwGyCZYyPLkSDwZINg
   g==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="208826875"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 06:52:24 +0800
IronPort-SDR: Apm0Hj83B7Y5sEe/KIaSX/9FgPNFls+cMEyPS/FfNx/zcK7n++khyWO2EFMNnv0pECD4dzoVlu
 vKG6D3M88FMt7/EiFHXUXjlUc40qQiR6CGv2r9E+rbHPV6a2MOLaQGCkzhQ02BaTwLmwUDXkuO
 zBJN3IFr0Xa8NDLE1/Gs9Mx0tE+ifA3QdZE2XFZK9L3v1H4yh3jVmWKJjiOdXOukxwvlJdhbw0
 ehIoTJzF2U9XNCegu3jl9VcW0EWXY3hok5BZZKJA5wto5kkVZhPzT3drfHePq7P8TeKeqaFcDd
 6ByRKdKnagojoNtsdHbqln9z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 15:14:52 -0700
IronPort-SDR: ZDZCMuN5iQUXLEZRxwsXCcHhr+4oUQXmpvrLogyQkzw+aDXowBVfBJOKdJN2/SNI0k4ZS2qdBt
 O2j04dgdtbDX9qgzVhU/f4vQ2KCQRJ/YLVfcePbm8s4rjge6AZ5EbW3qxmwlHRdFqTAYi3rwRo
 U5kzKzEpqhOk1CtwbhNoIohxTmCj/Tjtp7I/8bj6QYPzZn9w4YLpmfGhOIaj9Rx8HzpleTiYj+
 woWmN7nSO0iJMSQRcjvLRvFCl4ddnymdt1CUMsQDjIRurf413hwCWO0OBfBaaKBgH8Pi+n90DB
 i84=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 15:52:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTb9h5g4xz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 15:52:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656024744; x=1658616745; bh=Gl+bjLJQNlKGHr4W4hkL8+WpjOzJ+AEwXBu
        JPGmo1r8=; b=ULWeNERB9qdUnKdjFDklMORLWaJIvtZFc0alvS68c1iDTLeJsfa
        uTk2a+1U8qGW4Yc18afOd3XOURyOLpyN3QCbLaoCKnLleq6CCmbq96/PrEAqPBgM
        SrVPIog5O438IpO8C+XcaycMtvuE0V0rcojfkyULoXKwUK2NPzwqxZ3Rp9EX0Gzu
        FmzMRRTEKsEEgDzCqs0Yb1fNwecUIqK3qpvJO+ZF8UfTenbFxuLTHXg2nEYMNSLk
        fSk121V1ZJY/5xOfDcISrsnyKRZlq3emE+OmJEt3FfCmNH50+LVFkCa317I1/65A
        yznCcIZCF2EDHOEOaAmTuFmFC9ucz3Vh4NA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id blufOy6GNryb for <linux-ide@vger.kernel.org>;
        Thu, 23 Jun 2022 15:52:24 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTb9h0kYGz1RtVk;
        Thu, 23 Jun 2022 15:52:23 -0700 (PDT)
Message-ID: <f8ecc381-88bb-0fb7-d23c-3c074e23baca@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 07:52:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-scsi: fix result type of ata_ioc32()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <05a7fcf4-3a2b-3012-34c6-ca1f00fa457c@omp.ru>
 <2e7f96b6-2223-c687-a65b-6b90964bb4e1@opensource.wdc.com>
 <d1363b9b-db0a-a9c9-199f-ab71dbbc55d7@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d1363b9b-db0a-a9c9-199f-ab71dbbc55d7@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/24/22 03:33, Sergey Shtylyov wrote:
> Hello!
> 
> On 6/23/22 2:45 AM, Damien Le Moal wrote:
> [...]
>>> While ata_ioc32() returns 'int', its result gets assigned to and compared
>>> with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
>>> caller, which implies a problematic implicit cast -- fix that by returning
>>> 'bool' instead (actually, the object code doesn't seem to change, probably
>>> because the function is always inlined).
>>
>> Looks good. I would though prefer to change this commit message to simply
>> say that ata_ioc32() return value is clearly a bool.
> 
>    No, just changing *int* to 'bool' wasn't the purpose of this patch --
> I would not have called it a fix if it was so.
> 
>> The implicit cast to
>> unsigned long from int is not really an issue at all (the reverse cast
> 
>    In general case, it is an issue -- as it involves a sign extension (and
> thus a needless extra instruction on an x86_64 kernel)! However, with the
> possible *int* values just being 0 and 1, it's not much of issue indeed
> (except an extra instruction just being there)...  In reality , that extra
> instruction is not there, probably due to ata_ioc32() being inlined...
> 
>> would be an issue). And keep mentioning that the object code does not change.
>>
>> By the way, does your statis analyzer stop complaining after this change ?
> 
>    I don't really know -- all I have is the online report generated for the
> whole 5.10 kernel. I still can't re-run SVACE but maybe that will change soon...
> 
>> Because we still have an implicit cast in the user site.
> 
>    A cast from 'bool' should be OK... :-)

Yes, I am aware of that. My point is that the commit message does not say
WHY it is OK. Need to mention that the cast is between unsigned types so
is fine, or something like that.

> 
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
