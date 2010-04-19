From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] libata: don't flush dcache on slab pages
Date: Mon, 19 Apr 2010 12:55:55 -0700 (PDT)
Message-ID: <20100419.125555.120464722.davem@davemloft.net>
References: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
	<20100419194618.GA10886@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37526
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753374Ab0DSTzu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Apr 2010 15:55:50 -0400
In-Reply-To: <20100419194618.GA10886@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian@breakpoint.cc
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date: Mon, 19 Apr 2010 21:46:18 +0200

> * Sebastian Andrzej Siewior | 2010-03-21 22:52:22 [+0100]:
> 
>>page_mapping() check this via VM_BUG_ON(PageSlab(page)) so we bug here
>>with the according debuging turned on.
> 
> David, I've seen that you set this patch to "Not Applicable". May I know
> why?

Because the linux-ide patchwork is for IDE patches, not ATA
stuff.
