From: Mike Hokenson <kernel+marvell@gozer.org>
Subject: Re: Marvell 88SE6121 PATA in 2.6.25 (ahci)
Date: Mon, 5 May 2008 13:41:25 -0500
Message-ID: <20080505184125.GA17375@gozer.dminteractive.com>
References: <20080505045537.GA24381@gozer.dminteractive.com> <481F1F4B.508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dminteractive.com ([66.18.16.178]:50825 "EHLO
	gozer.dminteractive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbYEESl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 14:41:26 -0400
Content-Disposition: inline
In-Reply-To: <481F1F4B.508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org


On Monday, May 05, 2008 at 10:52AM, Jeff Garzik wrote:
> AHCI takes over the entire controller, but does not yet support PATA  
> devices.

Since I only use the Marvell controller for the PATA port, I'll just
comment out the PCI ID and recompile. I think that should cause it to
behave like older kernels...

Thanks,

Mike
