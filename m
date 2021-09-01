Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BB5C432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA661075
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 17:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhIASAK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhIASAK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 14:00:10 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C6C061575;
        Wed,  1 Sep 2021 10:59:13 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4H0BdW0VV4zQjbT;
        Wed,  1 Sep 2021 19:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1630519147; bh=BMj3hHFHRab3vlCbBIFiLrtUb0q1SMSErlMPxYYkAjs=; b=u
        9Im9+uznUf76xF68xyuBs6wbDnxO22FyxbuEJJSHD5m6Iu10WU8ckS8LvHbUgQ+H
        UlyczrgAZjk6g8zRnvm7Df5qUIzcdKrOQiwraE8owPfVUvgFcrOL36dgXXlOlJ83
        HQgtVdtefYHCrG5QIhb2CfN1U4GFje1FwCuWA13WVuqakZqbyfZAjNldYVGljAo7
        13XaP3Lxb7YEDgvTBW9kdovxJ5ODwcdlBjyr+ezHwdZZie7JSM0vM3sToU8nalsF
        zM1z8Tv+7jIlmj3GDeS9XDCo4uEh7z+OYgFg5yxVa3drt923zzdKwL9wi2ynEOn7
        pcWlKDeQSmTDuAiYHpBHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1630519149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdLpmrxP2ooqH61k5jccYeKJaNQbe1umwKmOIiwgD1g=;
        b=cEu9n+1FrejwgxjwN1NKTGOtD0LksEjqDQLPhzeaxAHu2TKW274qTkXiXxLxAf+CrLZDDS
        3hgmMRpyYOBdwcEXY0OjvfeXzdAE4H9OyGZceBlHtaykkatQ9qscMw9981HQxc7jlpfmv1
        rYyXrIIVhrLp7HLMQbKT1/g7Z1sANNIrmfnOqFc84IKRvovVb8dtQJIwaBq2aZaHWdREc5
        xdT2MTgh2KfhFBJ0lSzN1EMr5xsUwBwpklIFaHQK89zdBi2fXnQ/3ipQLvISIRwMxBIyzM
        n35sJA2eeotMZNZXDKGmjqU+iP+ojfI1dUm8OzfLVg8jIOtElJNPB/KqOeSh5w==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
 <e6f9921d-0fb6-da30-4dc5-53b4cb7b5270@redhat.com>
 <2df1c3d5-301d-dc46-7f9f-d28be2933bd3@redhat.com>
From:   Tor Vic <torvic9@mailbox.org>
Message-ID: <aee2ea3b-bd3f-7273-13dc-a0c231021421@mailbox.org>
Date:   Wed, 1 Sep 2021 17:59:06 +0000
MIME-Version: 1.0
In-Reply-To: <2df1c3d5-301d-dc46-7f9f-d28be2933bd3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E2446183C
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 01.09.21 09:38, Hans de Goede wrote:
> Hi,
> 
> On 9/1/21 10:55 AM, Hans de Goede wrote:
>> Hi Tor,
>>
>> On 9/1/21 9:37 AM, torvic9@mailbox.org wrote:
>>> (Sorry for not doing a proper reply)
>>>
>>> Hello,
>>> Noob here.
>>> I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and
>>> it just works flawlessly on 5.13 and 5.14.
>>> Are you sure that *every* 860/870 is concerned by this problem on
>>> *every* AMD controller?
>>
>> I am pretty sure that every 860 / 870 EVO is affected,
>> I am not sure if the PRO is also affected.
> 
> So while reading https://bugzilla.kernel.org/show_bug.cgi?id=201693
> again to add a comment asking if anyone was seeing this on a
> pro to I found existing comments of both queued-trims being
> an issue on the 860 pro, as well as the 860 pro having issues
> with some AMD sata controllers.
> 
> So it seems safe to say that the 860 pro has the same issues
> as the 860 and 870 evo models. Chances are you don't have
> discard support enabled causing you to not see the queued-trim
> issues (which means you also won't see any difference from
> disabling support for queued-trim commands).
> 
> So this just leaves your question of:
> 
> "concerned by this problem on *every* AMD controller?"
> 
> Where "this problem" is needing to completely disable NCQ
> and I guess the answer is no, not every AMD controller
> is affected. Still the plan is to err on the safe side for now,
> allowing overriding this from the kernel cmdline with:
> 
> libata.force=ncqamd
> 
> I will add a comment to:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=201693
> 
> Asking for PCI-ids of the controllers where people are seeing
> this and then maybe we can narrow down the "AMD" check in a
> future follow up patch.

$ lspci -nn | grep -i sata


06:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode] [1022:7901] (rev 51)
07:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode] [1022:7901] (rev 51)

Both Samsung 860 Pro and 860 Evo are connected to these.

> 
> Regards,
> 
> Hans
> 
