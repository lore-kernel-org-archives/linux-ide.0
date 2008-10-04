From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_ninja32 plea
Date: Sat, 4 Oct 2008 18:30:10 +0100
Message-ID: <20081004183010.0809322b@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0810041846250.13914@dolores.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43384 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbYJDRae (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 13:30:34 -0400
In-Reply-To: <Pine.LNX.4.64.0810041846250.13914@dolores.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbee <bumble.bee@xs4all.nl>
Cc: linux-ide@vger.kernel.org, alan@redhat.com

> is something that will make it perform great on linux, all it would take is 
> someone with a lot more clue than me to take a look at it.
> 
> Anyone willing to take a look? Alan?

There is siome minimal information in the FreeBSD driver but they never
got DMA to work properly AFAIK. If you want DMA support you'll have to go
do the work to document DMA mode and I suspect it would be quite
substantial work.

Alan
