Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D40C05027
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 07:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjBAHb5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 02:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBAHb5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 02:31:57 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E237F1C
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 23:31:54 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=SifLluWqNSeYeJP+aybZDkIgKkScRE1iHq7I68qxBUQ=;
        b=xhzG7BygDQLuaxrMXGX/s0YYUeSs+2mv0JYTLy1Wqk15jBms29Q2mMsh7w7J50jWi8rb50gpfbQ2iNmdGixwl+VubiKpec6Nj9lmq+FeHn/aQayBGMadEm1MkvubRTZiNP8XxbRODUJSYU8VSAhn8G8ysArzZu2KgOC9NM371dZ8MV6KoEL78JjVnmtF8bifb1596rKYw5Lt4wkJqzXy8Y70Gc4QYAwX4EI9kn+SEROHpHvpuM95s2AGGR
        mIMYoNuZZCPrDwQ1SCBYQLtWe4yjk0grlID3nYL+2XH9Z8U/arEHMj0OopZO6y+m8V9G59VsGS6eY82fzLiGasMvmtGA==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Wed, 1 Feb 2023 07:01:18 +0000
MIME-Version: 1.0
Date:   Wed, 01 Feb 2023 07:01:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <2ae3974cc9739bfc4da9076e48beb25a@psihoexpert.ro>
Subject: Re: [PATCH v2] ata: libata: Fix sata_down_spd_limit() when no
 link speed is reported
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     "David Milburn" <dmilburn@redhat.com>
In-Reply-To: <20230130122427.113156-1-damien.lemoal@opensource.wdc.com>
References: <20230130122427.113156-1-damien.lemoal@opensource.wdc.com>
X-Originating-IP: 188.24.142.89
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 30, 2023 2:24 PM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> Commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
> driver has not recorded sstatus speed") changed the behavior of
> sata_down_spd_limit() to return doing nothing if a drive does not repor=
t
> a current link speed, to avoid reducing the link speed to the lowest 1.=
5
> Gbps speed.
>=20
>=20However, the change assumed that a speed was recorded before probing
> (e.g. before a suspend/resume) and set in link->sata_spd. This causes
> problems with adapters/drives combination failing to establish a link
> speed during probe autonegotiation. One example reported of this proble=
m
> is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
> fails, leaving no recorded link speed and no reported current link
> speed. Probe retries also fail as no action is taken by sata_set_spd()
> after each retry.
>=20
>=20Fix this by returning early in sata_down_spd_limit() only if we do ha=
ve
> a recorded link speed, that is, if link->sata_spd is not 0. With this
> fix, a failed probe not leading to a recorded link speed is retried at
> the lower 1.5 Gbps speed, with the link speed potentially increased
> later on the second revalidate of the device if the device reports
> that it supports higher link speeds.
>=20
>=20Reported-by: Marius Dinu <marius@psihoexpert.ro>
> Fixes: 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if driv=
er has not recorded sstatus
> speed")
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>=20
>=20Changes from v1:
> * Fixed commit message typos
>=20
>=20drivers/ata/libata-core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..2ea572628b1c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u3=
2 spd_limit)
> */
> if (spd > 1)
> mask &=3D (1 << (spd - 1)) - 1;
> - else
> + else if (link->sata_spd)
> return -EINVAL;
>=20
>=20/* were we already at the bottom? */
> --
> 2.39.1

Tested-by: Marius Dinu <marius@psihoexpert.ro>

