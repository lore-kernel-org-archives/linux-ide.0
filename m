Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705DDC4743E
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 03:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5769960C3E
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 03:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGDnj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 23:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGDni (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 23:43:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82E2C061789;
        Sun,  6 Jun 2021 20:41:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h1so228974plt.1;
        Sun, 06 Jun 2021 20:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VtFXrsX8w0w0nf24oPfhWOTgY39JrMcR9uKyv6wE2u4=;
        b=KGEqwqgWOH1l9hDKlXq8r54KBUTCvmqWXEyyuJCdLyCSyq0yDDiXwaGqy5XbwARN2G
         WYmTgQkFYk+VoyRxO8TrSU30Gf2EdKgyU6hwG/UufRBLMAJ5Y/CNIlgXU/45ypYDl4ad
         I9y7xs/TZhf2c+PuNf+7GvyV+ti/1dmExnN7OT7FDlUGTxVOnHcVuAUzaPE8+wHYCKDy
         9l5yF2SAkEJM9vOU/JMV0MJno6lsFTzIGSSwNXys2rqemmYulCOpUCdWBvBI7qdfBOs8
         rUOLivULMaKtGz5MtWpCGvihgTuy8v2gsvhYEKGmYLmeKeGeZAHvcRoqYa3k9gqLx+CF
         W6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VtFXrsX8w0w0nf24oPfhWOTgY39JrMcR9uKyv6wE2u4=;
        b=N0m+QcdLHbPdIpISBe4y8MmIY63K7q/u6oUKPcU8purYfc9bN4b22fEn6RJ9tl0N6L
         t5aRKn71czepc45Y6Pen9pbeuYUfzrDpIkOhvggzNWMoMaElusJhdqXYBn80FG34spmE
         HW0EJjtR5fvYZIJeBv8Won4/r8uqvP5A5J6SPdQxht8eK/3T2PWEocOgETDCvWwoQhh8
         qtIEf4wOLX3H2ZXikGz8rWvsH00bZYRRNVpqv8htCxx1xO4qSM+ydSaW6kz3ToVnf6f1
         GQxnFehE2qqTUKnMoyYa1TDwJbrPAHSrPCmdhMvbeAMTVbZITqup47CZyOd8Y8SPtBjs
         N+SQ==
X-Gm-Message-State: AOAM533XFapfUsjnZzhkXh9jYqAhpsAJxfteyJjpF2GSrTG7QVJJLstn
        zu8Ij/A+zwR97HgFKYpbV7hH8oIVT7H4NQ==
X-Google-Smtp-Source: ABdhPJynmMpcDyU4FEBZOVJAayjiYV2j6daSl8h9v6E/kElpAojuRaW/7p+UpjZ9dGPXVZGxjr5Syg==
X-Received: by 2002:a17:90b:124a:: with SMTP id gx10mr18655057pjb.214.1623037292916;
        Sun, 06 Jun 2021 20:41:32 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id p7sm7019372pfb.45.2021.06.06.20.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jun 2021 20:41:32 -0700 (PDT)
Subject: Re: [PATCH] m68k/q40: Replace q40ide with pata_falcon and falconide
To:     Finn Thain <fthain@linux-m68k.org>
References: <352239036981177050c296ca3deb84a102d9faa2.1622970906.git.fthain@linux-m68k.org>
 <e250cffb-9edd-1b84-3826-58079758b35a@gmail.com>
 <4a32d59-ebb-9dc-fec7-ad172547d9a3@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a665b3ff-1dec-48b6-d8b1-a9966e1c1bf0@gmail.com>
Date:   Mon, 7 Jun 2021 15:41:25 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <4a32d59-ebb-9dc-fec7-ad172547d9a3@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn

Am 07.06.2021 um 14:07 schrieb Finn Thain:
>> are there any substantial changes from what I'd tested before?
>
> The request_region() stuff is new, and I reworked the host->get_lock and
> host->release_lock changes. So you may want to review it again.

I'll do that (and test the old falconide driver with your patch - never 
got around to that, and I now remember there was something fishy in that 
driver in relation to registering the IDE interrupt that I need to 
re-check).

>
>> Your patch conflicts with (I think) the Mac IDE patches now in Geert's
>> tree, and I'd rather avoid hand-patching the lot if at all possible:
>>
>> m68k_q40_Replace_q40ide_with_pata_falcon_and_falconide
>> Applying: m68k/q40: Replace q40ide with pata_falcon and falconide
>> error: patch failed: arch/m68k/configs/multi_defconfig:351
>> error: arch/m68k/configs/multi_defconfig: patch does not apply
>> error: patch failed: drivers/ide/Kconfig:731
>> error: drivers/ide/Kconfig: patch does not apply
>> error: patch failed: drivers/ide/Makefile:29
>> error: drivers/ide/Makefile: patch does not apply
>>
>
> I should have sent these as a two-part series. Sorry about that.
> You'll need to apply this patch first:
> https://lore.kernel.org/linux-ide/3de9a93d-2f7-a650-1fa-c2129a4a765b@nippy.intranet/T/

Looks like that's commit e4ab3dc4eb88f53730061a3976c1e63523c5567d which 
fixed the conflict for me, thanks.


>
>> What's your baseline for this patch?
>>
>
> I've used v5.12 and v5.13-rc5, but mostly I develop on the mac68k branch
> in my github repository.
>
>> (In the alternative: just add my Tested-by if nothing changed aside from the
>> IO region reservation)
>>
>
> I have tested these patches in Aranym (including a multi-platform
> atari/q40 build which required your ISA fix) but I don't have any way to
> test the q40-only code.
>

Neither have I, but I'd like to verify that the falconide driver still 
works with SCSI after this patch (can't see from the diff what the 
ramifications are for locking and request_irq() ... as I said, I 
remember something odd about the IDE interrupt that I need to verify).

Cheers,

	Michael


