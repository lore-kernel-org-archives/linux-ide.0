From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 05/30] pcmcia - spot slave decode flaws (for testing)
Date: Tue, 06 Mar 2007 06:44:49 -0500
Message-ID: <45ED5431.3040105@garzik.org>
References: <200703061037.l26AbsJI019466@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53599 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbXCFLov (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:44:51 -0500
In-Reply-To: <200703061037.l26AbsJI019466@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan <alan@lxorguk.ukuu.org.uk>
> 
> If you've got a CF adapter or PCMCIA disc which shows up twice in libata
> pata_pcmcia can you try this patch on top of the updates posted.  It tries
> to spot when the slave is a mirror of the master and to fix up problems
> that causes.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Seems same, but dropped due to "can you try this patch" comments.  Let 
me know if this actually fixes something...


