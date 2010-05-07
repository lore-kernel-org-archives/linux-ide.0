From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Fri, 07 May 2010 07:14:14 +0200
Message-ID: <4BE3A1A6.1040106@kernel.org>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com> <4BE2D5D6.1010705@kernel.org> <4BE31D57.6020400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45211 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab0EGFO3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 May 2010 01:14:29 -0400
In-Reply-To: <4BE31D57.6020400@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On 05/06/2010 09:49 PM, Jeff Garzik wrote:
> The problem being...  that we are honoring SSS bit, and thus thing are
> slower?  :)  I don't see any reason to change that, seeing as how people
> may be using it to avoid power spikes.
> 
> I agree there's no way to tell whether SSS is needed, but we cannot
> ignore SSS on that basis alone.  We should avoid making the assumption
> that BIOS w/ SSS bit has already spun up all drives regardless.

It's just that the usefulness seems very limited at this point so it
might be better idea to flip the default behavior and let people opt
in for SSS.  The problem is compounded by the complete serial behavior
we end up with and on some machines large number of ahci ports.  I
don't care much about boot time all that much but as that seems to be
a hot issue on desktops too these days.

Thanks.

-- 
tejun
