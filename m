Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188ABC433EF
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF8D611C3
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 14:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhISO0h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Sep 2021 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhISO0g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2021 10:26:36 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4EC061574;
        Sun, 19 Sep 2021 07:25:11 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HC92B1qTRzQjgJ;
        Sun, 19 Sep 2021 16:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :from:from:references:content-language:subject:subject
        :mime-version:date:date:message-id:received; s=mail20150812; t=
        1632061502; bh=rOZLDTtW4FsPmLA23JYFH070GWoMQDtlb6u6WIlvx9A=; b=w
        w/u4Gh4g1PTdRQlMvYhPnrrwXzz1CAVHFcHSAl7GNiJ9Shispe1m96SPGX1i0bQc
        LT3eLcWkYUIyqonMk4uXT17gUsHQe52QSjt+tTfUgVZ3QBjgQAfu/Z3suCgSM5Ln
        0PuUOTcbhRoFFclPxeCKf96eumzJYkipUKa8A0c+KWcqSgvNmWwRDPvXM/wjbgxd
        CZ0+PAnh6AowR3yJjhdJGzhpajxj4LTLDucTyMMonio7mxST5lk3siiajGWLrBaV
        yy7m0nK0sYo+RzOswGo9AKEGgTgOCnOofIU3YJighBLgCwoYF/p5qa54Qr/2r8qm
        LA7mvSLxkfwPmnqOlBqyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1632061504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFCrzvvitWWIdA/0PvlWnf7mKmr8FXHcOdNEzLMV3CE=;
        b=xCPc7UyDVIh7ePp1LmvZfgL7rLX3s5lHX3enCNpu0tTH2N6IonxO91ReYzY6KrptwDYVaH
        yvhLJLtOxQbujlD7q2EXY6cvqvKUrcMT9TJzYqRcOjcdEIqo3IYAaJFtC9MinoF5iKoAwI
        0rGMirQXKxPZCylMJh6kkSrKVlBEphapEUrleVIz3Adq5DZ0JrutZabFzqUkHszIi6WYlg
        SDmFIjGMl+XQPuNfW/Sd2F5bvodq3pfGIPuiBu6r3LeiyIJLEZDUdBUaWn8wtYpL0/khHS
        Qn7fUa1QOVTzZ5h2ftcAZTRbAEKYza4MVEIpgLSp3/xsQY2IMS2fuTWXWHuD/g==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <f071dfb3-1aad-003c-00bc-6b7ecf103e91@mailbox.org>
Date:   Sun, 19 Sep 2021 14:24:49 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
 <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
 <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com>
 <yq14kb24e97.fsf@ca-mkp.ca.oracle.com>
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <yq14kb24e97.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 029B326C
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

I saw that v2 (?) of this patch has made it into stable, which
is quite reasonable given the number of bug reports.
Are there any plans to "enhance" this patch once sufficient data
on controller support/drive combinations has been collected?

I didn't run any benchmarks to see whether performance has changed,
but I now have this on 5.14.6:

   /sys/class/ata_device/dev3.0/trim:forced_unqueued
   /sys/class/ata_device/dev4.0/trim:forced_unqueued

Before:

   /sys/class/ata_device/dev3.0/trim:queued
   /sys/class/ata_device/dev4.0/trim:queued

These correspond to 860 Pro and 860 Evo, connected to a X570
mainboard (AMD FCH controller).
Note that neither before nor after this commit I had any problems
with these drives.


On 03.09.21 03:21, Martin K. Petersen wrote:
> 
> Hans,
> 
>> I just realized that all newer Samsung models are non SATA...
>>
>> Still I cponsider it likely that some of the other vendors also
>> implement queued trim support and there are no reports of issues
>> with the other vendors' SSDs.
> 
> When I originally worked on this the only other drive that supported
> queued trim was a specific controller generation from Crucial/Micron.
> 
> Since performance-sensitive workloads quickly moved to NVMe, I don't
> know if implementing queued trim has been very high on the SSD
> manufacturers' todo lists. FWIW, I just checked and none of the more
> recent SATA SSD drives I happen to have support queued trim.
> 
> Purely anecdotal: I have a Samsung 863 which I believe is
> architecturally very similar to the 860. That drive clocked over 40K
> hours as my main git repo/build drive until it was retired last
> fall. And it ran a queued fstrim every night.
> 
> Anyway. I am not against disabling queued trim for these drives. As far
> as I'm concerned it was a feature that didn't quite get enough industry
> momentum. It just irks me that we don't have a good understanding of why
> it works for some and not for others...
> 
