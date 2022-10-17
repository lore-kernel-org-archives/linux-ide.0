Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A10DC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 10:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJQKjk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Oct 2022 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJQKji (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2022 06:39:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF3606AC
        for <linux-ide@vger.kernel.org>; Mon, 17 Oct 2022 03:39:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so23912584eja.6
        for <linux-ide@vger.kernel.org>; Mon, 17 Oct 2022 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2pejdSxXfahdo5G1u0XN8YEn+WW6JR72L3GUVlnUp4=;
        b=DeiSoeNCGFLgUjefTOAoi+SwwL2J3Ry6c16PC85KU0owPwNdACVaQAWZ3sNb1/VWj8
         MDrg8h1ID09g435vVaKj3m63KpgritPKmDp4VqH0oX8nEydta4/UAWof/CvSZyCYyUGA
         k6HREC6Zyn6dk4FKQc+Xk5935+Q3TspuPljsbcsUcpe3xqOReZALt2hqqpqOUTtpqv1i
         NQicPBtYklEP2ckIisb22A+H/0hRrjo0AR65yVEMEn3x0Ko74Vmoj6g/J3HOu4jXHaIO
         yYPdS1R+imkty3ENUmk+3bpPRYsnjOy85waFmNZ4ksl9+fJ0/hNFIp2gSATXLlMInVoX
         2aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2pejdSxXfahdo5G1u0XN8YEn+WW6JR72L3GUVlnUp4=;
        b=fbBotdqhJ9IHM00sD0C1P8AIi390QeWh5gIoTQdcUcC6kXGnxkdMkzhIy+/UDlMSmt
         BE38GOm2sAqQFhea7sZicTUs9KrqrCEdlhMmxGE2PFWLKL9olamoN05ML85At0Ocb/Ze
         orxJVpgBEB4NEsJmzabHHAduu4e1aI4chTHOMkgQ5jrney/95kjoZhIt12fqJ3AvZRIW
         Y1RUoKkJDqG1ZMCeybZ8/vURoBu3jYuPvm8vfZ2cbyEjuiTJX6V3P8WGngY/YhXQPqg2
         Itx1IaQYJBxQhfn7V/Sx2zaXXRVfAItA4WLuMSOv/8/m6Hys7Tsxp14vPaxx1ud0tgqU
         Rz4w==
X-Gm-Message-State: ACrzQf0AUGoeO/0yw/p2UR9pb0ZHoE9JMh5sgxluz29KN8mDud9d2Xxb
        M0szsaEpu+XmAS4hDZh0/TUPQ1tz06GuJ4QPjCQVNfbgWZ0=
X-Google-Smtp-Source: AMsMyM7tsoyttqtJsvVkr1TjfCDXXw7tQmhcUzddNRhV9tdq8AZ0GuifXKs9dY2YEF+pUZJbxY0qq6qy18XeG2bKul0=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr7673013ejc.690.1666003157136; Mon, 17
 Oct 2022 03:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 12:39:05 +0200
Message-ID: <CACRpkdYcR1Cb5JjpcuuShgr7JgBJ6zM8qgkOUrJYa-byRQ=oYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Cleanup build dependencies
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Oct 17, 2022 at 8:26 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:

> Cleanup build dependencies on CONFIG_OF for the pata_ftide010 and
> sata_gemini drivers.
>
> Damien Le Moal (2):
>   ata: sata_gemini: Remove dependency on OF for compile tests
>   ata: pata_ftide010: Remove build dependency on OF

Excellent, thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
