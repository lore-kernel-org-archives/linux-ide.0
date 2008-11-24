From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Mon, 24 Nov 2008 12:32:31 +0000
Message-ID: <20081124123231.555f2395@lxorguk.ukuu.org.uk>
References: <E1L4UpB-0007ro-1g@localhost>
	<492A8306.9000400@ru.mvista.com>
	<492A9A1F.50401@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41280 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752150AbYKXMcr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 07:32:47 -0500
In-Reply-To: <492A9A1F.50401@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Shane McDonald <mcdonald.shane@gmail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> >   It's 240, not 242 ns as 33 is actually 33.333.
> 
>    The maximum values give cycle time of 480 ns menaing that the 
> controller doesn't support PIO mode 0. Hm...

Even if you clear the enable for the timing register ?


Alan
