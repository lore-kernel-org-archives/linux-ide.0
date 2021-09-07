Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C5C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1BB60C51
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhIGAyE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:54:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51612 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhIGAyD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2021 20:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630975978; x=1662511978;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=GfqmEDyqecOCTdbRkcmjU1o7uRqFSmJ5wFZXBTHMPlQ=;
  b=SkFcsFv88mUFabH6DJwkgkUokK0lsnRtmI4VQoPnTBZHeVWBqs+RZTEv
   y9zQAIjA/Xrnjz5PVEstr7sl6fowkPWBrWUdA3EfX9RXdcKm12ZbTmC/s
   t0AVNuhNTXoh9aD8Awt26WwHEBUVEtvgb2OESH3aDbYnSr6bZnCRqrGzs
   sYgMFgunqBBEr8JG0XxQfIKH894tJna6yzX4lBYzfn6YFbvuwfr3sDACe
   QZ1FGvKG3UJ0K9KG1/8xOODiGROoTDg40xS2fDRMHIhdjSQXXS9gKCcrU
   ueL7hwpMR78MbrXgCOeVTRVeTnYRka/5+HXSHh7tTADcg1UEBZIh5Evwz
   w==;
X-IronPort-AV: E=Sophos;i="5.85,273,1624291200"; 
   d="scan'208";a="290942055"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 08:52:57 +0800
IronPort-SDR: IH7JIQ6Wy0syR1xEFLC7ozPlK2ZrSaWLI1FNwKtS2e1Q8ugEHTuaWUQtPoED/+6H/CNqm5Hfea
 oWLRu36OcJ2SVFiACcEly6CHrSOmKkSrpTkyPOFfWpsaQtDlCJ71lwl7pc3Q86OvnJlxGgM+ty
 1QvrOgfsO91IhcRqAZuxU9bO7e/pXnmN9WzofKbDwTWSMi/Fwv7w2MRitikX7HEvooE1QugGAq
 8e38gZBnIAeiCwgfDY5gq6M+P1UqKZqV+bR8TXTmlgJ3CBRKrUcsJmFOVl4C0vKxanSpz78yFy
 PJLvR+1NGZ1j40WfA95/mmzn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 17:29:36 -0700
IronPort-SDR: NKKCR2xj25V2zaYThj154CCg3lkdsEXLjzE1TMxWOeJxVtpGqylQ+mLPej7itBFt+krw3KCjLl
 j/CJ4xDxk3uFE0J5yJa0TYiJZB9fE5/rruqii7C2Za5qY9ZRGxEIyWbGoueK5uVILPxm2J+e73
 IcElpMAkOZXciVcJq0iTxomd986tjMdpd/GKMImDJBBDhgtS+rWt8hRjE2e/bWD6Myf3oJezLL
 /NOF+uzVkwv7Q2DqzjAuxVonu20HQ7Wm1uN3cSUH2hB3ANCFecyxvHlecbTt6xXUNnkoJRyOB4
 PRc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 17:52:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H3RZd47Pyz1RvlV
        for <linux-ide@vger.kernel.org>; Mon,  6 Sep 2021 17:52:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1630975977; x=1633567978; bh=GfqmEDyqecOCTdbRkcmjU1o7uRqFSmJ5wFZ
        XBTHMPlQ=; b=szQ/okbtVKwSte3eyXjF3hYQGBtVUDR2tmIdlvTIw37HxiWuvtp
        Dngn5T9Rqronzz6c5oPhpJoDqwyXOI3AEK74CqsBVLFsb2k/oRyWU1vnhf1N+KvE
        QTG7MPFQWnUDwpGhX8Z+JMEJM4tiaXsMlO3jHeY4PhkSYU/sF4TNakUyFQrkZBEm
        zYtyBHkFVZe4j1iLNazuQngBYDDjKqSIGmQB2noUgNXVS2b6E61L25EylMFTT7S5
        At6h3Kn0tIgh2e28kQhxrVKD6+kXMSqEOE4W0yLcVWPVsswQIFK3t/SHWB/0nuEb
        peUOGBHr2A2ocyAUrdXhU2+M+4gP14Mipcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id agNki_O2Rkcz for <linux-ide@vger.kernel.org>;
        Mon,  6 Sep 2021 17:52:57 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H3RZc6KFJz1RvlP;
        Mon,  6 Sep 2021 17:52:56 -0700 (PDT)
Subject: Re: [PATCH] libata: pass over maintainership to Damien Le Moal
To:     Jens Axboe <axboe@kernel.dk>,
        ALWAYS copy <linux-ide@vger.kernel.org>
References: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
 <4f9b5f1d-7130-9434-8c54-23b4117bbad7@opensource.wdc.com>
 <1b3ad1ca-b3d9-3258-059c-44d74344b9a3@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <0ddfe118-39c2-ea97-73e0-9751c8efe94e@opensource.wdc.com>
Date:   Tue, 7 Sep 2021 09:52:55 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1b3ad1ca-b3d9-3258-059c-44d74344b9a3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/07 9:50, Jens Axboe wrote:
> On 9/6/21 6:47 PM, Damien Le Moal wrote:
>> On 2021/09/07 9:45, Jens Axboe wrote:
>>> Damien has agreed to take over maintainership of libata, update the
>>> MAINTAINERS file to reflect that.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index fb1c48c34009..ed9e3770d8b5 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10597,10 +10597,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>  F:	drivers/ata/sata_promise.*
>>>  
>>>  LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
>>> -M:	Jens Axboe <axboe@kernel.dk>
>>> +M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>  L:	linux-ide@vger.kernel.org
>>>  S:	Maintained
>>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
>>>  F:	Documentation/devicetree/bindings/ata/
>>>  F:	drivers/ata/
>>>  F:	include/linux/ata.h
>>>
>>
>> Jens,
>>
>> Thanks for sending this. I did name the tree "libata" but since this includes
>> many drivers, would "ata" be a simpler and more general name ?
> 
> I think libata is fine, but it's really up to you. 'ata would definitely work
> too, especially now that all the old IDE code is gone.

OK. Since I think everybody is used to libata, let's keep that then.
Thanks !


-- 
Damien Le Moal
Western Digital Research
