From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 02/15] ata: Use clk_prepare_enable/clk_disable_unprepare
Date: Wed, 6 Jun 2012 00:40:09 -0300
Message-ID: <CAOMZO5AuyYyxi9T3xUmWtGiaAoTzN3F07gppb4pzwSm8SAxaVQ@mail.gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
	<1337987696-31728-2-git-send-email-festevam@gmail.com>
	<20120529091721.GF30400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44049 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab2FFDkK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2012 23:40:10 -0400
Received: by bkcji2 with SMTP id ji2so5231738bkc.19
        for <linux-ide@vger.kernel.org>; Tue, 05 Jun 2012 20:40:09 -0700 (PDT)
In-Reply-To: <20120529091721.GF30400@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de, shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Jeff,

On Tue, May 29, 2012 at 6:17 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, May 25, 2012 at 08:14:43PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Prepare the clock before enabling it.
>>
>> Cc: Jeff Garzik <jgarzik@pobox.com>
>> Cc: <linux-ide@vger.kernel.org>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Can this be applied?
