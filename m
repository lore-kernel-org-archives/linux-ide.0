From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Wed, 30 Apr 2008 22:48:00 -0400
Message-ID: <48192F60.1080303@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca> <4818E73D.9070201@rtr.ca> <48191422.30409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4014 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366AbYEACsB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Apr 2008 22:48:01 -0400
In-Reply-To: <48191422.30409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>>> So why are we taking a hammer to things there?
> 
> Hmmm... The reset action might be too heavy handed but maybe keeping 
> that categorized as ATA bus error is still a good idea so that multiple 
> errors w/ that bit set can trigger speed down.
..

Like a lot of those bits, I suppose we need to do the old telco tricks
of keeping a rolling average versus time.  Too many counts of them
in too short a period triggers remedial action, otherwise they're tolerated.

??
