Return-Path: <SRS0=b2kW=2V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E81C3F68F
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8239B206E4
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcEknz0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLaR4h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:56:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45150 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfLaR4g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Dec 2019 12:56:36 -0500
Received: by mail-vs1-f66.google.com with SMTP id b4so22587800vsa.12
        for <linux-ide@vger.kernel.org>; Tue, 31 Dec 2019 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLpAEzOviLlSpzsuupiIxoP5cKE2eMBcdFuHtjuJtX0=;
        b=qcEknz0FyNVy/qBvaT+RYvY/itzWo50HMGa6KVDvlM0lGlwCml/E1s2tvdUIV8on1S
         +QTOj1BqZJm4G1jT3sSI40SeaXi2Sith27Z7I2kY0cOFXxRV1WhHIkQ4n0uhwWMnnjxH
         cZ9xvXwItFxuXxg7I0/KvqO1X2o1gG6YxUh5tMAv6iTNdfKfpik+4x8tlaNTHsVXM32I
         4Zv72HcaMvNmX935yAGhVX/iv44F49r3HSQLosv1AQjSp6rkNcw/PvSc49xhR/eTGYwa
         3lMOxGtwlxuipdwoC1Ock/okzLuDjVIP8b2AX7H9Bg2/8b4SNQCtuRmqwT1pTOXliayk
         a3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLpAEzOviLlSpzsuupiIxoP5cKE2eMBcdFuHtjuJtX0=;
        b=NUXUvBwE6Tijxo7RPKTzbxjMnhArIB/HRbaqQc3x35a1xWjpdCaTXusDhPl1s9uiUR
         A4sjVceaFw8xegsjwNEbTlZxuYSybREyOzCHurRLhlX6DTgnmfDxICNzCFacxnRSPdHE
         +YyjqCV0vqXYOGjyGb0EUwS2zMbmj9gu7cWwm/436cjPHCSh9suBRIrvXL+16KMhwX6v
         vZD1dKipc1PMG7o5lYmaJw6h9sAap/zswhuAjiMfnuBP3yv1JH1AYvKdZVmBVxe6z91Z
         30f/ZENmJugra8kfHpac7NjeFoEtNA8U6XhGzJUIcb6vKJlnqcZj2b4w2bCpMdp2CPo6
         Zu+w==
X-Gm-Message-State: APjAAAV2UpvffsOklcilghKdoDmlnCOorKHIPjgQqd+4r+Sb1+N4rCfC
        1kGMa5sMurXBdFVF69Fcnq6UH6NDZXFWa4oMrPqfqw==
X-Google-Smtp-Source: APXvYqx5VkakzqFLoXgQq86E7x9FUeLOTTbSSGdmhj9jd4igW8yErWuj941u8gYgz+qodMoQZfTINEQQHDC/P2wh8uQ=
X-Received: by 2002:a67:af11:: with SMTP id v17mr17254848vsl.99.1577814995527;
 Tue, 31 Dec 2019 09:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20191231172458.25984-1-linus.walleij@linaro.org> <41b527ba-003d-425b-5e59-43cdd8c778e2@cogentembedded.com>
In-Reply-To: <41b527ba-003d-425b-5e59-43cdd8c778e2@cogentembedded.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Dec 2019 18:56:24 +0100
Message-ID: <CACRpkdbR3TTiNqU8g54M4N4=N8yiV2UreFKoV0LffYUxZEChJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Create DT bindings for [PS]ATA controllers
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Dec 31, 2019 at 6:46 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 12/31/2019 08:24 PM, Linus Walleij wrote:

> > +properties:
> > +  $nodename:
> > +    pattern: "^[ps]ata-controller(@.*)?$"
>
>    I thought the DT spec has long ago standardized the node name as "ide" and "sata"?

I'm not 100% sure (Rob can answer) but I have *half-guessed* that the process
so far has been that when we define a schema for some generic node name
we also invent some new generic node name like this, or else all the old DTS
files people have will generate (lots of) errors.

The DTS files can then opt in to the schema by simply renaming its nodes
in accordance: "ide" -> "pata-controller", "sata" -> "sata-controller"
(I have such a patch for the Gemini that I made this for.)

If I'm wrong I'll switch to to ide@ and sata@.

Rob?

Yours,
Linus Walleij
