Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF20EB64DD
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jul 2023 19:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjGYTrm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGYTrl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 15:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1C2690
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 12:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B57B61867
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 19:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34B7C433C7
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690314453;
        bh=dCmw5R4jbcBnSUQT943aoHu0RKeRdl4L+YnQ81EWh3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=af9HOnCZSNJgR+8IKRjXAi3sI00gYTkVwP5t/BphEa6AKvrlfu/7/NGg/0mrLqnmu
         TWbUEDFNlGHf+IJq/BryIaM0QKMQafsddxXdD2WhvKSUtM+qPxG79ZHMLl3jMVx008
         WUA1sJzymO99jMJat2chFUP7h8CXog2ImS+0saTunSkMfxk4OjGpo7O9/IZxI8fvkh
         PJh7E/inimSBBpx8vublKMtFv/PYXbrs8o7nddee0WXCtGkbr5yttF6kKxERC2z+qP
         PqP/Gzdy/wtXi3bE9Ip2S3cMTPwT8aLSXNzrU41QLAoEEF65x7fincCbnxGggNWoyl
         26Tm2XYiNlq8Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so87934481fa.2
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2023 12:47:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLbFdmrKWwPV4lv2z/Klf6/UiqIiSNxfrFlKva23Ka6jBu1k7g7s
        Ej+aZh5gbkJFG796u7x8dVy74jHNkk/egyhazQ==
X-Google-Smtp-Source: APBJJlF1dP4K3JEHjiD3bAOs2QkJPoUDAE3mkGwl3QR/+jp7MrDnHqUUhPbj/rKsiHBk5dwzvrCbgbmqqHir0jdSa0g=
X-Received: by 2002:a2e:9b18:0:b0:2b4:737c:e316 with SMTP id
 u24-20020a2e9b18000000b002b4737ce316mr9501986lji.14.1690314451937; Tue, 25
 Jul 2023 12:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230725122809.521331-1-yangyingliang@huawei.com>
In-Reply-To: <20230725122809.521331-1-yangyingliang@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Jul 2023 13:47:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKAv00GgDoirsOpvMdMF_BWkrm6ha+oSSbDj55mZT0dFA@mail.gmail.com>
Message-ID: <CAL_JsqKAv00GgDoirsOpvMdMF_BWkrm6ha+oSSbDj55mZT0dFA@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_octeon_cf: fix error return code in octeon_cf_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-ide@vger.kernel.org, s.shtylyov@omp.ru, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jul 25, 2023 at 6:30=E2=80=AFAM Yang Yingliang <yangyingliang@huawe=
i.com> wrote:
>
> The 'rv' will be set to 0 after calling of_property_read_reg(),
> return correct error code in the error path.
>
> Fixes: d0b2461678b1 ("ata: Use of_property_read_reg() to parse "reg"")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ata/pata_octeon_cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ugg, I did a good job on this one. Thanks for fixing.

Reviewed-by: Rob Herring <robh@kernel.org>
