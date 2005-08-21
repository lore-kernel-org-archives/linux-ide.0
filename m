From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: A note on libata passthru patch
Date: Sun, 21 Aug 2005 17:46:54 -0400
Message-ID: <4308F64E.1080600@pobox.com>
References: <4308F40E.3010109@pobox.com> <4308F5BB.8040506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:6120 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751187AbVHUVrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:47:01 -0400
In-Reply-To: <4308F5BB.8040506@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> I'm certain there are lots of vendor-specific commands
> that might assume exclusive bus access, if not exclusive
> host access.  All of this makes a reasonable case for
> having libata stop other host activity before/while
> performing any passthru command.

We also have internal commands during error handling (and soon PM) to 
worry about, so its not as simple as that.  It implies a larger good at 
when we can queue commands, and how to synchronize them across multiple 
ports.  We need to do this for Simplex DMA, too.

	Jeff



