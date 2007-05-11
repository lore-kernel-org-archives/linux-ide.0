From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_platform: don't use generic ata_port_start
Date: Fri, 11 May 2007 18:19:26 -0400
Message-ID: <4644EBEE.7080904@pobox.com>
References: <20070510040020.GA17530@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43724 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbXEKWTb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:19:31 -0400
In-Reply-To: <20070510040020.GA17530@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: lethal@linux-sh.org, linux-ide@vger.kernel.org

Olof Johansson wrote:
> Hi,
> 
> I have a system where I have a simple IDE controller that sits on a
> local bus without bus master dma capability, and thus no dma_mapping
> ops defined for the device/bus.
> 
> pata_platform works great for me, with the exception of using the generic
> ata_port_start which tries to do a dmam_alloc_coherent.
> 
> Looks like it doesn't need to allocate a prd table at all, so replace it
> with a dummy function instead.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

applied.

Please move comments like "Hi," down before the "---" separator, so that 
they are not included in the permanent kernel changelog.  See 
Documentation/SubmittingPatches for more info.

	Jeff



