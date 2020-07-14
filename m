Return-Path: <SRS0=ghXF=AZ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737C7C433E2
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 07:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA7F204EC
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 07:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hdBHGgcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgGNHdA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:33:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39474 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNHc7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2020 03:32:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200714073257euoutp0122ba8fc3c353174ff72e4a4468a4c839~hjhgtm5jG2314723147euoutp01Q
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2020 07:32:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200714073257euoutp0122ba8fc3c353174ff72e4a4468a4c839~hjhgtm5jG2314723147euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594711977;
        bh=iw0HeiMRpihqbVCSNrmwScv7BrswpTC0PE3gJ25M4go=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hdBHGgcXcu7jb4Wd204Xe+ZFxIwLbr1u7/lX9MJOSUnRQGsdM1hfiJBGnVvYLI0Zo
         f+Iv4Yl0/PAJUoQRbSOoMTG/5/QmQIOqpOxgADG+5NOPeMmXKldgh3pwDbXUqrE0fJ
         cT7CycX997widcuVptxXk0sJJtLxwfIBDY5wLFdY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200714073257eucas1p21ef036b4a814be1f9b5147dac7013aa1~hjhgX_8AK1514215142eucas1p2E;
        Tue, 14 Jul 2020 07:32:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.8A.05997.9AF5D0F5; Tue, 14
        Jul 2020 08:32:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed~hjhgFvVYd2093720937eucas1p1m;
        Tue, 14 Jul 2020 07:32:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200714073256eusmtrp220c20a2722452484e6af4300f87aa0c8~hjhgFDwRJ2064020640eusmtrp2I;
        Tue, 14 Jul 2020 07:32:56 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-01-5f0d5fa9f24a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.FC.06314.8AF5D0F5; Tue, 14
        Jul 2020 08:32:56 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200714073256eusmtip2ff5b743b8bba026dd992b40f53351ec0~hjhfnSMES1117911179eusmtip2q;
        Tue, 14 Jul 2020 07:32:56 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] drivers: ide: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3b26bfff-7a42-7bbe-2050-51fe1ce96d4e@samsung.com>
Date:   Tue, 14 Jul 2020 09:32:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7or43njDa62cVgsacqwaLx/kdFi
        zvkWFotXZ9ayWRzb8YjJouvxCxaLy7vmsFnsnb6M1WLHnU4miyV73rM6cHlsWXmTyWPnrLvs
        Hgs2lXpsO3SNxWPTqk42j/1z17B7/P4xmdHj8ya5AI4oLpuU1JzMstQifbsEroxbR9tYCw5K
        VFyZ+pq5gbFFqIuRk0NCwERi6qV5jF2MXBxCAisYJT5dWsYC4XxhlOh59hEq85lR4u+Wy+ww
        Ld1zrjJDJJYzStx52QBV9ZZR4ujmKWBVwgJuEmfW/WEBsUUEdCQuHZ3FBGIzC+xjkti01BXE
        ZhOwkpjYvooRxOYVsJPYv/AHWC+LgKrE353HmEFsUYEIiU8PDrNC1AhKnJz5BGwmp4CtxNS5
        x9ggZopL3HoyH2q+vMT2t3PArpMQeMQu8WXHUiaIs10kOreeYIawhSVeHd8C9Y6MxP+dIM0g
        DeuA/ux4AdW9nVFi+eR/bBBV1hJ3zv0CsjmAVmhKrN+lDxF2lNhx5CILSFhCgE/ixltBiCP4
        JCZtm84MEeaV6GiDBraaxIZlG9hg1nbtXMk8gVFpFpLXZiF5ZxaSd2Yh7F3AyLKKUTy1tDg3
        PbXYKC+1XK84Mbe4NC9dLzk/dxMjMH2d/nf8yw7GXX+SDjEKcDAq8fBK+PPEC7EmlhVX5h5i
        lOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYO
        TqkGxllGK1T+t02snX+kTVgs3f33Lp7wt0uOHLtVsuCebuSixV5dy+6bfl3+69ddo/4JK4Us
        qpLtPA+uNZ+wI8l4jnQ335sfIdnhVUFNyZ4T4l1cQ93TpeTWfQwWibVMvTPr+tk7UzlPNU0u
        viLP/Kj3ibxqW0L2teLlhjo2oV0/1zdufFPmnP5FSomlOCPRUIu5qDgRAPKpCiJbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7or4nnjDY6tNLFY0pRh0Xj/IqPF
        nPMtLBavzqxlszi24xGTRdfjFywWl3fNYbPYO30Zq8WOO51MFkv2vGd14PLYsvImk8fOWXfZ
        PRZsKvXYdugai8emVZ1sHvvnrmH3+P1jMqPH501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehm3jraxFhyUqLgy9TVzA2OLUBcjJ4eEgIlE
        95yrzF2MXBxCAksZJa4dbmHsYuQASshIHF9fBlEjLPHnWhcbRM1rRonje18zgSSEBdwkzqz7
        wwJiiwjoSFw6OosJpIhZYB+TxPmFj8ASQgI2Ejs27QJrYBOwkpjYvooRxOYVsJPYv/AHO4jN
        IqAq8XfnMWYQW1QgQuLwjllQNYISJ2c+AZvDKWArMXXuMTYQm1lAXeLPvEvMELa4xK0n85kg
        bHmJ7W/nME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBa
        tx37uXkH46WNwYcYBTgYlXh4Jfx54oVYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sa
        k1p8iNEU6LmJzFKiyfnARJJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaP
        iYNTqoHRwnDzPIbH5vtKFALM2F6vctJa0XDI4u172SebLok+7vfXUdc+P8dibYCgqLXTlb8v
        J3zT+lXgrHQ05d0qn3IHzVjurnbP/yE76/knHdGqn/btqkGJRefMDZNEw6pcEp0/8T7j+uRd
        7rKSKXf/l545/dUXNX3/10w01a3Y/b+CaelDuYsLyjqVWIozEg21mIuKEwGKiYcV7AIAAA==
X-CMS-MailID: 20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed
References: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
        <CGME20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Hi,

On 7/13/20 7:36 PM, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to remove legacy power management callbacks
> from ide drivers.
> 
> The suspend() and resume() callbacks operations are still invoking
> pci_save/restore_state(), pci_set_power_state(), pci_enable/disable_state(),
> etc. and handling the power management themselves, which is not recommended.
> 
> The conversion requires the removal of the those function calls and change the
> callback definition accordingly and make use of dev_pm_ops structure.

IDE subsystem (drivers/ide/) is deprecated and has been superseded by libata
subsystem (drivers/ata/).

libata drivers have the same issue so please concentrate on fixing them
first. Later (if desirable) changes can be back-ported to drivers/ide/.

> All patches are compile-tested only.

This patchset needs (at least) some basic testing. It should be easier with
libata subsystem as it also support SATA controllers and devices.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> v3:
>     - Modpost error for undefined reference by Kbuild in v1.
>     - Another approach to disable PM in drivers/ide/triflex.c suggested by
>       Bjorn Helgaas in v2.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> Vaibhav Gupta (3):
>   ide: use generic power management
>   ide: sc1200: use generic power management
>   ide: delkin_cb: use generic power management
> 
>  drivers/ide/aec62xx.c         |  3 +--
>  drivers/ide/alim15x3.c        |  3 +--
>  drivers/ide/amd74xx.c         |  3 +--
>  drivers/ide/atiixp.c          |  3 +--
>  drivers/ide/cmd64x.c          |  3 +--
>  drivers/ide/cs5520.c          |  3 +--
>  drivers/ide/cs5530.c          |  3 +--
>  drivers/ide/cs5535.c          |  3 +--
>  drivers/ide/cs5536.c          |  3 +--
>  drivers/ide/cy82c693.c        |  3 +--
>  drivers/ide/delkin_cb.c       | 32 +++++---------------------
>  drivers/ide/hpt366.c          |  3 +--
>  drivers/ide/ide-pci-generic.c |  3 +--
>  drivers/ide/it8172.c          |  3 +--
>  drivers/ide/it8213.c          |  3 +--
>  drivers/ide/it821x.c          |  3 +--
>  drivers/ide/jmicron.c         |  3 +--
>  drivers/ide/ns87415.c         |  3 +--
>  drivers/ide/opti621.c         |  3 +--
>  drivers/ide/pdc202xx_new.c    |  3 +--
>  drivers/ide/pdc202xx_old.c    |  3 +--
>  drivers/ide/piix.c            |  3 +--
>  drivers/ide/sc1200.c          | 43 ++++++++++++-----------------------
>  drivers/ide/serverworks.c     |  3 +--
>  drivers/ide/setup-pci.c       | 29 +++++------------------
>  drivers/ide/siimage.c         |  3 +--
>  drivers/ide/sis5513.c         |  3 +--
>  drivers/ide/sl82c105.c        |  3 +--
>  drivers/ide/slc90e66.c        |  3 +--
>  drivers/ide/triflex.c         | 24 +++++++------------
>  drivers/ide/via82cxxx.c       |  3 +--
>  include/linux/ide.h           |  8 +------
>  32 files changed, 62 insertions(+), 155 deletions(-)
> 

