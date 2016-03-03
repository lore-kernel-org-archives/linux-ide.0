From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ata: sata_rcar: Use ARCH_RENESAS
Date: Thu, 3 Mar 2016 09:30:59 +0100
Message-ID: <CAMuHMdVV2UVDDRNi0KLNoDNuT+QCk3eXM2UDHj-p1+5SkusjPw@mail.gmail.com>
References: <1456968530-19635-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38281 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936AbcCCIbA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2016 03:31:00 -0500
In-Reply-To: <1456968530-19635-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Mar 3, 2016 at 2:28 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
