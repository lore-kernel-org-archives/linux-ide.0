From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: Save a call to PageHighMem()
Date: Tue, 23 Jun 2009 03:06:28 -0700 (PDT)
Message-ID: <20090623.030628.01590841.davem@davemloft.net>
References: <20090623101239.2f510604@hyperion.delvare>
	<200906231148.32675.bzolnier@gmail.com>
	<20090623120018.4dff40f5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43107
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048AbZFWKGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 06:06:24 -0400
In-Reply-To: <20090623120018.4dff40f5@hyperion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khali@linux-fr.org
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Jun 2009 12:00:18 +0200

> Hi Bartlomiej,
> 
> On Tue, 23 Jun 2009 11:48:31 +0200, Bartlomiej Zolnierkiewicz wrote:
>> PS Please send IDE patches to Dave in the future, thanks.
> 
> I followed what MAINTAINERS says, and will keep doing so in the future.
> If the information stored there is outdated, please update it.

We did, just Linus hasn't taken my pull yet.  Will poke him about
it.
