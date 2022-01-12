Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23AC433FE
	for <linux-ide@archiver.kernel.org>; Wed, 12 Jan 2022 23:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiALXrp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Jan 2022 18:47:45 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37734 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiALXro (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2022 18:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642031264; x=1673567264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hOQE8ZtdYX5L5to8BlW+o/DAHL3QOHKjG1kBU1SyvCM=;
  b=iaXullLUJFhbQHYSQAclFTMJdNiIALzebI5AOqr6VrhJWrUmSBh/Iy86
   ihUNBUlPG1/U3iwyEKj1TCBE9Vv1o/YaQdiy7q3O8Gee6T/IncJbaFlbf
   t1JC1GgwmZvM8dxG1HRsjJApPOeiwJjtQKUfT/Wxy1AgwIqlCj7ws4Bwu
   VKjTF6rsOUWq/Js12cop6owSVF69ULBsE5wIcSzMZEZadAt3rBUaw56nx
   Fwfh8X2P0WRvaaNIr+2Fg70Z7bfluq1eTNj6xPca72KFRn6+l0aPUcK11
   ZNc0IA487CsgO7plJD12RJ9pBXpq/zoq3rLrV4ENLtIeSCjsfvpjG4Uus
   g==;
X-IronPort-AV: E=Sophos;i="5.88,284,1635177600"; 
   d="scan'208";a="189287610"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2022 07:47:41 +0800
IronPort-SDR: pbehstFkQvqJFv4CrN5QNFoFJ/B+fgw601D5rv0jfvIGifyqih/RwtwP5xFZa7YcJVxp6snZ54
 LVwULr0FMHQw1T9pZq8V84rXwGLQUKMnByhVb+7a+BDG99etEWNQdG+Sldo2Xr1RkQCE4Vpi3Z
 WDEQMCbE2sg4DJEFQ6L/V6XyFnN4q1ZSw8rSzD/I0d3ysfmJsnuEUbAgORyFt5ziXAn0JMTzjV
 +iEL1/sk1h2+gu5N9BnKR5KzlOWMdFKHtUePiIf3HbWtATa64CQVhUvDqqRCw923dzSl0FoZai
 Pd1SYffNLM/F/Py/4R7v+Qvt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:20:03 -0800
IronPort-SDR: +zrVlZT4e5fr7WmTRPVXuKw6Nk/O9UGoCVG/oPhQ7HkO242VjwwFwGTcxce1DiwvglY4+hzIdW
 NfNfx3OlXSNetyR4tCfg6wxrbsJDIAf6xkYbQfOGDX/YAYuzQNwijcfi7WrsfSWQL4Ee21Biej
 l68nSFMmCAWg0N7phFmjs42gxWaa2pUOkVONy2gQBZdgxuqZj4XYxDXxCvTMiTNx8MlgZvx0sk
 YHOlTW5hZTY3u091VZ7asEQSscZMojVOVvazQfYC+rGcHu5OSL42+BS/k/wfMvPEyPVNRQAlh0
 5C0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:47:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JZ44F3cFfz1VSkg
        for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2022 15:47:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642031260; x=1644623261; bh=hOQE8ZtdYX5L5to8BlW+o/DAHL3QOHKjG1k
        BU1SyvCM=; b=bt/g+5PNPAg5XnmCJkvEaQtkGW5MpYYtQI0ncC6dXgYgNM7R2Cx
        N2Kuq9MDR5I9VzD2NTQ2hhQFTJhZ2VuTRZyKHVGmg6vhmkmeH8KEboEVjocY7iqz
        IaM/534kcqFh9X7cPOofceRtGFFydeZQfM7dHGkbmMqiY2pkTKUln2lkvvBDgzLc
        TwvUyiEQ1dLyeYlscLsNYor/KcjbXYLmVP9yXi6V5Tfl+xETePR22AdO9ofcyiB7
        3AsGVoyf0MF3/m5k5pwABEI5bHrgEMXCDzF63Fu4hXDxGpmMjDhu3SJBdacSeAk+
        U5vTYwJ1OWou8ee1rtQp+yfKyXvrUe5hbEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uATLunptAhDb for <linux-ide@vger.kernel.org>;
        Wed, 12 Jan 2022 15:47:40 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JZ44C3GR1z1VSjC;
        Wed, 12 Jan 2022 15:47:39 -0800 (PST)
Message-ID: <ec4d9eb0-3999-db52-1eec-bc6351dd4f07@opensource.wdc.com>
Date:   Thu, 13 Jan 2022 08:47:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220112220652.3952944-1-keescook@chromium.org>
 <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
 <202201121515.8679164D6@keescook>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202201121515.8679164D6@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/13/22 08:15, Kees Cook wrote:
> On Wed, Jan 12, 2022 at 03:23:40PM -0700, Jens Axboe wrote:
>> On 1/12/22 3:06 PM, Kees Cook wrote:
>>> In preparation for FORTIFY_SOURCE performing compile-time and run-time
>>> field bounds checking for memcpy(), memmove(), and memset(), avoid
>>> intentionally writing across neighboring fields.
>>>
>>> Use struct_group() in struct command_desc around members acmd and fill,
>>> so they can be referenced together. This will allow memset(), memcpy(),
>>> and sizeof() to more easily reason about sizes, improve readability,
>>> and avoid future warnings about writing beyond the end of acmd:
>>>
>>> In function 'fortify_memset_chk',
>>>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
>>> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>>>   199 |    __write_overflow_field();
>>>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Cc: Jens Axboe <axboe@kernel.dk>
>>> Cc: linux-ide@vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
>>> improvements that are close to being finished. :)
>>
>> I don't maintain libata anymore, so Damien is the guy to nudge ;-)
> 
> Ah-ha, okay, thanks.
> 
> /me waves "hi" to Damien. :)

Hi Kees,

This is already queued up in libata tree for-5.17 branch. I have not
sent my PR to Linus yet as I am letting things soack a little longer in
for-next (for the various arch compile tests).

Please check that branch to see if all is OK !

Cheers.


-- 
Damien Le Moal
Western Digital Research
