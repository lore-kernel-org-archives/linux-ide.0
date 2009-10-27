From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 18:43:18 -0700 (PDT)
Message-ID: <20091026.184318.205708741.davem@davemloft.net>
References: <51f3faa70910261807h54f05f73j48b67067ee3dde70@mail.gmail.com>
	<20091026.181922.261475236.davem@davemloft.net>
	<51f3faa70910261840v16444067uc323de7129b7592f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49998
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755588AbZJ0Bmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 21:42:55 -0400
In-Reply-To: <51f3faa70910261840v16444067uc323de7129b7592f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: phdm@macqel.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Robert Hancock <hancockrwd@gmail.com>
Date: Mon, 26 Oct 2009 19:40:03 -0600

> On Mon, Oct 26, 2009 at 7:19 PM, David Miller <davem@davemloft.net> wrote:
>> Meanwhile we should provide a way for things to work, and
>> realistically the only way to do that currently is to bump the
>> WAIT_DRQ value to some large number.
>>
>> And that's exactly the kind of patch I'm willing to accept for this.
> 
> I agree, it's sub-optimal but it helps.. if the user wants better
> behavior they should a) fix it so that the card isn't using PIO, at
> least if it supports DMA and b) not use drivers/ide..

Philippe's patch that started this thread uses "3 * HZ / 10"
which isn't large enough for the SSD cases.  Can someone please
post a patch that uses a large enough value?

Thanks.
