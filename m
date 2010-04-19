From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 1/2] libata: don't flush dcache on slab pages
Date: Mon, 19 Apr 2010 21:46:18 +0200
Message-ID: <20100419194618.GA10886@Chamillionaire.breakpoint.cc>
References: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:36305 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab0DSTqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Apr 2010 15:46:24 -0400
Content-Disposition: inline
In-Reply-To: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

* Sebastian Andrzej Siewior | 2010-03-21 22:52:22 [+0100]:

>page_mapping() check this via VM_BUG_ON(PageSlab(page)) so we bug here
>with the according debuging turned on.

David, I've seen that you set this patch to "Not Applicable". May I know
why?

Sebastian
