Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00CFC4332F
	for <linux-ide@archiver.kernel.org>; Wed,  9 Nov 2022 21:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKIVkg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKIVke (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2022 16:40:34 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9C2F65A
        for <linux-ide@vger.kernel.org>; Wed,  9 Nov 2022 13:40:30 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=dkvfIaBJ+yTCvmxulYpse2Wa6B74IOd6m8Sl2ig57wc=;
        b=ExwfznzdRdBq4HPPxZt8KFpqUlntfPPYXhP7gCXvzJzeYMcG7oX/8msNHoW9ScBeL4917MahoRqHr00IW7rNqNSoAzeX4NC2JaF9sR+dJul3lG3xtox2UE2IzRgpYS56lCB7papCzcQZi3t44AbsqAkg7DXVM29R9HVt3Jek/EztR6PewQo3Oh/nbmWKp+bk0v/A2xlGuo2xJd5a5KgxQJUSfzvuWw/2mOM69u5AeiCOfmVbntR3hT9To+
        Msh83Uo8ZNo92i4BEgU15agIglNGJ2m0D+FYGEIaSK+CdPkIkU/H7q8CtnC4d94IotMnuT2tMEx1heIAk69wzFGfiC4A==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204]) by mx1.wiredblade.com
 with ESMTPA ; Wed, 9 Nov 2022 19:55:50 +0000
MIME-Version: 1.0
Date:   Wed, 09 Nov 2022 19:55:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
References: <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com> <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph> <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
X-Originating-IP: 86.122.18.201
X-hMailServer-Reason-Score: 0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

November 8, 2022 8:27 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> So the adapter & driver are OK for regular ATA devices but they may not
> like port-multiplier devices, or one of its flavor. See:
> https://en.wikipedia.org/wiki/Port_multiplier for a nice summary. PM
> comes with either command-based switching or FIS-based switching. The
> adapter may not support the flavor that your PM box uses, while the
> sata-mv adapter does.
>=20
>=20Try to check the router SATA adapter specs and your PM box spec and s=
ee
> what PM flavor they support. If that matches, then this is likely a
> driver issue. If they do not match, then nothing we can do. You will no=
t
> be able to use that PM box with your router.
>=20
>=20--
> Damien Le Moal
> Western Digital Research

There is a lot of info in Marvell Armada 38x Functional Specifications ma=
nual, but I don't
understand it. "FIS" is mentioned.
See https://ulli-kroll.de/Downloads/NAS326/A38x-Functional-Spec-PU0A.pdf =
, page 241.

From my kernel log:
ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum=
 part sxs
From kernel sources ahci.h:
pmp means "port multiplier"
fbs means "FIS based switching"

Areca didn't write information so detailed in the manual, but it does say=
 it supports NCQ,
so according to Wikipedia article you indicated, it probably isn't comman=
d-based switching.
Is there any way to get this info from the working router (sata-mv)? Or i=
f I connect it to a desktop PC?

Marius Dinu

