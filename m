From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Thu, 06 May 2010 16:44:38 +0200
Message-ID: <4BE2D5D6.1010705@kernel.org>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51160 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab0EFOpH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 May 2010 10:45:07 -0400
In-Reply-To: <4BE28C4F.9000903@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On 05/06/2010 11:30 AM, Arjan van de Ven wrote:
> The thing is, SSS means the system requests (well, demands) that we
> don't spin up the disks up in parallel.... which we really really
> ought to honor... Jeff had a very valid point.

Hmmm... yeah but SSS doesn't really demand it.  It just says "I can do
staggered spin up".  I wish this thing had been implemented in the
form of "stay spin down till necessary (ie. start in standby mode)".
Currently, there's no way to tell whether staggered spin up is needed
or drives are already spun up.

> While today some bioses may spin everything up, that's not going to
> be the case going forward...  the industry as a whole is moving away
> from that (slowly but steadily).

Yeah, sure, in the long run maybe but I'm skeptical how useful this is
at this point.  Going forward, the right thing to do would be
implementing some sort of token infrastructure so that drivers can
request and hold the token while spinning up a drive so that the
concurrency of spin ups can be controlled.

Jeff, what do you think about lifting the check for now unless there
are known cases where this can cause problems?

Thanks.

-- 
tejun
