Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83295C4332F
	for <linux-ide@archiver.kernel.org>; Thu,  9 Nov 2023 22:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjKIW5q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Nov 2023 17:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIW5p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2023 17:57:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1394220
        for <linux-ide@vger.kernel.org>; Thu,  9 Nov 2023 14:57:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A78C433C7;
        Thu,  9 Nov 2023 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699570663;
        bh=WHbUmBcQQGXFl7by1aklZWz8d47D/iH7WoAd7SO3YG4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XS8iYqudNAwQ6Mfjdp096Jq0Lfo6lZPvNl4RbDB3SV1PeWRt92DXW63NMZY8rZZFn
         FARCXYsNuqSG6xLQt2niy0b0soV11kkMZy6A9aFtUz3v4cqRfEl8vo7Em2TEWJxMvu
         gPU+ppVgD0+SKENtkNeznwCxjWWNhNg0FyuT3m0TQGXdRZo50HB1U6Fa1NeO10tdRJ
         oHk+iZxBRauJHbXwr/EGqCc/7NUyP68acq1Fsvy2BngZZEfSIhDATDJlvLUVfj8EvM
         FIN1AkNjQ5vCqzAc6wtX/k7y5oeY8VrNF1mGX57z4upCJ1z2Ymm+3PQQsBAvFND98G
         Xv+FnoP3O35Qw==
Message-ID: <e6655105-0f43-4dcf-975a-26a7951a336d@kernel.org>
Date:   Fri, 10 Nov 2023 07:57:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
 <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
 <871qd1n0cm.fsf@vps.thesusis.net> <87a5rpz13n.fsf@vps.thesusis.net>
 <7141dc0d-eb1d-41d4-a608-c1fd569e4325@kernel.org>
 <875y2buc13.fsf@vps.thesusis.net> <87pm0ipoiv.fsf@vps.thesusis.net>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87pm0ipoiv.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/10/23 07:09, Phillip Susi wrote:
> Phillip Susi <phill@thesusis.net> writes:
> 
>> I hadn't pulled in some time.  Updating now.
> 
> Great... the latest post 6.6 kernel hangs on entry to suspend for me.
> Bisecting it now back to the 6.6-rc5 that was previously working.

Arg... Are you testing Linus latest tree ?
I will rerun tests on my end.

-- 
Damien Le Moal
Western Digital Research

