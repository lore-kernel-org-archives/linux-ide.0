From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 2/2] sata_via: Delay on vt6420 when starting ATAPI DMA
 write
Date: Wed, 20 Jan 2010 12:30:42 +0900
Message-ID: <4B5678E2.2050709@gmail.com>
References: <20100116235653.898098245@gmail.com> <20100116235851.884756038@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:34064 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0ATDYi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 22:24:38 -0500
In-Reply-To: <20100116235851.884756038@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, juergen.metzdorf@telelev-dsl.de, markpschool@hotmail.com, sporadic.crash@gmail.com, apopov@sirma.bg, david@coomber.co.za, jay4mail@gmail.com

Hello,

On 01/17/2010 08:56 AM, Bart Hartgers wrote:
> When writing a disc on certain lite-on dvd-writers (also rebadged as
> optiarc/LG/...) connected to a vt6420, the ATAPI CDB ends up in the
> datastream and on the disc, causing silent corruption.  Delaying
> between sending the CDB and starting DMA seems to prevent this.
> 
> I do not know if there are burners that do not suffer from this, but
> the patch should be safe for those as well.
> 
> There are many reports of this issue, but AFAICT no solution was 
> found before. For example:
> http://lkml.indiana.edu/hypermail/linux/kernel/0802.3/0561.html
> 
> Signed-off-by: Bart Hartgers <bart.hartgers@gmail.com>

Ah... you found solution for this?  That's great.  This is one of the
three problems that have been lingering for years - the other two
being pata_ali ATAPI DMA problem and sata_sil data corruption problem.
I'll be ecstatic if this fix works.  Just one thing, I don't think
we'll need a warning message there.  It's useful during development
but it doesn't really provide any useful information afterwards.

Digging up the mailing list and cc'ing people who have reported this
problem.  If you still have the affected systems, can you guys please
test the patch in the following message and see whether it fixes the
problem?

  http://article.gmane.org/gmane.linux.kernel/939112/raw

Thanks a lot.  :-)

-- 
tejun
