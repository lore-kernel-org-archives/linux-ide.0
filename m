From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 17:44:58 +0530
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031008174458.A32517@in.ibm.com>
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk> <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.131]:60801 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261397AbTJHMHL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Oct 2003 08:07:11 -0400
Content-Disposition: inline
In-Reply-To: <20031008115051.GD705@redhat.com>; from davej@redhat.com on Wed, Oct 08, 2003 at 12:50:51PM +0100
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, Oct 08, 2003 at 12:50:51PM +0100, Dave Jones wrote:
> 
> Why not just use udelay() ?  The above code cannot possibly do
> the right thing on all processors.

Since my code is supposed to run when system is crashing, I would like 
to avoid calling any function in the kernel as far as possible, since 
the kernel and its data structures may be in a inconsistent state 
and/or corrupted.

I do realize that the above code does not provide accurate 
delay and may not work on all platforms. In that direction
I was considering using the loops_per_jiffy variable 
which may provide more accurate/platform-independent delay (?) ..


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
