From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unload cycle - WD1600BEVE
Date: Sat, 04 Oct 2008 16:37:05 +0900
Message-ID: <48E71D21.4@kernel.org>
References: <f56b605d0808060701p571c4695w85987d444fc16eb9@mail.gmail.com>	 <48E26365.5010905@kernel.org> <f56b605d0810020716p71fefacau709ce26dd678632c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43492 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbYJDHie (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 03:38:34 -0400
In-Reply-To: <f56b605d0810020716p71fefacau709ce26dd678632c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Bessa <carlos.bessa@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Bruce Allen <ballen@gravity.phys.uwm.edu>

Carlos Bessa wrote:
> Hi,
> sorry but it took me a while to get back to this.
> I've been monitoring the load_cycle_increase in the last hours and,
> depending on the use of the computer it can climb up really fast. Just
> readin/browsing the web and working on some word processor and it
> increases at about 60 per hour, even higher if i'ts just idling. The
> increase will be less of course if i'm doing some more intensive tasks,
> probably with more frequent hard drive usage.
> And just to clear the fact about the hard drive having been replaced.
> I's a completely diferent model/brand. The older one is a Fujitsu 80GB
> hard drive, which never suffered from this problem (at least i didn't
> noticed it). It was replaced by this WD unit, simply due to higher
> capacity. 

Okay, what seems to be going on is that the BIOS is programming the
drive the same way as the original one and the new one is interpreting
the same value differently - much more aggressively.  Aiee... This
really requires a dynamic solution.  Can you please apply workaround
manually for now?

Bruce, please ping me when you come back.

Thanks.

-- 
tejun
