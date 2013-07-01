From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms
Date: Mon, 1 Jul 2013 20:34:38 +0530
Message-ID: <CAGxe1ZEhTumWC5mpirjSqg2fogFz5VuLKLtxUpA=ctxdwU-i6w@mail.gmail.com>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
	<1372672975-2997-5-git-send-email-r65037@freescale.com>
	<CAGxe1ZEHWQUXmjgmGGkpy3wgxoS8ti0-eYZPHkQKzjD9pWqZ0Q@mail.gmail.com>
	<20130701144817.GT13206@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:54292 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3GAPEj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 11:04:39 -0400
Received: by mail-qa0-f52.google.com with SMTP id bv4so2128668qab.11
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2013 08:04:38 -0700 (PDT)
In-Reply-To: <20130701144817.GT13206@S2101-09.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On 1 July 2013 20:18, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jul 01, 2013 at 04:57:35PM +0530, Girish K S wrote:
>> Hello Richard,
>>
>> Instead of writing a separate driver for the changes you mentioned in
>> the commit message. you can just add those changes to
>> the platform data (pdata-> init).
>
> No. The platform init hook is not used to do IP block related setup.
> If we're mapping ahci block and setting up ahci registers in platform
> code, we are generally not doing the right thing.

Yes I understand (anything specific to driver should be part of
driver). I need to touch few platforms that are already doing this.
Then how about keeping setup as part of driver data for the specific controller.


>
> Shawn
>
