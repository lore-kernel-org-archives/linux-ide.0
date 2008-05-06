From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 10:39:25 +0100
Message-ID: <20080506093925.GB12469@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <20080506092935.GC4378@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:40522 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbYEFJje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 05:39:34 -0400
Content-Disposition: inline
In-Reply-To: <20080506092935.GC4378@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Tue, May 06, 2008 at 11:29:35AM +0200, Holger Macht wrote:

> Right, so you never can rely on receiving a BAY_EVENT. Why not just
> disregard this case and looking for a common solution?

Oh, I agree - we need to solve this in any case. But for hardware where 
there is a separate request event before the device is pulled, users 
already have scripts that prompt them to unmount hardware. These worked 
in <2.6.25, but they're broken now. It'd be nice to get them working 
again.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
