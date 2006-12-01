From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new cleanup
Date: Fri, 1 Dec 2006 00:13:21 +0000
Message-ID: <20061201001321.1b946f0e@localhost.localdomain>
References: <200611302151.33319.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51117 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030973AbWLAAGl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 19:06:41 -0500
In-Reply-To: <200611302151.33319.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org


I believe this is completely the wrong thing to do. Adding a ton of
changes to the existing (and stable) life expired drivers/ide driver
rather than keeping new and risky stuff in the new libata code is bad.

The existing code *works*, its been rock solid since the reset drain fix
and it is the code everyone who is conservative relies on not to eat
their data. We have somewhere to do new and cool stuff its libata.

I don't see the point in risking destabilising a good solid driver. I can
just about see justification for !X86 implementation of the PLL handling
but that is about it.

Alan
