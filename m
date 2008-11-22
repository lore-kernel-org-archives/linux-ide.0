From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Date: Sat, 22 Nov 2008 14:52:04 +0000
Message-ID: <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
References: <49261BE5.2010406@caviumnetworks.com>
	<49280FC5.3040608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44133 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758144AbYKVOwN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Nov 2008 09:52:13 -0500
In-Reply-To: <49280FC5.3040608@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

>    But if you're saying that there is only DMA completion inetrrupt, you 
> *cannot* completely emulate SFF-8038i BMDMA since its interrupt status 
> is the (delayed) IDE INTRQ status. I suggest that you move away from the 
> emulation -- Alan has said it's possible.

I don't see whats wrong with treating it that way if it keeps the amount
of code needed down.

