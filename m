From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: Fix simplex handling
Date: Fri, 02 Mar 2007 17:42:59 -0500
Message-ID: <45E8A873.30604@garzik.org>
References: <20070301173646.4138981b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54292 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992645AbXCBWnF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 17:43:05 -0500
In-Reply-To: <20070301173646.4138981b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Alan wrote:
> The initial simplex handling code is fooled if you suspend and resume.
> This also causes problems with some single channel controllers which
> claim to be simplex.
> 
> The fix is fairly simple, instead of keeping a flag to remember if we
> gave away the simplex channel we remember the actual owner. As the owner
> is always part of the host_set we don't even need a refcount.
> 
> Knowing the owner also means we can reassign simplex DMA channels in
> future hotplug code etc if we need to
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> (and a signed-off for the patch I sent before while I remember)

applied


