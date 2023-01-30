Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FFBC54EAA
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 11:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjA3L4w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3L4v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 06:56:51 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6C1350C
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 03:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675079809; x=1706615809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4xGVOCfkdeIpFvlTCyLfRcmwSFDFBTcssIdhw0hVvag=;
  b=hA0TX8wr4PpXiOzWDs/0RLivusiZXqMPIqx3YXW41eEp+1K5PIpDGk40
   4CXrO9vHXOoz/lqC3tBoAdJOEtoUgbLOcD2ge84GEcLyimbI+T/ilpEVC
   ZD4g9ksP4grR2jqFx06cg+mwEO4sDa4ORNggt+9F2K15Zn+dvq9Oxy0YL
   rxhiFR33/3ZihhVgZBadrAP89t19yoJqT8v64SXkUXm+C6086qvURqldZ
   moSsh1seRO1AUeSLOblJFNsiLirncRtDvuXW2nVtBWMhJdgmP2f6LHn7R
   ekaeQu+F90812RhnUebReqVu7byxtdb7BWskmlY3sqWpe8NEjiuOn1A0r
   w==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="227047030"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 19:56:48 +0800
IronPort-SDR: 8C/ARUzODSgWs/rR65jDWNKpFhUFHv00u1FiiabWoRhF+U8qpG0Fil8Jc3uXt+Hx+mfvPlWTpx
 hduPl0C/7p39kk0ON5sc+jZGcZc+u10eUKH5InvaBS6QTrqtD0MD7C2ZuB25ExG0au4Y3ZJQz8
 J22LlT6oCUfFmRqjh/D9we1tYO6fQ9xg0f4Qa761/cwhhS5KizJ81FzHxjOcletWz3spSkGF2N
 ZZ2rCLx9KkSxJbzLVXqEDJeTi8A6AW3Zewikt8hCvqmEatnuncq1rvgM6Z1W5Dja92L/FyGIun
 ywU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 03:14:14 -0800
IronPort-SDR: 1Ulmm76iVf1Cir62vp5KLSUd4nsUjAUflNCFTlGFzUdXS96BFhEoOhVqFWlzlhThh2aG/Gg2CP
 +Id7TKxBGBmcp463QTdt8yC/wEXGaapZvhVOkt9b+EXoJKF4Xgy5Uq3mgC0MQuWrCNvufiEyJi
 6Tcl2fAjf/SD+cbPgSOe+HlFtA7pGHCsS2JbDs/724ZY19XeQRnmt3lbUBR+kBBGE4v1VN/u/E
 GwXdj8VUfuV1yQH9gVTcXJjy6VOqG+hN0211tVkM8xD5w3/wFwp8duV1sgBspiREpecrdHYu8q
 mDs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 03:56:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P569D2QT1z1RwqL
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 03:56:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675079807; x=1677671808; bh=4xGVOCfkdeIpFvlTCyLfRcmwSFDFBTcssId
        hw0hVvag=; b=U2jZhq/wycvcZD4wDtr3Dzq0z1uwwxONcAMNYinBBk5xGLyP4gR
        X3wa+/1CUKq5JLGipdHu6v2XrKe0mWSLr8URJ4LHmyBKlPSeOWitcVj+bePU/q5f
        y6TXJbnrxRMdbLWI9EJOr9kwmHngTo9HVhmXKTMU0ntkj/H4syHolEQ09Maa7x4+
        R8Oyw1vHaJr/u+aTbPn5L3WRNeYNPecxGfsNz1RohZBY1hD1khpblQnY9sq/GSYx
        2MNVIXZRJPQDudF94d/RD8UEmLTqMiZxQc86UEetp/X3XhIQmMOMEWV2+VIwbDGf
        dQjD1oLj5zjzfpepQRbh5nz+w6pXIDkKrdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sQsviUaCNbws for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 03:56:47 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P569C1tDlz1RvLy;
        Mon, 30 Jan 2023 03:56:47 -0800 (PST)
Message-ID: <798fcc56-b841-ea7c-e169-0387f1f024c3@opensource.wdc.com>
Date:   Mon, 30 Jan 2023 20:56:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ata: libata: Fix sata_down_spd_limit() when no link speed
 is reported
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Marius Dinu <marius@psihoexpert.ro>
References: <20230130110721.111776-1-damien.lemoal@opensource.wdc.com>
 <Y9euXc/Zdr062nJo@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y9euXc/Zdr062nJo@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/30/23 20:47, Niklas Cassel wrote:
> On Mon, Jan 30, 2023 at 08:07:21PM +0900, Damien Le Moal wrote:
>> Commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
>> driver has not recorded sstatus speed") changed the behavior of
>> sata_down_spd_limit() to return doing nothing if a drive does not report
>> a current link speed, to avoid reducing the link speed to the lowest 1.5
>> Gbps speed.
>>
>> However, the change assumed that a speed was recorded before probing
>> (e.g. before a suspend/resume) and set in link->sata_spd. This causes
>> problems with adapters/drives combination failing to establish a link
>> speed during probe autonegotiation. One exampe reported of this problem
> 
> s/exampe/example/
> 
>> is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
>> fails, leaving no recorded link speed and no rep@orted current link
> 
> s/rep@orted/reported/
> 
>> speed. Probe retries also fail as no action is taken by sata_set_spd()
>> after each retry.
>>
>> Fix this by returning early in sata_down_spd_limit() only if we do have
>> a recorded link speed, that is, if link->sata_spd is not 0. With this
>> fix, a failed probe not leading to a recorded link speed is retried at
>> the lower 1.5 Gbps speed, with the link speed potentially increased
>> later on the second revalidate of the device if the device reports
>> that it supports higher link speeds.
>>
>> Reported-by: Marius Dinu <marius@psihoexpert.ro>
>> Fixes: 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if driver has not recorded sstatus speed")
> 
> IIRC, checkpatch.pl with the default options should put the author on the
> commit being fixed on CC. CC:ing the original author is a good practice IMHO.

Funny that I did run checkpatch and it did not complain about the above typos :)
Thanks for the review, will fix this.


> 
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/libata-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 884ae73b11ea..2ea572628b1c 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
>>  	 */
>>  	if (spd > 1)
>>  		mask &= (1 << (spd - 1)) - 1;
>> -	else
>> +	else if (link->sata_spd)
>>  		return -EINVAL;
>>  
>>  	/* were we already at the bottom? */
>> -- 
>> 2.39.1
>>
> 
> With typos fixed:
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

-- 
Damien Le Moal
Western Digital Research

