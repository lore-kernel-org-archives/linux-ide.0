From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/15] ata: Use clk_prepare_enable/clk_disable_unprepare
Date: Fri, 08 Jun 2012 11:49:52 -0400
Message-ID: <4FD21F20.607@pobox.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com> <1337987696-31728-2-git-send-email-festevam@gmail.com> <20120529091721.GF30400@pengutronix.de> <CAOMZO5AuyYyxi9T3xUmWtGiaAoTzN3F07gppb4pzwSm8SAxaVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41552 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab2FHPt4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2012 11:49:56 -0400
Received: by gglu4 with SMTP id u4so1367759ggl.19
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2012 08:49:55 -0700 (PDT)
In-Reply-To: <CAOMZO5AuyYyxi9T3xUmWtGiaAoTzN3F07gppb4pzwSm8SAxaVQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, linux-ide@vger.kernel.org

On 06/05/2012 11:40 PM, Fabio Estevam wrote:
> Jeff,
>
> On Tue, May 29, 2012 at 6:17 AM, Sascha Hauer<s.hauer@pengutronix.de>  wrote:
>> On Fri, May 25, 2012 at 08:14:43PM -0300, Fabio Estevam wrote:
>>> From: Fabio Estevam<fabio.estevam@freescale.com>
>>>
>>> Prepare the clock before enabling it.
>>>
>>> Cc: Jeff Garzik<jgarzik@pobox.com>
>>> Cc:<linux-ide@vger.kernel.org>
>>> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
>>
>> Acked-by: Sascha Hauer<s.hauer@pengutronix.de>
>
> Can this be applied?

Just got back from Europe, and will get this in ASAP...



