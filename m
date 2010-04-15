From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: pass IRQ flags to the IDE core
Date: Thu, 15 Apr 2010 14:17:14 -0700 (PDT)
Message-ID: <20100415.141714.140807951.davem@davemloft.net>
References: <q2rf69abfc31004080726scbf96429ub4d84a318835d53d@mail.gmail.com>
	<20100415.021612.213438899.davem@davemloft.net>
	<20100415120748.12b2ef62@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41005
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757185Ab0DOVRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2010 17:17:10 -0400
In-Reply-To: <20100415120748.12b2ef62@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: yegorslists@googlemail.com, linux-ide@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Apr 2010 12:07:48 +0100

> On Thu, 15 Apr 2010 02:16:12 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>> Date: Thu, 8 Apr 2010 16:26:29 +0200
>> 
>> > IDE: pass IRQ flags to the IDE core
>> > 
>> > This enables shared IRQs and other features to be used with platform devices
>> > 
>> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> 
>> If you need this for a new device, please use the ATA layer
>> instead of adding support for new features in IDE which is
>> in deep maintainence mode only.
> 
> Actually Dave I think that one should go in. pata_platform (libata) and
> ide_platform both match the same platform objects so you can flip between
> them easily (eg for testing work). The fact the IRQ flags are only
> honoured in libata but not in the matching IDE driver is probably a good
> thing to fix.

Ok, will apply this then.
