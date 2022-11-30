Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564F6C4321E
	for <linux-ide@archiver.kernel.org>; Wed, 30 Nov 2022 09:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiK3JlS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiK3JlA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2022 04:41:00 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742B2DDD
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2022 01:40:50 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3b48b139b46so165129227b3.12
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2022 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQat4vhVRPhTXaZs0nu09wTFQazHaXBzXg5iczgp6mA=;
        b=ofFQSuVu5ajzpYIwE9gi63qtctlx+tugjpXcFVn+OQ8mO6YwPj9HI58bKcWk7zumYv
         XNR0qwORgC9sVXJ8gS14hgXIuQX8R3T8Ty3x79W5OrEDVZXE/Hw+0SqKfo/DDFINBgOl
         uSSNAS9yprw0w9JhW/8PqKPmaRAxXg02jlaX60YgdzWMsybxxa9YLHCOHapdm6JrJ0n7
         R2fRFhtzZp2vpSnTTFTSz9SS30ly920A3drIJqME4jrl3Ys6ImIlW3q5wiJ7BYc2yL9d
         +MuoEm8iDljhVIhZfrXBl+DYv7dp+gMoh3EmxUyvWA10PS7G1W0JdqeZUgkSTEtWRH0Q
         Vktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQat4vhVRPhTXaZs0nu09wTFQazHaXBzXg5iczgp6mA=;
        b=cjZOAVd5bP5jT3bp36owFmDKLTTN0YY9Ij7NUvyj/N6Fbv9nUAXg1ZbT4sdBS/m6lf
         wkz6PU5mxsLArpc3on26Yr3MNcDG66AYgzUkV2abTolOcF4+iup6tGIer6U9yzjl6T0H
         QWpewXsdmuL6B8HIFXw/QqFFB49X8VGWtb9zex2QyyV9DVsiN+KFPZ3zuHT7uZOjFvLh
         imv4s2wzgyiltEwl5Ue3TTj4UG0xY6PSylZqAbCDBgzgVUL9i8on32mCQX4UQvnYvBd1
         NAvixmQdNv475DI3soUrzOYpBwVH6wKzl4fFlXHvSF1uX0ACO/GG0GO64Sw7A7RgTGPB
         W9aQ==
X-Gm-Message-State: ANoB5plFgIbbULfbwTCMNF6zjUd9SAKjZbZn0VjK1IO0bn7vRJbHr+fT
        s2vJD6eACJhvY7IltO/c1QfpdCCCzuQeQzQBlDMhyw==
X-Google-Smtp-Source: AA0mqf6KMymJRYnHxHiIkx2KBXzxnTi84c6jLxC5Bl8eM1MzMjI5A7O9pao3Le/GrwP90CJWMmj8xmmzuINsuhzPysc=
X-Received: by 2002:a0d:cbcb:0:b0:3c5:469e:b93 with SMTP id
 n194-20020a0dcbcb000000b003c5469e0b93mr15813361ywd.443.1669801249762; Wed, 30
 Nov 2022 01:40:49 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com> <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com> <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com> <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation> <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
In-Reply-To: <20221017155246.zxal2cfehjgaajcu@mobilestation>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Nov 2022 15:10:37 +0530
Message-ID: <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
To:     Serge Semin <fancer.lancer@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Carlos Hernandez <ceh@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 17 Oct 2022 at 21:22, Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Mon, Oct 17, 2022 at 09:43:24AM +0200, Anders Roxell wrote:
> > On Fri, 14 Oct 2022 at 16:06, Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > On Fri, Oct 14, 2022 at 11:22:38AM +0200, Anders Roxell wrote:
> > > > On Fri, 14 Oct 2022 at 09:53, Damien Le Moal
> > > > <damien.lemoal@opensource.wdc.com> wrote:
> > > > >
> > > > > On 10/14/22 16:31, Arnd Bergmann wrote:
> > > > > > On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> > > > > >> On 10/14/22 07:07, Anders Roxell wrote:
> > > > > >> [...]
> > > > > >>>> 8)
> > > > > >>>>> If reverting these patches restores the eSATA port on this board, then you need
> > > > > >>>>> to fix the defconfig for that board.
> > > > > >>>>
> > > > > >>>> OTOH,
> > > > > >>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> > > > > >>>> device failed to boot.
> > > > > >>>
> > > > > >>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> > > > > >>
> > > > > >> As mentioned in my previous reply to Naresh, this is a new driver added in
> > > > > >> 6.1. Your board was working before so this should not be the driver needed
> > > > > >> for it.
> > > > > >>
> > > > > >>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> > > > > >>> controller support")
> > > > > >>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> > > > > >>> successful.
> > > > > >>
> > > > > >> Which is very strange... There is only one hunk in that commit that could
> > > > > >> be considered suspicious:
> > > > > >>
> > > > > >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > > > > >> index 9b56490ecbc3..8f5572a9f8f1 100644
> > > > > >> --- a/drivers/ata/ahci_platform.c
> > > > > >> +++ b/drivers/ata/ahci_platform.c
> > > > > >> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > > > > >>  static const struct of_device_id ahci_of_match[] = {
> > > > > >>         { .compatible = "generic-ahci", },
> > > > > >>         /* Keep the following compatibles for device tree compatibility */
> > > > > >> -       { .compatible = "snps,spear-ahci", },
> > > > > >>         { .compatible = "ibm,476gtr-ahci", },
> > > > > >> -       { .compatible = "snps,dwc-ahci", },
> > > > > >>         { .compatible = "hisilicon,hisi-ahci", },
> > > > > >>         { .compatible = "cavium,octeon-7130-ahci", },
> > > > > >>         { /* sentinel */ }
> > > > > >>
> > > > > >> Is your board using one of these compatible string ?
> > > > > >
> > > > > > The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> > > > > > with the new driver if that is loaded, but it's possible that the
> > > > > > driver does not work on all versions of the dwc-ahci hardware.
> > > > > >
> > > > > > Anders, can you provide the boot log from a boot with the new driver
> > > > > > built in? There should be some messages from dwc-ahci about finding
> > > > > > the device, but then not ultimately working.
> > > > > >
> > > > > > Depending on which way it goes wrong, the safest fallback for 6.1 is
> > > > > > probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> > > > > > strings back into the old driver, and leave the new one only for
> > > > > > the "baikal,bt1-ahci" implementation of it, until it has been
> > > > > > successfully verified on TI am5/dra7, spear13xx and exynos.
> > > > >
> > > > > OK. So a fix patch until further tests/debug is completed would be this:
> > > > >
> > > > > diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> > > > > index 8fb66860db31..7a0cbab00843 100644
> > > > > --- a/drivers/ata/ahci_dwc.c
> > > > > +++ b/drivers/ata/ahci_dwc.c
> > > > > @@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
> > > > >  };
> > > > >
> > > > >  static const struct of_device_id ahci_dwc_of_match[] = {
> > > > > -       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
> > > > > -       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
> > > > >         { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
> > > > >         {},
> > > > >  };
> > > > > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > > > > index 8f5572a9f8f1..9b56490ecbc3 100644
> > > > > --- a/drivers/ata/ahci_platform.c
> > > > > +++ b/drivers/ata/ahci_platform.c
> > > > > @@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > > > >  static const struct of_device_id ahci_of_match[] = {
> > > > >         { .compatible = "generic-ahci", },
> > > > >         /* Keep the following compatibles for device tree compatibility */
> > > > > +       { .compatible = "snps,spear-ahci", },
> > > > >         { .compatible = "ibm,476gtr-ahci", },
> > > > > +       { .compatible = "snps,dwc-ahci", },
> > > > >         { .compatible = "hisilicon,hisi-ahci", },
> > > > >         { .compatible = "cavium,octeon-7130-ahci", },
> > > > >         { /* sentinel */ }


FYI,

We have been noticing this problem [a] & [b] on Linux mainline master 6.1.0-rc7

    Test error: mkfs.ext4
/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
exit

Please suggest a way forward on this reported issue on arm32 TI BeagleBoard X15
device. Build and Kernel configs details provided in the metadata section.

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: b7b275e60bcd5f89771e865a8239325f86d9927d
  git_describe: v6.1-rc7
  kernel_version: 6.1.0-rc7
  kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/706371149
  artifact-location: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW
  toolchain: gcc-10

[a] https://lkft.validation.linaro.org/scheduler/job/5892099
[b] https://lore.kernel.org/all/20221017155246.zxal2cfehjgaajcu@mobilestation/

- Naresh
