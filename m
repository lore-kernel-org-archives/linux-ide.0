Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05E6C47094
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 06:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41E5613CA
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 06:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJG3J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:29:09 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36610 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJG3J (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 02:29:09 -0400
Received: by mail-wm1-f43.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so5272296wmq.1;
        Wed, 09 Jun 2021 23:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YrivazYwkr91Xd/9+WFVv/iP2qA8QwOcCFwtvnhPSIM=;
        b=NCwzIZfpPwXIlXu6flWD/EM27Vwp1YAV6K0fyywFmmsMceE90hPRC9UBrd1aL18KYv
         uDxcV9/k7kSWpDB7s6N2m+RjQ1ECeltGX4+OWI3U72Y3PvGXQfTsGfQenDZ859sqo+MH
         7f8TNNzJSh5h29KxeZAo/eSZCmFKQv+iMJdOH1oi0+ntq+Bm7isRzH4R+uUP69G0K6L4
         wZYG5CYN2KRzaTdeYcPj9mSg0CZflzGbPJm7LSaFOeVV0Q44uhDJ0/Flta7jlVLWjGRD
         8dZt4d2pQwGSsWPF+4tpTmZnIgLu6w3Q7+GuhiBGRqTIl8YAmGu8teDVukYj7SV9Kb0i
         wGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YrivazYwkr91Xd/9+WFVv/iP2qA8QwOcCFwtvnhPSIM=;
        b=HmO8HdnvETuSUpwxlaSEK2rLVxgsLrI1/SbkdTM8yKoFu1y4Y9AQruTSjA+knvG9mj
         s8z4OY0nCT1WjQD09a+V9dsxAb+qsElUAcZNxZQTLHbZ11AnsHD7z6zXE2UJeTdG7xPI
         dnJIffbv20GWfkGTOnXRGwv8KaS2gv4lYS68qdHYeXGhNV4mSZr82EEhZKlHP28BfYUI
         sDIlcaVojwwoD2lfYqrLAv7qcIoC7JAOUQJIKMT5+idfBVasR9UwD0AbeWYVVnk7auEj
         NzlApUYTsx9JO7DZ16U62GtFvVgM9twTuLIC/qMYyW9Mkw4WtJ38VJXxRJEQ7kPxK4hp
         aUqw==
X-Gm-Message-State: AOAM531/ds+j2KAgFHdXX5bDuOkdw+lm2hrCVmM9C8dmnWI/YiRc8Spo
        xotQkAuH4DU2DZ8EHUufTcS8aoApajs=
X-Google-Smtp-Source: ABdhPJzIxfi8yEfk+pXW0scEHANgddg+SkoYG17mAJHDsaPNZD4npmxfJmbvjx/zzVkAJiT5uE3Ndw==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr3372482wmg.45.1623306356709;
        Wed, 09 Jun 2021 23:25:56 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id b15sm2096986wru.64.2021.06.09.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:25:56 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:25:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linux-ide@vger.kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org
Subject: ide: ali14xx: intent to convert driver
Message-ID: <YMGwciP+Sm9y+u5r@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello

I just booted my 486 with Linux add see:
[    2.118009] Uniform Multi-Platform E-IDE driver
[    2.124262] legacy IDE will be removed in 2021, please switch to libata
[    2.124262] Report any missing HW support to linux-ide@vger.kernel.org
[    2.395244] hda: ST31720A, ATA DISK drive
[    3.550069] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.555100] ide1 at 0x170-0x177,0x376 on irq 15
[    3.559085] ide-gd driver 1.18
[    3.562115] hda: max request size: 128KiB
[    3.564174] hda: 3329424 sectors (1704 MB), CHS=3303/16/63
[    3.565513] hda: cache flushes not supported
[    3.623033]  hda: hda1

So I plan to convert ali14xx to libata.

Do you know some ""recent"" ide->libata conversion from which I can learn something ?

Regards
