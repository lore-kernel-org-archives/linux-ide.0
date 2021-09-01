Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA46C432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AAC61059
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 17:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbhIAR6Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhIAR6P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 13:58:15 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8581C061575;
        Wed,  1 Sep 2021 10:57:18 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4H0BbH2L3szQjbT;
        Wed,  1 Sep 2021 19:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1630519032; bh=iiFuur+l1J/KhtNF4tWXIjcm5al7+tE31ONOdSHYhFA=; b=W
        Ucl38QZkuNwOmjivRpl2Cw2BZY6AsWXuQq0LlrHRfjcnCdZjz04Sfa6fDUpWB3PB
        XnyeEAo9F/yg17NOPt3np30Dmj1mdTCEUIIV7v0ZqFa6eqi7sq9QTaN25DKToYa1
        bWlrgOr5e8aZk4/Q07kgRiNYalpO8LNNV0vI/LWK9rOur/zTzWRMysITj8TWoccT
        xuh0YIiXFHfrIQ8xDmOoHfJGSxUDWRo0Pr/ZA/Wm5fJFmdYMCBYhjm4rNEYxnZAR
        ZuD4ThNcjPhBT4vgNEYEhlGsk76+p7e2tz3QV/51HVS0hdDuSnMkIhULeiR8jwPD
        FrOMhAalDsvdqtCsqkdOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1630519033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FM1G0FVwaL8AnIvDuofXr9fZVFPakaZvOfxqNvVWMHE=;
        b=cU9AGLR/+v2+rsGl/tn2zoiJpFLHdPEU6Xawx80W0uVQ1c9NUNSCb1zx8qxPpq57c9CJuU
        8RguYsttycJ/gV2iI9elU1HGvaZOzmYAKzHRnzUXvKUQtuQ9JJ9QYyS53movMWfxAv1/ad
        cRvm3L/NeS7r5HE7YNxkAVrwGes+EngY0to1dXarhcOMvCmJ3CsFVwQkEEWDON0R7mvajS
        8IDvOddv3IZk4sja8YKvk+R/vgViI6ACj/QQHOiuGOGQjHW/u5mZUuXAvXfcnkfYAFCWfO
        iz15Y07pcihW8dHIU1i+GbDVEjcTNcvFBh8TvMi02amyDr/xBIiDMylHyqCb9Q==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
 <DM6PR04MB708115B43C231444AFB22DC2E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Tor Vic <torvic9@mailbox.org>
Message-ID: <1e52352c-05e3-700a-58e7-462e1c0adbd1@mailbox.org>
Date:   Wed, 1 Sep 2021 17:56:57 +0000
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB708115B43C231444AFB22DC2E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6200D1898
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 01.09.21 08:13, Damien Le Moal wrote:
> On 2021/09/01 16:38, torvic9@mailbox.org wrote:
>> (Sorry for not doing a proper reply)
>>
>> Hello,
>> Noob here.
>> I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and
>> it just works flawlessly on 5.13 and 5.14.
>> Are you sure that *every* 860/870 is concerned by this problem on
>> *every* AMD controller? Isn't this too restrictive?
>> Or am I simply missing something?
> 
> Is you drive being initialized with NCQ enabled ?
> 
> cat /sys/block/sdX/device/queue_depth ?

Samsung 860 Pro:
$ cat /sys/block/sda/device/queue_depth


32

Samsung 860 Evo:
$ cat /sys/block/sdb/device/queue_depth


32

> 
>>
>> Thanks,
>> Tor
>>
> 
> 
