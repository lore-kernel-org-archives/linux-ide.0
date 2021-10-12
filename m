Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6485EC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6D760EDF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhJLGdL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:33:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhJLGdF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:33:05 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Md6V3-1n9muh3NHX-00aFVo; Tue, 12 Oct 2021 08:30:56 +0200
Date:   Tue, 12 Oct 2021 08:30:56 +0200
From:   Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v4] Fixes to DMA state check
Message-ID: <YWUroBxtouQtzP4M@reimardoeffinger.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
 <c3a7bdf2-caab-99e6-4da6-25638e3b3c24@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c3a7bdf2-caab-99e6-4da6-25638e3b3c24@opensource.wdc.com>
X-Provags-ID: V03:K1:uatWd8Yk5g6JbcKq5E3oY/DBelgO+IXggw+gPwAdLL8HfoXwlFe
 2Xf3ujAbTlt+PlkGaGkRqjFmC4OmB7C9zIS6YvA/eDn9KPG+dLxzrlvTeSbGLIH+YuJBcYf
 9v/pnJBHkOSq3JX+zCPOXpneKDw5LvuRhWJrVEOlSznvYK/aMWKm3FkYkq8luKfCDzMZjCJ
 Cr3hstw6Z/ymj0yNhUQCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1QJ58w2+G1A=:5ZZvXe9R/DpN6+TcThH45P
 LiHcfEbgW6YahRHAh5S9hNI9y7AfbopecZS4d6Dk2nAMDqpB9IBtxBqFpo+XqMCMFfxr0okKR
 rL4EE5BO3Fg6hn85d1N/uCBwuehA4HiVS0GB+k1eyaTJbw7eF9o0xSPZfsMCfjDdLc4teVKiz
 rzh6/LZNVkLYGtZdkQLS1SETe1gJYJG+Zvrd8KeyKGwX6twDL23s8VD/n3IwmY5b1PwUjM+MW
 nAsKySBsjjK41ntMZaqamGeTRlAkv8OC2+iX5gL/NKaD59F0oBygpR8XaNtbPe6DVUgGneeS7
 rYf2r62aI9eaSqkW14NyjkMz24yf0GNJm6aFBpZoGRIV3YQ0rAYfJUy26BtHhmlGBXPHguyQk
 WE+/yMKztZuw6SzrAp56sOOOopFP9lqWlIOSabfnL/Zl8HDt5jeS569SyvFUf9PUxihbbRD+a
 CXnFp6L63RJOBcHPVkig/B9UMwNm0QD24izyiS3RGcxIdum2JvHYdN5eV0DhdT96kUgxQ5e/6
 uqfCkw+9ll/V4XViF3ClMtk4q8XTpq1oxPZVE8OWsDBxoyysgY6tfNTsbC++SetF2fCiXCfh6
 /+I9Ww9sSi48Yce5U+qcgxwA057CvZy7Q+jWSXAQf79Q7Jl2ewx18JA/7AcH8y4634Emf4R1R
 xl9rxGgNaSG08bqwDw61heNgUmIRhc9COXLOBSy+6bUthM2TxgXsvW0qSN6ihi8EC83h+OS/1
 kXEbkfTRQbDbOHqaOze84wcQzBCBgz26Hnjr4YcaWayZTyZblBl6kdq0NqE=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 12, 2021 at 11:20:47AM +0900, Damien Le Moal wrote:
> This looks all good to me but I do not see any CC Stable tag. Do you
> want this backported to stable versions ?

Sent a new version with patch 1/6 (and only that) having the stable Cc, which I think
is what makes most sense.

Best regards,
Reimar
