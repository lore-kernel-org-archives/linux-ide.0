From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 19:40:03 -0600
Message-ID: <51f3faa70910261840v16444067uc323de7129b7592f@mail.gmail.com>
References: <4AE64031.5060105@gmail.com>
	 <20091026.174525.154760254.davem@davemloft.net>
	 <51f3faa70910261807h54f05f73j48b67067ee3dde70@mail.gmail.com>
	 <20091026.181922.261475236.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:64318 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbZJ0Bj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 21:39:59 -0400
In-Reply-To: <20091026.181922.261475236.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: phdm@macqel.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 26, 2009 at 7:19 PM, David Miller <davem@davemloft.net> wrote:
> From: Robert Hancock <hancockrwd@gmail.com>
> Date: Mon, 26 Oct 2009 19:07:18 -0600
>
>> libata only busy-waits for 50 microseconds, if not set then it sleeps
>> for 2ms and polls for another 10 microseconds, if still not set it
>> tries the whole thing again at 16ms intervals. Only after (typically)
>> 30 seconds does it give up.
>
> Porting that kind of logic over to IDE is a non-starter.
>
> It's easier to get people to move over to using the ATA layer for
> their devices.
>
> Meanwhile we should provide a way for things to work, and
> realistically the only way to do that currently is to bump the
> WAIT_DRQ value to some large number.
>
> And that's exactly the kind of patch I'm willing to accept for this.

I agree, it's sub-optimal but it helps.. if the user wants better
behavior they should a) fix it so that the card isn't using PIO, at
least if it supports DMA and b) not use drivers/ide..
