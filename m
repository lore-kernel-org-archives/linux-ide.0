Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9920E8181D
	for <linux-ide@archiver.kernel.org>; Tue, 26 Sep 2023 04:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjIZEz3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 26 Sep 2023 00:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIZEz2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 26 Sep 2023 00:55:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478DB8
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 21:55:21 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D1DA3F67B
        for <linux-ide@vger.kernel.org>; Tue, 26 Sep 2023 04:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695704120;
        bh=TG8Rt/d1azM9gj2JLuofNR1IVRAB55K8pMnEf0yZiig=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=okkUPeVHVBF2YstyMU5/zcA5HlYzr8quDixXylCDkmdBsBsRvIwrTb/7SxwWnv/Ga
         gzUuKKZ/szyqiiN1GByIbAGcixv/gIclkwcdp5kRvHzFIl1ZT+ucl+APNK8iXRSXYo
         ZcsWgiSdX2tmqjlDPcyM8IDjLT/FgoaHYRq5eknHYpWszhzpxS/AsA5cXG5/E+Ta4P
         lieQniK7An5l++NOcGVNoc+HQnRPebXdfxioVLNXWarp9iurb/n7Q1wYuLawsgWCpP
         NCxLgq4qqKNDo8cP4xF6YKnKh/w863118T9V/ipsvAlUsi/IzgUR5FvyN6XKCvJlWG
         BFjabcxHIptOw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27733adfb12so5940242a91.1
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 21:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695704118; x=1696308918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG8Rt/d1azM9gj2JLuofNR1IVRAB55K8pMnEf0yZiig=;
        b=CqSvxyRFUE0evgvwMu919i+E+V8h158o4fzIvaE4HM3Dv9hnRn74xz/lKedM2x2c0H
         JwKWlz1+BjzdXaeGrkKv/eiAXQYiwcmc1JFdDPg5QKa1petJhoUBRec5uDKXJOaBSNif
         RXDjYX/mPTlek+BiLnQl/J8BQU222H6qX5rYE0qpyAZ6S9/Dp6FxB3K04t5FNa1WDdPW
         Sc68WMQIcQwlr3y7j83PtadJ09Jn/NrBZWd/8WQcY+R+56bEtEVC/M1x3BKdZrQ5KjZG
         dAKx/znQzPVubB2UDkH8Fzhs8zJpv0mZ8zAAO5ee+4Kj/B1rn27TgggZmkIYvCmzUJ6J
         JYLA==
X-Gm-Message-State: AOJu0Yxe1eZTNRg7WolbAceQH528pidHoMEhmu60Tr5fqNbfDoqaFyNL
        iW306ZvawQBPKvL77dzlPlGSE5GF/Ku3HX65GlPkeOHbf+kpLsl/NNBctXlZCG9VBAUNgAOdZMK
        uOXdKaPtkfy9s/ZP9h6KDV4uOChxTnB1+YNIm5PMmxQ2YqHujWyEuE0WwuGtrbQ==
X-Received: by 2002:a17:90a:c70f:b0:276:78f2:5d31 with SMTP id o15-20020a17090ac70f00b0027678f25d31mr2311862pjt.21.1695704117784;
        Mon, 25 Sep 2023 21:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHlRiODAX6m21kiNVY8pm8nbHRyh8sG/5R5u50qKgeoRNs40ptqZjxvjX0JQAtYWXuJu+p/ZFbMA2HHxfcCEo=
X-Received: by 2002:a17:90a:c70f:b0:276:78f2:5d31 with SMTP id
 o15-20020a17090ac70f00b0027678f25d31mr2311845pjt.21.1695704117402; Mon, 25
 Sep 2023 21:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
 <e58ddf0f-3b7e-9599-dd7d-c6ed322d1184@kernel.org> <20230925091339.GM3208943@black.fi.intel.com>
 <385141b8-4d02-cecb-7393-7375f095198f@kernel.org>
In-Reply-To: <385141b8-4d02-cecb-7393-7375f095198f@kernel.org>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 26 Sep 2023 12:55:05 +0800
Message-ID: <CAJB-X+UdB-+O8O97hCRQNbFpU7CuNisVCQkaJZ4JD01qZ-JqJA@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Sep 25, 2023 at 5:27=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 2023/09/25 11:13, Mika Westerberg wrote:
> > Hi,
> >
> > On Mon, Sep 25, 2023 at 11:09:01AM +0200, Damien Le Moal wrote:
> >> On 2023/09/25 10:05, Mika Westerberg wrote:
> >>> Intel Alder Lake-P AHCI controller needs to be added to the mobile
> >>> chipsets list in order to have link power management enabled. Without
> >>> this the CPU cannot enter lower power C-states making idle power
> >>> consumption high.
> >>>
> >>> Cc: Koba Ko <koba.ko@canonical.com>
> >>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>
> >> Looks OK, but given that there is a tendency of the low power stuff to=
 be buggy,
> >> was this well tested ?
> >
> > Yes it was tested (Koba Cc'd can confirm this). We also confirmed from
> > Intel AHCI folks that the ADL (and RPL) AHCI controllers fully support
> > this configuration.

I verified on an ADL platform with odd and disk devices and
they work fine.

> >
> >> Also, does this need a Fixes/CC stable tag ? If not, I
> >> will queue this for 6.7.
> >
> > Up to you :) Typically PCI ID additions can go to stable as well. No
> > fixes tag needed, though (there is no commit that this one fixes).
>
> OK. I will not add a CC stable for now. If requested, we can trivially ba=
ckport
> this later.
>
> >
> > Thanks!
>
> --
> Damien Le Moal
> Western Digital Research
>
