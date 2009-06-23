From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] IDE: Save a call to PageHighMem()
Date: Tue, 23 Jun 2009 12:00:18 +0200
Message-ID: <20090623120018.4dff40f5@hyperion.delvare>
References: <20090623101239.2f510604@hyperion.delvare>
	<200906231148.32675.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:26844 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZFWKAX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 06:00:23 -0400
In-Reply-To: <200906231148.32675.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>

Hi Bartlomiej,

On Tue, 23 Jun 2009 11:48:31 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 23 June 2009 10:12:39 Jean Delvare wrote:
> > PageHighMem() isn't cheap so avoid calling it twice on the same page.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks.

> PS Please send IDE patches to Dave in the future, thanks.

I followed what MAINTAINERS says, and will keep doing so in the future.
If the information stored there is outdated, please update it.

-- 
Jean Delvare
