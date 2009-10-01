From: David Miller <davem@davemloft.net>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Thu, 01 Oct 2009 09:40:34 -0700 (PDT)
Message-ID: <20091001.094034.161463891.davem@davemloft.net>
References: <200910011026.17510.elendil@planet.nl>
	<20091001.013030.98262804.davem@davemloft.net>
	<200910011125.40081.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54310
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755533AbZJAQkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Oct 2009 12:40:15 -0400
In-Reply-To: <200910011125.40081.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: elendil@planet.nl, manty@manty.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 1 Oct 2009 11:25:40 +0200

> The problem is that you simply cannot know what is the system state here.
> 
> Thus when the unknown block layer request is encountered the best thing
> you can do is to BUG early instead of allowing the situation when some
> requests are silently dropped and possibly causing the data corruption.

Yes, but if you BUG() in this kind of location, the chance of getting
the debugging information from the user can be close to zero.  We were
very lucky this time :-)

If we're tossing a request, signal an error to the submitter.

I hear we have infrastructure for that :-)
