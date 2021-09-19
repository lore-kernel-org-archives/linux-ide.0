Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9BC433EF
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15664611C8
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 16:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhISQ3G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Sep 2021 12:29:06 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:54010 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhISQ3F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2021 12:29:05 -0400
X-Greylist: delayed 7353 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 12:29:05 EDT
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HCClY5qCxzQjTw;
        Sun, 19 Sep 2021 18:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :from:from:references:content-language:subject:subject
        :mime-version:date:date:message-id:received; s=mail20150812; t=
        1632068854; bh=IKMY9UUboueu2OdieXheUBL+0nMu7G9inQoMZKoGVnE=; b=f
        s3Uj37ddlmr+fKEJ183Ic+iMwDh7fGHL1jt1xjuq0ZQNYQpLcZOkDk2+sbfJRiY3
        sDp7P6oyMoR7ztVG32hRBRUTj1uPaMNEUm/Xufh8flbog5GVZHh8rxBGSM9G/nBW
        q2sBt2+Dbd3MyB6A8zHy6GX+Gxopq5sU+3AL/NvTPgRuhFxhDQXEiTtw6zSrBVLj
        9zy64WrBcdgrSsgZTYsk+oMA+wvDKicrqApPZ+cB9YVEMOfLU8Cu0ITKwIWZwFKy
        K+6L05+l/VFx3dZTEt+KkBCWyxsQbvxjFjMxvbhm/kS//ludHY5R6mqwIAWkKRdt
        NByhrhyWq76iJ4APnW+/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1632068856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flMcX/DHzC1LzZjkeRywStYambmvQjVfiv1bUuqbBzo=;
        b=v4EV1CtdlRLGQ6wYsbjVRM5nB9eZm/XYZHkl2nFahOd5RU5Wwk0T83aR1ZDi+p+Q418VdO
        +el1lR2GekBQWsac1wTvHAACWXoYDJHgaOpHKfhnp7zs+YA9avsbEDN2zxL0H8M+REt5pE
        oOtwhrYC0GbUTjKSmbNixOim89lI27+v2goXytNnUdRQaC+HaaN7F806R7CA6VEe8oLzA7
        awwxJJnZYsXo9WcWjcC12/e1AUy6UtLe90OYov83Rzq/KNn4heguenvYTgRiNC0PdKt8DD
        ngKBsSJyiTP8/CPwCoUZHJe7pAusHvZUbV2MaQhEBXAcDtFn5Yo48bU0JWolIw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <66b4c377-1b17-1972-847e-207620cc9364@mailbox.org>
Date:   Sun, 19 Sep 2021 16:27:22 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
 <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
 <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com>
 <yq14kb24e97.fsf@ca-mkp.ca.oracle.com>
 <f071dfb3-1aad-003c-00bc-6b7ecf103e91@mailbox.org>
 <967d7639-fc31-a209-8c21-ea8ab3718de6@redhat.com>
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <967d7639-fc31-a209-8c21-ea8ab3718de6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DC7ED274
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 19.09.21 15:27, Hans de Goede wrote:
> Hi Tor,
> 
> On 9/19/21 4:24 PM, Tor Vic wrote:
>> Hi,
>>
>> I saw that v2 (?) of this patch has made it into stable, which
>> is quite reasonable given the number of bug reports.
>> Are there any plans to "enhance" this patch once sufficient data
>> on controller support/drive combinations has been collected?
> 
> ATM there are no plans to limit these quirks, we have bug
> reports of queued trims being an issue over all usual chip-vendors
> of sata controllers (including more recent AMD models).
> 
> Note that unless you have immediate "discard" enabled as an option
> on all layers of your storage stack (dmcrypt, device-mapper/raid,
> filesystem) then this change will not impact you at all.

Is that the "discard" mount option?
I added this to one of the partitions residing on my 860 Evo,
reverted the patch, and it still seems to work just fine.

   $ mount | grep sdb 
 
 

   /dev/sdb1 on /mnt/vbox type ext4 (rw,nosuid,nodev,noatime,discard)

Is there another place where discard has to be enabled?
Or is there a way to check that discard is effectively enabled?

Not sure if relevant, but here are a couple of lines from the syslog:

   ata4.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
   [...]
   ata4.00: Enabling discard_zeroes_data

Thanks!

> 
> Also note that AFAIK all major distros do not enable immediate
> discard, instead relying on fstrim runs from a cronjob, which
> again means this change will not impact users of those distros.
> 
> So chances are that your workload simply never triggered the issue;
> and this is the cause of everything always having worked fine for
> you.
> 
> Regards,
> 
> Hans
> 
