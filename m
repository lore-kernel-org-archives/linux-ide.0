From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Mon, 22 Jun 2009 21:16:06 -0700 (PDT)
Message-ID: <20090622.211606.28120054.davem@davemloft.net>
References: <20090622.163136.246300819.davem@davemloft.net>
	<200906230230.14074.bzolnier@gmail.com>
	<200906230305.55283.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51906
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbZFWEQD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 00:16:03 -0400
In-Reply-To: <200906230305.55283.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 23 Jun 2009 03:05:55 +0200

> Please give people some time (few days) to review and comment patches before
> applying them.  I don't trust my own patches too much so I'm always looking
> for some peer review (usually all host driver patches go through Sergei, in
> this case Frans would have probably shot the patch down)..

Just because it's in my tree doesn't mean it's on it's way to
Linus yet.

Every patch will sit for at least a day or two until I really
push things to him.  Allowing for such errors to be spotted.

I can easily revert this and that's exactly what I will do.
