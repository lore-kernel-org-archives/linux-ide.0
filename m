Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710AC4332F
	for <linux-ide@archiver.kernel.org>; Wed, 12 Oct 2022 13:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJLNXV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLNXU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2022 09:23:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C01EC42
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 06:23:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 3so14937035pfw.4
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kfkmia/jqZwQdeGS8wLSXmOwhOMDvGdXtvyxLeApG4=;
        b=BF1pX5W2hyF2CvwT6HtZQtjk5nk2uJx+THMqQt94MRd3OOySSJ6J5HlvYnoXJdiXq5
         3YiEHbQZJ7z6clW1kBw+DyPJFKLRE+5BZ4CidFySxmD5yh95kbOHePuY3PvliQA9kOL8
         pOzK4BGFv+NixgeqLE+0lZc17Snv/Dg03oROdlSJKd9+gX+echQe93YEwBkkMaS7Xlsz
         3zSir6U7+wtOTdGjEJsyb22VQisfh6Dgn7w+QuU16v2cvhCQqq/gH17qtfCFq7Dmch5i
         b1mxLk9vK1rnH0F3JKSSpUgV02ATcu7741/LVrZLVVeGzhBLiMEMt5j0tstYnec2Wd22
         dNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kfkmia/jqZwQdeGS8wLSXmOwhOMDvGdXtvyxLeApG4=;
        b=cxgYR2IwTpLvsMIp9xYlph9qMluMN8aTMqacltjk0saK/jchID/UQ02RAkrZwHlY1G
         lNFeg/isuoC3f0ssSiKUuyq3a4A8NUaLU0HWQ6Zu2RwQSq1si4N4fP01RaMBboqqDhRa
         JFQKAaC7x5RoI867WJqKEXZHt+AjVRaSzbSxnodisfgy3FOx9P743gsWdbJHd8AEGTZ4
         43tPvKZTkLpRkqgnFQvtfDi72CEJYMgz0+qn+QtrtvyCUv5E7huREMtK+f+6O8Xnd27U
         LYeSMbTfHws7UNZ+7vqbSUls7OoAg7oWK9P3DGVSQtFHpmIIhyW73t+DDmTFv03Wiymv
         a0BA==
X-Gm-Message-State: ACrzQf02Q92WZOIXFTnHXSjpsFk59Gf3jnX3r8jXT/C7mMVr/cuU5aOs
        1PGp36B1S9xS9QSP8LbBo1qHorVXN4uu/j3zlug=
X-Google-Smtp-Source: AMsMyM5uUD45N30rY0KbhOGAeLoZI0TJkqgYu0npEhAScDzZBIgrRPI7/RIWjta0cMpyJSjyzIrqLrgRW2+qwvVRItY=
X-Received: by 2002:a62:144b:0:b0:562:38de:9a0e with SMTP id
 72-20020a62144b000000b0056238de9a0emr30740711pfu.78.1665580999097; Wed, 12
 Oct 2022 06:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 Oct 2022 10:23:04 -0300
Message-ID: <CAOMZO5DzFtuVxuAhmtsBx+EoxXgeg6nHDeJiLULsY8wRdpXbEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Alexander,

On Wed, Oct 12, 2022 at 10:11 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> 'ahci:' is an invalid prefix, preventing the module from autoloading.
> Fix this by using the 'platform:' prefix and DRV_NAME.

What about adding a Fixes tag?

Reviewed-by: Fabio Estevam <festevam@gmail.com>
