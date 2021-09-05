Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF318C433EF
	for <linux-ide@archiver.kernel.org>; Sun,  5 Sep 2021 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D75D60F4A
	for <linux-ide@archiver.kernel.org>; Sun,  5 Sep 2021 10:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhIEKH5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Sep 2021 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhIEKH5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Sep 2021 06:07:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD6BC061575
        for <linux-ide@vger.kernel.org>; Sun,  5 Sep 2021 03:06:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e131so7433439ybb.7
        for <linux-ide@vger.kernel.org>; Sun, 05 Sep 2021 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=YeJ9Eaooklt7vTy/WMXPTND/t2TbYy3Uvw/DTk38Xp7arBHOiR33dredxnBDtmCMdr
         rttSfd4yGUQ98SvlfiolQMSzZy6l3pYxNWxFAKfVqPHv7JeQa4fioLduqDBTwYdX/gXV
         22sOIR/D3DTYzNe+mvAuA5LNTH2QhW7kwBsDxCjqxMH3ZkLSHyRaV7xuZK/bXj8opuc9
         po5+juC4ETo7dOwqEo6LUwEU5sLeD6JLmAXIvRxG8BxIcZ8m68rjFIpEAGrqrrcgxbJU
         /QrLbb1xBz0wdnkD9Gmi82/hSAi4E1qsK0pDy8IEFY7WoEsFykI+tRiQYrt9MCaPMu6o
         /7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=eq6nKGvgI+bWb7dA4wQT6nTwHr/a1prEZfEV3cmhWjgnqCVngTUp98HT9NOGnpx7JL
         6ubshJB4EF6WowYs57iZ/wtXHJRJRf7OlY+YCvyy/ngAPhZ+GWwoGlSatct8/OFsyyzh
         u2gGQqU+rVNfgGFRPP3zHheCyflDYVRzJpQ91qLtAFluiDVpwwXbyyCPq+0fWcs27mD8
         9vewck57HkOSeznnEXlQQNNYfDe0v4WiPepwkC3uvReqXai+W7Fz6c4Hxb+/z4i1VJbu
         jUpK/NOKXqsV3xR2NtkSg7D+yTr9q4mF5AG5fKWNYn0gHoM20QklsxOVrdPseRGAxj6R
         8sBg==
X-Gm-Message-State: AOAM533nWlu4YDZmI++kNy1QS3Aseszh4FeZVizpRo1YaTC2uZOogDRD
        1+xcDZWp+EWeRTH1dHVHxBhdU2jgDdygTwZ9Glh9u7yJprZgmA==
X-Google-Smtp-Source: ABdhPJyFhLd1SLLxftfkEzqzHU4LKtdt9Mb1u3jLD9fJv53B7Zc2s9zMLPlKScyO3BpzMYTkYccbFxMYvQxBh+to9lg=
X-Received: by 2002:a05:6902:150c:: with SMTP id q12mr6571718ybu.410.1630836413995;
 Sun, 05 Sep 2021 03:06:53 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 5 Sep 2021 18:06:44 +0800
Message-ID: <CAMEJMGE85rroXkXJ5wN0cQO66UkEzQ05kJmmHB4=mBuCcc96FA@mail.gmail.com>
Subject: Introduction: I am a Linux and open source software enthusiast
To:     linux-ide@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Subject: Introduction: I am a Linux and open source software enthusiast

Greetings from Singapore,

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 5
September 2021. My country is Singapore. Presently I am an IT
Consultant with a System Integrator (SI)/computer firm in Singapore. I
am also a Linux and open source software and information technology
enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

"Autobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)"

Links to my redundant blogs (Blogger and Wordpress) can be found in my
email signature below.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books are also available for download on my redundant blogs.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
