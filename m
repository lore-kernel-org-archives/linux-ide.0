From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms
Date: Mon, 1 Jul 2013 22:48:19 +0800
Message-ID: <20130701144817.GT13206@S2101-09.ap.freescale.net>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
 <CAGxe1ZEHWQUXmjgmGGkpy3wgxoS8ti0-eYZPHkQKzjD9pWqZ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:18477
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752123Ab3GAOsI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 10:48:08 -0400
Content-Disposition: inline
In-Reply-To: <CAGxe1ZEHWQUXmjgmGGkpy3wgxoS8ti0-eYZPHkQKzjD9pWqZ0Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Mon, Jul 01, 2013 at 04:57:35PM +0530, Girish K S wrote:
> Hello Richard,
> 
> Instead of writing a separate driver for the changes you mentioned in
> the commit message. you can just add those changes to
> the platform data (pdata-> init).

No. The platform init hook is not used to do IP block related setup.
If we're mapping ahci block and setting up ahci registers in platform
code, we are generally not doing the right thing.

Shawn

