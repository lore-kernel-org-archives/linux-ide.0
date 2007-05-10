From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] pata_platform: don't use generic ata_port_start
Date: Thu, 10 May 2007 13:22:12 +0900
Message-ID: <20070510042212.GA26530@linux-sh.org>
References: <20070510040020.GA17530@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:44774 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbXEJEkt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 00:40:49 -0400
Content-Disposition: inline
In-Reply-To: <20070510040020.GA17530@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, May 09, 2007 at 11:00:20PM -0500, Olof Johansson wrote:
> pata_platform works great for me, with the exception of using the generic
> ata_port_start which tries to do a dmam_alloc_coherent.
> 
> Looks like it doesn't need to allocate a prd table at all, so replace it
> with a dummy function instead.
> 
Looks fine, and works for me.

> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
