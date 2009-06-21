From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 14:21:44 -0700 (PDT)
Message-ID: <20090621.142144.19729137.davem@davemloft.net>
References: <200906202352.33894.elendil@planet.nl>
	<20090620.171945.140676687.davem@davemloft.net>
	<200906211743.09840.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:32939
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754288AbZFUVVk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jun 2009 17:21:40 -0400
In-Reply-To: <200906211743.09840.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: elendil@planet.nl, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Sun, 21 Jun 2009 17:43:09 +0200

> On Sunday 21 June 2009 02:19:45 David Miller wrote:
> 
>> Actually... the patch doesn't revert cleanly.  Let me setup a
>> patch to test by hand.  It just removes the IDE_HFLAG_SERIALIZE
>> flag from the chipset array entry.
> 
> We still need to fix the root cause of "screaming IRQ" but in the meantime
> could you resend with your S-o-B (now that Frans has tested it)?

I deleted the patch, just add my signoff to my original patch.

Signed-off-by: David S. Miller <davem@davemloft.net>
