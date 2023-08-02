Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA38C00528
	for <linux-ide@archiver.kernel.org>; Wed,  2 Aug 2023 23:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHBXK3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Aug 2023 19:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjHBXK2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2023 19:10:28 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27611727
        for <linux-ide@vger.kernel.org>; Wed,  2 Aug 2023 16:10:27 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so329766276.0
        for <linux-ide@vger.kernel.org>; Wed, 02 Aug 2023 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691017827; x=1691622627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQIXxftjtN5hYuIFtfZK4F3tnuxmPXyFX58C9RfxzP8=;
        b=tSeOIxeH6SU2Dt/E6YFRhbJxTMGg0AH5ThevXtV7ObfzF7qGSnyVwCXxBVaBRzgDkt
         q/cOYGC64tVSKe/mvbPqf3mJqWwv4pwyE5p+Sn0rj3mG97BxgyCJA1ka2T/AH9M+6sI7
         bXudG0BZgyex4E2AHIXHydBdLk8ZfzGS2WMx7tDr2Fx0RZixv6TQEC/XROhRmxcZZmd+
         Bk9/xFWoMVZIrmPu+oV5kaSW9SfgK7pFpc/qAv+vUKtBA9NoErLwPYJgNPUGUzELUypQ
         EDMSw2c96ofyew/cbuROPLAR1NnxKqFU2EbxUJ2Vwz4PKjim9VF7gHCWE+w9GZw5s/DI
         2owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017827; x=1691622627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQIXxftjtN5hYuIFtfZK4F3tnuxmPXyFX58C9RfxzP8=;
        b=KnK8cA1fHBksBKVzESEa/EFIrrn+dkqI7xC73o6hrPN2Ow8DxWLrkaM0J2RR9qAcgg
         TgUTgRYFhr0ALH6X0+Gm+etQCUO3pLKrHMqhU7n6PVVtDSVqkIKaFymPhSYL3syq70O9
         TjljONAvFQJQNF700q0Z5jsVvlk8SBpuKIBTO9dPptGKfbtHdAAYwY9f3cD0rbqJlhKS
         8yQgi7Z/KDVsZzta9y5s0c9POvT8ZdRZitdeoowfs4/kkiML4fL5v+X8mAkMIET7+nC+
         acJDW5vuG1hbOY+UJnt86OXchH5tdTRcUMrcDT5d2mLYEMZIuDvEtiz+SOkEz/7Xn/PZ
         Q6TQ==
X-Gm-Message-State: ABy/qLajjEPTKwTlL2qsvak89w1bHcMq7waYCzoIuEcVjM6RvIAMozDN
        bfPRk7N05wrqSwBoxE3jO8QL6u+5IpqB3XdJ5CsO/24/jP61EX7W
X-Google-Smtp-Source: APBJJlHgXxYgfiDRJz5jzc1/H/rAKzy10DWuQNPaaUJ1Our7CcPeTXFc+zc3tjomS9p7AqjvibR+DbyenOZgO1DNdjE=
X-Received: by 2002:a25:d86:0:b0:cfd:1ea:888e with SMTP id 128-20020a250d86000000b00cfd01ea888emr15456033ybn.60.1691017826895;
 Wed, 02 Aug 2023 16:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de> <20230731091636.693193-11-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230731091636.693193-11-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Aug 2023 01:10:15 +0200
Message-ID: <CACRpkdZ8cPNbXz1d4tudTE2YqO27w4VtdyZM4QomaghbycLTkQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] ata/sata_gemini: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jul 31, 2023 at 11:16=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
