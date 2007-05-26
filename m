From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH 2/3] Unify dma blacklist in ide-dma.c and libata-core.c
Date: Sat, 26 May 2007 12:39:29 -0400
Message-ID: <465862C1.6040006@tmr.com>
References: <20070521145042.GA6957@redhat.com>	<20070521171551.0f81a0be@the-village.bc.nu>	<7v3b1pbgeo.fsf_-_@assigned-by-dhcp.cox.net> <7vveela1lv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:47769 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbXEZQhC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 May 2007 12:37:02 -0400
In-Reply-To: <7vveela1lv.fsf_-_@assigned-by-dhcp.cox.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>

Junio C Hamano wrote:
> This introduces a shared header file that defines the entries
> for two dma blacklists in ide-dma.c and libata-core.c to make it
> easier to keep them in sync.
> 
Why wasn't this done this way in the first place? Out of tree 
development for libata or something?

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
