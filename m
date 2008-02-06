From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3 2.6.24-git] ARM/RPC: Use HAVE_PATA_PLATFORM to select pata platform driver
Date: Wed, 6 Feb 2008 12:46:59 +0000
Message-ID: <20080206124659.GB21027@flint.arm.linux.org.uk>
References: <20080202161636.269848721@fluff.org.uk> <20080202161756.505881942@fluff.org.uk> <47A9A0D9.4090308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51548 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761534AbYBFMrf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 07:47:35 -0500
Content-Disposition: inline
In-Reply-To: <47A9A0D9.4090308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, htejun@gmail.com, Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Wed, Feb 06, 2008 at 06:58:17AM -0500, Jeff Garzik wrote:
> ACK patch series...  would it be ok to send via the ARM maintainer?
> 
> I would prefer to add this at the same time as its user...

I've only seen the one patch, and I suspect that it depends on patches
to other architectures (to convert other architectures to use the new
variable.)
