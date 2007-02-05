From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] libata: Early CFA adapters are not required to support
 mode setting
Date: Mon, 5 Feb 2007 15:14:57 -0800
Message-ID: <20070205151457.e816b189.akpm@linux-foundation.org>
References: <20070205162830.5f9cff4a@localhost.localdomain>
	<20070205145220.4eb3269b.akpm@linux-foundation.org>
	<20070205231152.59527980@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:38424 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964996AbXBEXPG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Feb 2007 18:15:06 -0500
In-Reply-To: <20070205231152.59527980@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Mon, 5 Feb 2007 23:11:52 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> > libata-fix-hopefully-all-the-remaining-problems-with.patch.  Should I drop
> > 
> 
> The hopefully fix all the remaining problems patch did say not to merge
> it I thought. Please don't merge it yet - Jeff has asked for some
> improvements and its not fixing the cases under investigation so it'll
> confuse stuff rather than help at the moment.

I wasn't planning on sending libata-fix-hopefully-all-the-remaining-problems-with.patch
upstream.  My concern is that its presence might invalidate (or get confused with)
testing of the earlier patches.

I'll assume it's ok...
