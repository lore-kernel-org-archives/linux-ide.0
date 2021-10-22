Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D06C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 22 Oct 2021 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1324610CB
	for <linux-ide@archiver.kernel.org>; Fri, 22 Oct 2021 09:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJVJUy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhJVJUx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Oct 2021 05:20:53 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D64CC061764;
        Fri, 22 Oct 2021 02:18:36 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so3672065otk.3;
        Fri, 22 Oct 2021 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AItOCyIoiykaIgn2iwMrFE8Ojtlnz+oni5ac/ci7TH8=;
        b=naB9shmIGfxChEWyKJdR+YqE2pr/zTqeW7xDYvj7MEZMdwiJgV7VFWBejCEjLQjfnu
         jtqwy2CB8U76e4k9Qp7PsEsnpfiYx0Aama7lHOCPMFamcG9jwglx5WQirF4h7KHpWYnt
         kqi77571o+n+A7DoViHj05Wpw4EjxGip5UcA3fWcYKnAX7CL+n5GJKDNWKM+T/Gm5Q3J
         78FiLQjkx+iEFzfMPUjCW9daOk6MGcNJyRtn4ZHKbG0sKMQQ9MaLldnX1xcAgjFKqZGG
         kl0sDOfoB4/RbxyG1UvK3nNUK/nRJDLbfifJOiMxxKmpkinYl+p8h5wb0h3nXl/2Gcsc
         76DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AItOCyIoiykaIgn2iwMrFE8Ojtlnz+oni5ac/ci7TH8=;
        b=77NvpVG9I6cfGKZzUFacAAQdh3cB8lFOZUWCbEJwuREKgWJhc+Mwt/aDcCZgDFi5xe
         PR0ERnVbSi9yi5S6ezpXtsUUqd/e6JO+zAxZ/lhndAr5C3tkcgU5sMKVcwgTxv70c4b+
         aNG37Yecj6YojghB4bYWDfXBKGTy6RzKzvhdg4I9kP+1sXFVSv8iBAMzane6/nwitmop
         QaV9jUXmX6EVhzMzCfHe6mSFh8PkTfBw2SQSWMkaZ5Cvc2qoVYJBHlogcxXWua/BBB7b
         tiMiDMAZs0uH0jquMalBruI++M1fJ1w7vZnoKUWTnRGI8IrarN0N6+PlXU4IFLuYImgh
         986w==
X-Gm-Message-State: AOAM532EtnGtf+dzLnia678hOtq3uuTetjNyNtjwG9lUKWMrUErFRXgc
        YuxHjhquxxVsHngUOsmn2j1XZi6muJ2lmZUUpOsTrkG5Cg==
X-Google-Smtp-Source: ABdhPJzaMAiErlz/AbEXpOcAi05R5YZQYIsHDiaS4RAP8UdZTZeNHVFrei4RabKl3HyS/Q52tRHnXmQFFmzB08fu5tw=
X-Received: by 2002:a05:6830:23ac:: with SMTP id m12mr9637598ots.166.1634894315790;
 Fri, 22 Oct 2021 02:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <1634795836-1803-1-git-send-email-zheyuma97@gmail.com>
 <e1f96f77-cf44-7783-bf88-0814bbabbfbc@omp.ru> <1d5064f6-0498-c78c-d98f-df7ca74e0a8d@opensource.wdc.com>
 <CAMhUBjnFebrick3dt4CtYPANU69Uy0vPagZd-PEo+mFg6BTGEA@mail.gmail.com> <e10d2ea8-859d-7e5a-e132-411dec748df9@opensource.wdc.com>
In-Reply-To: <e10d2ea8-859d-7e5a-e132-411dec748df9@opensource.wdc.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 22 Oct 2021 17:18:24 +0800
Message-ID: <CAMhUBjkX-eSzQRcNFaypb6NbY9HuLSDZCjewBHbe1fk89M3-BA@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_mv: Fix the return value of the probe function
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Oct 22, 2021 at 9:41 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2021/10/21 20:23, Zheyu Ma wrote:
> > On Thu, Oct 21, 2021 at 6:38 PM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 2021/10/21 17:37, Sergey Shtylyov wrote:
> >>> On 21.10.2021 8:57, Zheyu Ma wrote:
> >>>
> >>>> mv_init_host() propagates the value returned by mv_chip_id() which in turn
> >>>> gets propagated by mv_pci_init_one() and hits local_pci_probe().
> >>>>
> >>>> During the process of driver probing, the probe function should return < 0
> >>>> for failure, otherwise, the kernel will treat value > 0 as success.
> >>>>
> >>>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> >>>> ---
> >>>>   drivers/ata/sata_mv.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> >>>> index 9d86203e1e7a..7461fe078dd1 100644
> >>>> --- a/drivers/ata/sata_mv.c
> >>>> +++ b/drivers/ata/sata_mv.c
> >>>> @@ -3897,7 +3897,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
> >>>>
> >>>>      default:
> >>>>              dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
> >>>> -            return 1;
> >>>> +            return -ENODEV;
> >>>
> >>>     Doesn't -EINVAL fit better here?
> >>
> >> If the error message is correct and this can only happen if there is a bug
> >> somewhere, I do not think the error code really matters much. The dev_err()
> >> should probably be changed to dev_alert() or even dev_crit() for this case.
> >>
> >
> > I don't think so, the error code does matter. If mv_chip_id() returns
> > 1 which eventually causes the probe function to return 1, then the
> > kernel will assume that the driver and the hardware match successfully
> > (even if that is not the case), which will cause the following error
> > if modprobe is called to remove the driver.
> >
> > [   21.944486] general protection fault, probably for non-canonical
> > address 0xdffffc000000001b: 0000 [#1] PREEMPT SMP KASAN PTI
> > [   21.945317] KASAN: null-ptr-deref in range
> > [0x00000000000000d8-0x00000000000000df]
> > [   21.954442] Call Trace:
> > [   21.954624]  ? scsi_remove_host+0x32/0x660
> > [   21.954923]  ? lockdep_hardirqs_on+0x7e/0x110
> > [   21.955240]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> > [   21.955634]  ? mutex_lock_io_nested+0x60/0x60
> > [   21.956027]  ? _raw_spin_unlock_irqrestore+0x41/0x60
> > [   21.956395]  ? async_synchronize_cookie_domain+0x35f/0x4a0
> > [   21.956802]  ? async_synchronize_full_domain+0x20/0x20
> > [   21.957179]  ? lock_release+0x63f/0x8f0
> > [   21.957468]  mutex_lock_nested+0x1b/0x30
> > [   21.957761]  scsi_remove_host+0x32/0x660
> > [   21.958054]  ata_host_detach+0x75d/0x830
> > [   21.958349]  ata_pci_remove_one+0x3b/0x40
> > [   21.958649]  pci_device_remove+0xa9/0x250
> > [   21.958949]  ? pci_device_probe+0x7d0/0x7d0
> > [   21.959261]  device_release_driver_internal+0x4f7/0x7a0
> > [   21.959647]  driver_detach+0x1e8/0x2c0
> > [   21.959929]  bus_remove_driver+0x134/0x290
> > [   21.960234]  ? sysfs_remove_groups+0x97/0xb0
> > [   21.960552]  driver_unregister+0x77/0xa0
> > [   21.960859]  pci_unregister_driver+0x2c/0x1c0
> > [   21.961178]  cleanup_module+0x15/0x28 [sata_mv]
>
> How do you trigger this ? A bad device tree or something like that ?

Pretty much, I was testing on qemu and used fault injection to force
the my_chip_id() to fail, even though this rarely happens.

Regards,
Zheyu Ma
