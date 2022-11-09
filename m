Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59BC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  9 Nov 2022 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKIVe1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiKIVeX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2022 16:34:23 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A648133
        for <linux-ide@vger.kernel.org>; Wed,  9 Nov 2022 13:34:19 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=rbyymVDq3X++k0sD7yA4gqidZ5ccch1Im3+5qUb+4Vk=;
        b=wis8zgHe+OCTn6/Z4VJUQmGcMQP6MLLcVc1EI1rk1d9lyoZ7fAnLKldVVZwsqgz2huu+m5H5M+OsYVu6SlRqZUxXajyGejHtCa60XOF9OZYvwMHpBMN5kjm8Wv/gsXEgLNp1FPRfdjXDGnNVj6oNx3YG7HNvgr3sHIBEVsIgXQPZAOCWgMd2kYpzFxmsa0LGMoa7IqCeWIPKL418S4YaQAXS5iSreRoc7pXbRdGOqJjn9Tm2OdYBN0qBmw
        MtPzHORqsxKCRLtjHr3DfcU0/ahMz310WENOcbMmcN2f5N8YcGS8aOOeV/m7+QGHO2MriZmINLK6yTZ0P5djQQjN3jBg==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204]) by mx1.wiredblade.com
 with ESMTPA ; Wed, 9 Nov 2022 19:52:54 +0000
MIME-Version: 1.0
Date:   Wed, 09 Nov 2022 19:52:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <36c79924907752ddd40802d83c797f11@psihoexpert.ro>
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
From https://ata.wiki.kernel.org/index.php/SATA_hardware_features
pmp means "port multiplier"
fbs means "FIS based switching"

Areca didn't write information so detailed in the manual, but it does say=
 it supports NCQ,
so according to Wikipedia article you indicated, it probably isn't comman=
d-based switching.
Is there any way to get this info from the working router (sata-mv)? Or i=
f I connect it to a desktop PC?

Marius Dinu

