From: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the
 IRQ context
Date: Tue, 23 Jun 2009 21:35:35 -0700 (PDT)
Message-ID: <20090623.213535.52208572.davem@davemloft.net>
References: <200906232329.11648.bzolnier@gmail.com>
	<20090623.162256.190152758.davem@davemloft.net>
	<200906240336.25263.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37117
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbZFXEfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 00:35:31 -0400
In-Reply-To: <200906240336.25263.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 24 Jun 2009 03:36:24 +0200

> IOW if there are really some technical issues left to be addressed with
> these patches I'll be happy to address them but I'm not doing any more
> new IDE stuff.

Discussing alternative approaches to fixing the problem is a technical
issue.

If you just want to dump your pending fixes and have no interest in
anything other than minor fixups and typo cures, then it's likely most
of these patches will be used only as guides for others rather than
being applied.

Specifically in this case I really think this is a very unclean way to
solve this problem, which is why I suggested alternative
implementations in the first place.

Anything that requires a set of if() blocks checking "in interrupt
context" or not is a big red flag in my book.

But I understand now that you're not willing to work on such things,
which I'll happily respect.
