From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Thu, 22 Oct 2009 04:00:49 -0700 (PDT)
Message-ID: <20091022.040049.83738097.davem@davemloft.net>
References: <200910212139.24675.bzolnier@gmail.com>
	<20091021.174155.44894825.davem@davemloft.net>
	<200910221144.04471.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59341
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbZJVLA0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2009 07:00:26 -0400
In-Reply-To: <200910221144.04471.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 22 Oct 2009 11:44:04 +0200

> We are through this the second time and you're still not willing
> neither to listen nor to read the code.

I can understand why you might attribute malice and ignorance to my
actions by default, but it doesn't apply here.

> We always did serialization for CMD646, we just used hwif->chipset
> == ide_cmd646 (without using IDE_HFLAG_SERIALIZE flag):

I fully acknowledge that we always serialized, sorry for not
being explicit.

I was just showing where the serialize IRQ flag got added
(and again, it was a correct change).
