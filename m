Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FBC433EF
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 20:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbiCSUdf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Mar 2022 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiCSUde (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Mar 2022 16:33:34 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E6A1446
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647721919;
        bh=WwtK8FTthbmqVWo8mIcsOBi/2IoqeTYOOLnPf4DkrbU=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ebFXi9sUDx/txeRg33HawmkMZEPHxVMKdZtd7PL5EjisIvXnBzWu3EVnIbgMsXGcX
         DNmOc4Le0eHbazHsfDXVe5uiBjaR89bhadFk15Pz/JBiGeawNU0vhGAXZioDTCgX6z
         Swhcjvizbp1k9t29tOPcX2vfYAWAcwJC65HYOJps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from smtpclient.apple ([98.128.181.196]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1nq6VV0DdG-00oFQ9; Sat, 19
 Mar 2022 21:31:59 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
From:   =?utf-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
In-Reply-To: <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
Date:   Sat, 19 Mar 2022 21:31:56 +0100
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <771F724E-8E00-4CFA-A39E-91EEFADE132E@gmx.de>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
 <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Provags-ID: V03:K1:kR7mUgUyfnBFt08WVcbLIb/B3wC33UlasZ3n1qJxRMRPhDrZSu+
 EBQU2JhY3LFORfuJ/vaMF6I31Z7sNDQ9diZOilLQp6t1uc8HS6K3ibY9nqGWlopxj6t4yJC
 xQJ+E8FbJEKdsc4PWCy/TlKdIlbpFNJKVYzMscrhJZ8jtMriT7Uxv1zdCwnyoVpeqK6Evr3
 V95A8UL7BZsGJOrX2qoww==
X-UI-Out-Filterresults: junk:10;V03:K0:Gwtas/Q7WTM=:eH4WrUERhCiCOHQImC85BGq2
 SlLo78pPZB99/vyO9rTBn0GBkP6wL9hS4HTUFzMGXiQ13ZvKL8MzEfUjP2n8G05KteXSb3rFW
 36gsGdwQGr0SltbWK6Wq2iz+vU4Mkh0YMC3NHj/3XZEJVo0rOctKpvzQ42IsBM+jk/OeGpr1k
 TpPbObv9y+yq0gW6y8JJ+qSLOa81KsMQNf0qiH+YK+x+874q7puCvXGUpfPBVOeZ4rHaBof8D
 3Ho1izi0mYfX+La8qhCPbz+oFn1lCS8tZbc8YAUGF7funHf78pjoCCHx1iD9M41KbsMrFV62W
 2JFWEq5lL6Prb+D6CiCHFf/QYH42BA4/pXdurY5sG1rJelrdZM8qB/2I7nFI0JJSovDHpxgIS
 u36KbO8H08WbETkYAhx+TDMtMh7V/dvyJ3oQizYMeI4yYPjusjV8FcBmjdeqxd2yXrWFPpePr
 6/o+lo9mmdhTL2WAQnve/RdTDaSeZXIwv4uUtZE9cIRGin512NdoFh8OqPrzoFfNRAryh9p7T
 z5JE3PMNMzY1CttwuAyeQTgksJT90KyLTLxyELxM+ODvkHbCR5+b3VWjljTj2A8rMm9fUM17F
 jRX08FOO+8fxKyjJOsNC1HOaiwflAupCagnPdTXVcyUZb+0dEiiQ3FxGjzCmpDkb9ga0tsfXY
 HcecClNCtQ5aFnTdYhUolIgt7mdxAbV3P9F36/sXThH6yrzlGi0VQBFbNLvORjuRWSfuy3oMp
 VbhUah0ii38MDdRdu1z/cjOx0+YC1pv9K9Xn9O2W0fYA7FlnRgOTqJMZ4YQAh7bkQXgq9gjix
 LYbScfznIHq7nVBjJVr1/8xfHF5w7kmJrM8dPPK6N7s8uxq+5XBOrhMD4QQk1/AjIlwtBRCm4
 hwExLcxGC/azBhclqbnIydYlqKspLq7yXQOX0ljZmI9aRwk32Kq12R3l4CdebiWVR6sCKFdOe
 wCigbX3Ovw/GhpHeZBgeZEi0EdMP6u3epjwC8Pix+qt84zrnpHMW9Km5yrwuiKPY6WTRP9BZM
 p7gK3/6eQ3UKRRVmDDM1v6MwK34b1AOF6JJjTgEWMKd6Hwu80KlQej0IhbEbxM57fCpjeQsQX
 e4indMcYD8h6NFmyt9sezr1EA0R+656A49+EHcRM3kSsWvKMVAblNaw==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



> On 19 Mar 2022, at 21:11, Christian Lamparter <chunkeey@gmail.com> =
wrote:
>=20
> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.

I don't see any info on which kernel this happened with anywhere.
Because there was a bug that tried to use READ LOG DMA EXT even though =
DMA was not enabled.
That was fixed by a patch from me for 5.16 (and backports).
The behaviour you describe matches the possible symptoms of that bug.
So it would be good to know we're not blaming the drive for an already =
fixed bug in the kernel...
(I am still seeing some issues that READ LOG EXT - the non-DMA version - =
times out with interrupt lost for some device/controller combinations, =
but at least that "only" adds an extra 15 seconds to the boot. It's =
still a bit silly because in combination with e.g. IDE controllers READ =
LOG provides absolutely no useful functionality as far as I can tell).

Best regards,
Reimar=
