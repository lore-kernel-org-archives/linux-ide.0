From: Andy Warner <andyw@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 15:40:33 -0600
Message-ID: <20050216154033.I10699@florence.linkmargin.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:34488 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262082AbVBPVkk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 16:40:40 -0500
Content-Disposition: inline
In-Reply-To: <4213B2F8.2070800@wasp.net.au>; from brad@wasp.net.au on Thu, Feb 17, 2005 at 12:54:16AM +0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Brad Campbell wrote:
> [...]
> Actually, I'm not sure without the libata dev patch as that removes SMART support, and I'm not 
> convinced that my smartd polling every 20 minutes does not have something to do with it. All I know 
> is the older kernel seems to cope. We'll see. 320 minutes left on this rebuild. I expect it will be 
> done in the morning if all goes according to plan. (With the 2.6.11 kernel it never survived past 
> about 25% rebuilt)

Can you find time to try it without smartd active ?
You report running a uni-processor system, and I have only
seen PIO problems with (fast) SMP systems in my testing,
but I am forming the opinion that libata-PIO functions
are in need of a minor overhaul.

I have seen issues where port activity monopolised
data-paths/arbitration inside chipsets such that the
PIO operations would appear to time out. Since you're
doing a raid rebuild, perhaps the I/O load is causing
something similar to occur.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
