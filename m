From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Report PIO/DMA status when overriding set_mode
Date: Thu, 15 Feb 2007 17:58:42 -0500
Message-ID: <45D4E5A2.5060004@garzik.org>
References: <20070205163344.010a9892@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60186 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161638AbXBOW6o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 17:58:44 -0500
In-Reply-To: <20070205163344.010a9892@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan wrote:
> Currently we don't report PIO/DMA information in the case we are using
> firmware mode setup by drivers, or where the value is meaningless. Even
> when we don't know the mode, or the mode is meaningless it would be nice
> to report PIO or DMA and to keep stylistic consistency. For MW/UDMA we
> can report the actual firmware set mode and we add a helper for this.
> 
> This patch for now is just a proposal for comment
> 
> (and while we could guess the PIO mode by playing with the command
> registers and timing them I don't think its worth it)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Looks good to me.

Dropped, since you say it's just a proposal

	Jeff



