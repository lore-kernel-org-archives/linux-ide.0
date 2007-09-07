From: Mark Lord <liml@rtr.ca>
Subject: Re: CF as IDE on ICH6M using libata
Date: Fri, 07 Sep 2007 09:38:34 -0400
Message-ID: <46E1545A.5000404@rtr.ca>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com> <46DEE72B.2060702@rtr.ca> <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com> <46E03DF6.8090405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1956 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965347AbXIGNig (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Sep 2007 09:38:36 -0400
In-Reply-To: <46E03DF6.8090405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Eddie Hung <eddie.hung@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Eddie Hung wrote:
>> However, I think we can conclude that ICH6M (which on the X41, has a
>> SATA-PATA bridge to connect a PATA drive) does not seem to support
>> MWDMA
> 
> It isn't clear whether the fault is at the driver or the CF device.

It's probably the bridge chip --> we've run through that one before
just recently (early summer?) on this list.  A particular bridge that
doesn't work at all with MWDMA.

Cheers
