Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAE8C433E9
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF7964E21
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSJsj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSJsU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 05:48:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC143C06174A
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 02:48:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j17so4641520qvo.13
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jM7KolOnmfMiMpEa3RvK4p03gUv0bKZTtKNvEnJtAzM=;
        b=q38zESths2FsdJ3afZSfV8L0p5nU1k5KAuc4cW3vs3PLxl83Ad4ylRpwu8N6JnfCbB
         3nYKFCtiBw71rYw7Y22q77ROYFFDnYo+eM4ojcpGWlCx4+lKeuRbY3dUlucpH7HaHmw6
         2TnSyEZ7V/DuOaeesjhS55XkMloxGeP5SmzOeCDyNwX3yAZ1H6GRS0RP6yrrDtCHPKKm
         R7DvUSsaFc5vawrd9drkoeTgB8WWa4ygNlTNhpjeFDtFjpOR6+0CXrOI/d/RBj8rgCPO
         WdsRmJafHRkPtu1cQma7o0VtisYHIQpUKLd/XCKLEWQvANINRg8zW39h3wdWTda3IxVX
         0pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jM7KolOnmfMiMpEa3RvK4p03gUv0bKZTtKNvEnJtAzM=;
        b=eHmKNugsaCLLlvv+j74BmY4i3O1SoW0lYNuUrG9QGho/eF30wI0kHWIhrMeniKsIBD
         B/cS762cV6goL4NF2i76nl1R9tUJYUspyddbGhhaZkPR2H41n6ImkY6QAsiE0YagkROM
         Hl96+6Zrw1HBafvs3ONsEkw3g6mrBXtpHFhYM9ntP6veorGR+YA+wl5oLUdPED/tPtbW
         tfCIgx790/G9uzNX6KYrQ8eze92Pw3NKPY76E+KOorARBUioNrMgMI+u0OPOYWwACBkP
         2SiDTlEYtPnpwWu8OqFyrOKJArDthjOqQzWVZ1lU6PKLbAqUMyhUWwXkWpkO+fhkz9JY
         jakQ==
X-Gm-Message-State: AOAM533f84pXAUzIq+rSxtG1IEaBiDoSotpId0eKOAUFFM5RJKV/SVW9
        tKJQi13jQa1VzOK2zQRY4GrLJGuseqPJ9BRezk1etA==
X-Google-Smtp-Source: ABdhPJwpCQeWz6zLTqfp7U+99AkXuvB17w/tDhkkDOOrgIEsR0Jsma4izVeipsqgAmBiLkxtB3ORx7Aux3TFR89NH5I=
X-Received: by 2002:a05:6214:20a7:: with SMTP id 7mr8543940qvd.24.1616147299019;
 Fri, 19 Mar 2021 02:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20210227105723.7i42cw376qmnozcp@SvensMacBookAir-2.local> <CAPv3WKfH_-ydZ4GXW8UUNuvWyT7xAXjPOLGVxt+X2svXt=PYdg@mail.gmail.com>
 <87czvviok9.fsf@BL-laptop> <CAPv3WKfiuV5h2m=579-3UajwBFtHB2MP5tdSvzxTZo+0MPnZNA@mail.gmail.com>
 <87wnu3h4hw.wl-maz@kernel.org>
In-Reply-To: <87wnu3h4hw.wl-maz@kernel.org>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 19 Mar 2021 10:48:08 +0100
Message-ID: <CAPv3WKdfywQpBx0HpeBTAZ2G5U+jFVQ6We8J_WeK7sYgWNiuJg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Armada8k enable per-port SATA interrupts and drop
 a hack in the IRQ subsystem
To:     Marc Zyngier <maz@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>, axboe@kernel.dk,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-ide@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Marc,

pt., 19 mar 2021 o 10:33 Marc Zyngier <maz@kernel.org> napisa=C5=82(a):
>
> On Fri, 19 Mar 2021 08:08:34 +0000,
> Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > HI Gregory,
> >
> > pt., 19 mar 2021 o 08:35 Gregory CLEMENT <gregory.clement@bootlin.com>
> > napisa=C5=82(a):
> > >
> > > Hello Marcin,
> > >
> > > > [Resend in plain text]
> > > >
> > > > Hi,
> > > >
> > > > Just letting everyone know - merging only the DT part of this patch=
set
> > > > broke AHCI on all Marvell Armada 7k8k / CN913x platforms in v5.11
> > > > release.
> > >
> > > It's unfortunate that we didn't know this when v5.11-rc1 was
> > > released. However it is still time for a fix, I will submit it.
> > > As I explained in the other email when I applied this I really though
> > > that the driver part will be applied, I don't know what happened here=
.
> > >
> >
> > Sure, looking at the thread it looks more of a communication issue. I
> > am also surprised the breakage went unnoticed for a while (unless
> > everyone is using edk2, like myself :) ). I think it would be good to
> > revert the change on top of v5.11.x. The drivers adoption would have to
> > land before v5.12 though, so that not to repeat the problem during next=
 release.
> >
> > Small rant:
> > A general issue with the DT binding changes of this kind (previously
> > clocks, ICU, etc.) that I have, is a side effect of incompatibility
> > with older kernels/other OSs. The latter must follow the
> > modifications, but you can forget of booting e.g. Debian Buster with
> > the ToT device tree. Therefore in edk2 I do not update the device tree
> > fork to often and need to tweak it in order to have the widest support
> > coverage.
>
> Unfortunately, this has been the case for this machine since it became
> available. I can happily boot any kernel on other systems of the same
> vintage without touching anything firmware related, which is crucial
> to identify regressions.
>
> The A8k requires instead a per-kernel DT, something that only works if
> you treat it as an embedded system, and not a standard system (which
> is why mine has been collecting dust for some time now). I don't think
> the maintainers have ever been interested in solving this problem.
>
> As for ACPI, that'd probably be the best thing that can happen to this
> platform. Not sure that's remotely possible though, given how
> "interesting" the HW is.

ACPI has been up and running for this platform for a couple of years
now, on MacchiatoBin you get USB, SATA, network ports, PCIE and even
SD/MMC (the latter was merged in v5.11 kernel).

Best regards,
Marcin

>
> --
> Without deviation from the norm, progress is not possible.
