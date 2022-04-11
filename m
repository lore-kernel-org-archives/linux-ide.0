Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549BC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 22:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiDKWv6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244558AbiDKWv6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 18:51:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2FE9E
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649717382; x=1681253382;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=7Nz/bhwPAUVVEXiOCv+1MtMMlzuqmXov7tERGUR3Hqs=;
  b=f7XMp5nWNSaOjpvrRlGpP59B2bcABHDfhG5qyW+yjxVHeRvYoWaZCIEL
   CexxbMwncPJ92hJRBzJc9SjcCtbA6/7ZUahN8jlOjFr/Y3/CdvKq2YS3L
   /HhACKD1CbhihaH+igQGXh8sBt9EiNbfcCS7PblCKoI6MWjvFrUBty6W0
   YI1s26ZBbia6HgiSIXmBJp3ZB2G9bX8tVxKCGGQsAFTOXj8dsDFgfcYP9
   09h5pE+PNfuVEU4n+/VWqakiLeQ200ByRRy8LKgLO4l/Pb7ANH3oZIKl7
   y9YpeseQaELK7y8SHVjGUYTKpRo6faUubXMKOXKIcTA+kNYCY93iRXGDw
   w==;
X-IronPort-AV: E=Sophos;i="5.90,252,1643644800"; 
   d="scan'208";a="309629562"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 06:49:41 +0800
IronPort-SDR: Hl3rkrSQ3u2InmNfpvtfAykWeWagHwgY2bDXC2Q+Ec4QEbHtngYrw3G29rqA1zGA7r9PjtPFvo
 IqK4MK+D/xzRQ2S2mogKi3UuT8th6rj72BhvGBWj1UNJnK+fSNPdckLMDGMfrSVEkNHS46LDTl
 VUTuhPYbQmTtyDYtW1hqoVX+MeflNmgl5GWxAwLgjgGzkJ1ndHiIIPxVyDuyDt1r/PUiiZBVMq
 afXL01HgtZ+YkKnK9+T8ngS0VK/m5wTNEh68Xj8nM1x9Bj5hRFWMurCEC02FCKzhtoscMo/RQr
 A1oI37Q5zyVwcsiKjS0of/5P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 15:20:58 -0700
IronPort-SDR: q+c+fkxiYewVnsAkblnm4gmVb9zqq7SqcAtTPGTkpkT6CgveESTF0JN7jQGRtrKnElPQ6U/rvS
 4MNM6CRs7x+rrsHJC/bDiq+V8JBjcGZLi4/zQgD/S23IyykRSraNxgT5738InAZ7yNCxqmJlyp
 7K2cHJuLWMQ0Qkhf9wc75nYxlpg6WrcJMR5NQ8EG4NeZORHpR+ka2alT4A32InMntslSeSqL3J
 W3oeQcDIyhA0CsY/U/ug3OwrzUYwNEGhfvTcMvyOM9UaySQky+I/Pzh6eXPPpFsuFcGn3GOWux
 KCc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 15:49:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KckZF0ZSkz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 15:49:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649717380; x=1652309381; bh=7Nz/bhwPAUVVEXiOCv+1MtMMlzuqmXov7tE
        RGUR3Hqs=; b=r33EFss6a2M0hTgjsMVnc/eWRE0EgDH19747+2k2w7xsFbq1sVV
        XbDEPSz17DqkjAvjB47iVWowokkk1Gk9KbUYD+cNg99ZzYyHJgEjcvTt9jhZWre9
        2+6Nch8xUCTWtGpCUKWitN9m/bMz7diXFPYtM88fa+/BBm4Xb94SpHVIvMw0PWDg
        FsTbYE9z3u8BImNjgRCfL3m/jRtJx88CYxI3QHWqNauz7e/kieuOdIZRph7WErzJ
        y/s+/ezRw2Y8rY1B6R7m4keMU4CMi+X/6wYsRSTvHmbMazdXvZpJqjZyylJOG8Qz
        sJuOlWf2c8MrhsKAXJAayWTDeFeXgqHuLFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yQbpsm4XFmDb for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 15:49:40 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KckZD2t0yz1Rvlx;
        Mon, 11 Apr 2022 15:49:40 -0700 (PDT)
Message-ID: <c77dce62-4851-786c-392a-dae21c8112bd@opensource.wdc.com>
Date:   Tue, 12 Apr 2022 07:49:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: pata_sil680: fix result type of
 sil680_sel{dev|reg}()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <9fceaba7-22e0-8cb2-fc69-04c0b8ece7db@omp.ru>
 <1a56a6cc-5062-fd25-4285-aa53b4ad0eba@opensource.wdc.com>
 <bfd973a5-87ea-148e-ea88-72881b202761@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bfd973a5-87ea-148e-ea88-72881b202761@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/12/22 05:42, Sergey Shtylyov wrote:
> Hello!
> 
> On 4/11/22 2:47 AM, Damien Le Moal wrote:
> 
>>> sil680_sel{dev|reg}() return a PCI config space address but needlessly
>>> use the *unsigned long* type for that,  whereas the PCI config space
>>> accessors take *int* for the address parameter.  Switch these functions
>>> to returning *int*, updating the local variables at their call sites.
>>> Add the empty lines after some declarations, while at it...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>>> repo.
>>>
>>>  drivers/ata/pata_sil680.c |   27 +++++++++++++++------------
>>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>>
>>> Index: libata/drivers/ata/pata_sil680.c
>>> ===================================================================
>>> --- libata.orig/drivers/ata/pata_sil680.c
>>> +++ libata/drivers/ata/pata_sil680.c
>>> @@ -47,9 +47,10 @@
>>>   *	criticial.
>>>   */
>>>  
>>> -static unsigned long sil680_selreg(struct ata_port *ap, int r)
>>> +static int sil680_selreg(struct ata_port *ap, int r)
>>>  {
>>> -	unsigned long base = 0xA0 + r;
>>> +	int base = 0xA0 + r;
>>> +
>>>  	base += (ap->port_no << 4);
>>>  	return base;
>>
>> The variable "base" is rather useless here... A simple:
>>
>> 	return 0xA0 + r + (ap->port_no << 4);
>>
>> would work too and is a lot cleaner.
> 
>    Yes, probably... but it's a matter of a separate patch, I think.
> Note that both functions are inlined by gcc.

No need for a separate patch. Your patch already changes the base variable
type. It may as well remove it :)

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
