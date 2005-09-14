From: Mark Lord <liml@rtr.ca>
Subject: Re: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 11:26:30 -0400
Message-ID: <43284126.8040007@rtr.ca>
References: <43277485.6030802@yahoo.de>	 <1126690298.4248.44.camel@localhost.localdomain>	 <4327FB2C.5000207@yahoo.de>	 <1126694013.4248.49.camel@localhost.localdomain>	 <4327FEE7.7020707@yahoo.de>  <43281B5E.2090702@bouton.name> <1126702271.4248.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:25476 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S965243AbVINP0c
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 11:26:32 -0400
In-Reply-To: <1126702271.4248.56.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Lionel Bouton <lionel-subscription@bouton.name>, linux-ide@vger.kernel.org

Erik Slagter wrote:
>
> It's a very bad solution, because it's slow, but worse, it wears out
> particular sectors, although the only good option (make the stick
> non-removable when in use is not quite feasible).

Bad, YES.  Slow, VERY.

Wears out sectors?  Not really.
These flash sticks, along with CF and SD cards, all include
built-in controllers that do automatic wear-leveling.

So rewriting a small group of "logical" sectors over and over
does not, in fact, rewrite the same physical pages in flash.

But SYNC is still horrible for this application!
