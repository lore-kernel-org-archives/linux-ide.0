Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C8C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 22 Apr 2022 01:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443163AbiDVBxg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443166AbiDVBx3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 21:53:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69D49F2E;
        Thu, 21 Apr 2022 18:50:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j8so7602263pll.11;
        Thu, 21 Apr 2022 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd8Ly/ph96mf7X+NwD7zXOhWISN9bw3fhFaRCxJaylQ=;
        b=HTZlNHA565L8PrjjxafmaWmKu+60zBekwv5Opg3E/3vK3bmjIJzYkj7lH5eAzNPGag
         wT5OCcvw/sBCWuD/hXMBIF+wUJptxgFmmtTyVmQl1JCjFyHxwl81as/Wprsx5nHk2ooB
         J5IUvlN7B/6ZN07MKmgG020GpXb5n8qjvoWtXEV6FW7DDvLimd/xEAjKXTZPdPcIVHHd
         vO72aUGa9xMUWFGLRM3gQkuGaQhxn0TcDOawisOcr7VfCJmwQWErvMNBLWMjhjTtvyx8
         AEyZxaHDwrxP67VgZoEdJd0zg5MZjzpGsD847SqqSbdTGIGW987ajt4jborHvHDzuRgh
         Q5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd8Ly/ph96mf7X+NwD7zXOhWISN9bw3fhFaRCxJaylQ=;
        b=wRMMvez97W+Lvm/7OMgKkQR+LLwsfI8TvTjpvjjiu843P+TkV2URQM4kbQBkgX7W+5
         DbB1bybGasmsEPpSCDd0wazMgf8Xd7wJ+NTvbAU1lSis6fkIbxDx4J7WebCBBIPgPmIT
         cCEYLSCGdlCLrQ38PrNkaUdnCnC/x5yjENxh0gyVOjmBGJpXTqflxPqqdGjgJOduY9r5
         o77YbM+UqoL58TSw61hLfSCe8zNZIm3A2T4pJs5KHBHiC+CErT7Kq/h+nxjUsH+p25Rq
         gAtofUbP4k0rhpFVF2vpcNVuEgP9r39AKDUJdPfuun8mer7vNbbQmZC0kUlr1xG06Kw1
         uPgg==
X-Gm-Message-State: AOAM532gkqL86K5IidB2xBt+G26b86iPsQWzu9730wh9mng/ViT3nfGA
        E8lMvUTTeCDvfOkg9Q2QSJ2DAw2MRynAS+c40ZCsB2SJfuov
X-Google-Smtp-Source: ABdhPJzF3tIp3t1iNv1N5Y22Vt5A02uJXxBsiS/K7ujVI90PiOgqsLnKojL1UDMWDPhr1qwQfJkoKgKB8bvtxP4JtJY=
X-Received: by 2002:a17:90b:1807:b0:1d5:540d:4b6a with SMTP id
 lw7-20020a17090b180700b001d5540d4b6amr2654482pjb.240.1650592236018; Thu, 21
 Apr 2022 18:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220421013920.3503034-1-zheyuma97@gmail.com> <e29fd64e-62ea-746e-f0fb-02ce86b4e61e@opensource.wdc.com>
In-Reply-To: <e29fd64e-62ea-746e-f0fb-02ce86b4e61e@opensource.wdc.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 22 Apr 2022 09:50:24 +0800
Message-ID: <CAMhUBj=fpQi1uvkSQg7vuefLOsxxEgM5fTfsNu1w2sWmvybO0Q@mail.gmail.com>
Subject: Re: [PATCH v2] ata: pata_marvell: Check the 'bmdma_addr' beforing reading
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Apr 22, 2022 at 7:48 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 4/21/22 10:39, Zheyu Ma wrote:
> > Before detecting the cable type on the dma bar, the driver should check
> > whether the 'bmdma_addr' is zero, which means the adapter does not
> > support DMA, otherwise we will get the following error:
> >
> > [    5.146634] Bad IO access at port 0x1 (return inb(port))
> > [    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
> > [    5.150856] RIP: 0010:ioread8+0x4a/0x60
> > [    5.160238] Call Trace:
> > [    5.160470]  <TASK>
> > [    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
> > [    5.161728]  ata_eh_recover+0x3520/0x6cc0
> > [    5.168075]  ata_do_eh+0x49/0x3c0
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---Changes in v2:
> >      - Delete the useless 'else'
>
> Note for future contributions: The change log should be placed *after*
> the "---" that comes before the "diff" line below. Otherwise, the change
> log pollutes the commit message.

Thank you for the reminder, I'll pay attention to this problem next time!

Zheyu Ma
