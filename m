Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AC1CDB47E
	for <linux-ide@archiver.kernel.org>; Sun, 15 Oct 2023 22:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjJOWMb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Oct 2023 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOWMb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Oct 2023 18:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC391AD
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2023 15:12:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC22C433C8;
        Sun, 15 Oct 2023 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697407949;
        bh=p8UU1UDLkiBhWss8s6Ji2Z0sAOOEhnJDlRtvHpezWYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tey6XlElTKePki8JFJ6bvUUTLlPOqnlm+SAz9XYMOJLiaJfH2VQt3bco/S7uIlIs3
         rAgk7hJ93IXK+MExmRfj6ptMjadw7tvNZEOC9pJIiiiTroycc8/rt13+bmBqXpRh2e
         IO/sRm23lDVkEsD6NjOu/JZGLbWhQE/zDnBhId2UeTm4XqoNSP3n/uYCqNxwcbqdTa
         0QCxSAopVZtxfUa2nt6Xxd5JzR1+Z8x2Bi3peWjMIpUhKO2HuS78+w0iL57hQEyT3u
         CEeUJU+hvfYzA+5A1nMzCGFXnJujeTGHyGv7yo3FlUxaKSK9WcXMKFWusLTjBQvEPO
         XJjiz8mQQBfkA==
Message-ID: <d3497bc5-dded-4030-ab28-ff374164634c@kernel.org>
Date:   Mon, 16 Oct 2023 07:12:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Content-Language: en-US
To:     Phillip Susi <phill@thesusis.net>, linux-ide@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20231012071800.468868-1-dlemoal@kernel.org>
 <20231012071800.468868-3-dlemoal@kernel.org>
 <87y1g6ftby.fsf@vps.thesusis.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87y1g6ftby.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/14/23 00:14, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
>>  /**
>>   *	ata_dev_power_set_active -  Set a device power mode to active
>>   *	@dev: target device
>> @@ -2065,6 +2092,13 @@ void ata_dev_power_set_active(struct ata_device *dev)
>>  	if (!ata_dev_power_init_tf(dev, &tf, true))
>>  		return;
>>  
>> +	/*
>> +	 * Check the device power state & condition and force a spinup with
>> +	 * VERIFY command only if the drive is not already ACTIVE or IDLE.
>> +	 */
>> +	if (ata_dev_power_is_active(dev))
>> +		return;
>> +
>>  	ata_dev_notice(dev, "Entering active power mode\n");
>>  
>>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
> 
> This bit didn't apply cleanly to what I just pulled from Linus.  It

The patches are for 6.7 so they are based on for-6.7 branch (for-next is the same).

> seems there are soem differences in how the tf is set up.  Why not move
> this check to before the tf is set up?  There isn't much point in
> setting it up if it isn't going to be used.

ata_dev_power_init_tf() also checks for the device type and horkage flags and
return false if the operation is not necessary or desired. I left these checks
in that function instead of moving them to different places. That is easier to
maintain this way. This is not the hot path, so I really prefer prioritizing
simplicity here.

-- 
Damien Le Moal
Western Digital Research

