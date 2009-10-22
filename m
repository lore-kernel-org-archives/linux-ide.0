From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Thu, 22 Oct 2009 04:20:16 -0700 (PDT)
Message-ID: <20091022.042016.34969204.davem@davemloft.net>
References: <200910221144.04471.bzolnier@gmail.com>
	<20091022.040049.83738097.davem@davemloft.net>
	<200910221316.00054.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39208
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753613AbZJVLTx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2009 07:19:53 -0400
In-Reply-To: <200910221316.00054.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 22 Oct 2009 13:15:59 +0200

> On Thursday 22 October 2009 13:00:49 David Miller wrote:
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Date: Thu, 22 Oct 2009 11:44:04 +0200
>> 
>> > We always did serialization for CMD646, we just used hwif->chipset
>> > == ide_cmd646 (without using IDE_HFLAG_SERIALIZE flag):
>> 
>> I fully acknowledge that we always serialized, sorry for not
>> being explicit.
>> 
>> I was just showing where the serialize IRQ flag got added
>> (and again, it was a correct change).
> 
> What for?  The only patch changing behavior was yours and it seems
> your luck is much worse than mine when it comes to unexpected side
> effects.. ;)

Like I said, you can attribute my actions to malice or ignorance
if you want, but it simply isn't there.
