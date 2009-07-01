From: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the
 IRQ context
Date: Wed, 01 Jul 2009 13:47:29 -0700 (PDT)
Message-ID: <20090701.134729.13610576.davem@davemloft.net>
References: <20090624.025518.75726622.davem@davemloft.net>
	<200906241248.21173.bzolnier@gmail.com>
	<200907011835.27586.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53628
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542AbZGAUrX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2009 16:47:23 -0400
In-Reply-To: <200907011835.27586.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 1 Jul 2009 18:35:27 +0200

> On Wednesday 24 June 2009 12:48:20 Bartlomiej Zolnierkiewicz wrote:
>> On Wednesday 24 June 2009 11:55:18 David Miller wrote:
> 
> [...]
> 
>> > I know you're busy, so I'll try to draft something up myself.
>> 
>> Ok, thanks.
> 
> Any news about these fixes?

Will get to it before the end of the weekend.

If I fail or abort, I'll integrate your version of the fix Bart, don't
worry :)
