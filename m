From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 09:36:36 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10310080935350.7858-100000@master.linux-ide.org>
References: <20031008115051.GD705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6675 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261151AbTJHQj0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Oct 2003 12:39:26 -0400
In-Reply-To: <20031008115051.GD705@redhat.com>
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


Does not matter, priority is to get content to platter and the hell with
everything else.  The reset button is your friend.

Andre Hedrick
LAD Storage Consulting Group

On Wed, 8 Oct 2003, Dave Jones wrote:

> On Wed, Oct 08, 2003 at 03:13:57PM +0530, Srivatsa Vaddagiri wrote:
> 
>  > /* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
>  > /* ToDo : replace this routine based on loops_per_jiffy?? */
>  > static inline void dump_udelay(unsigned int num_usec)
>  > {
>  > 	volatile unsigned int i;
>  > 	for (i = 0; i < 10000 * num_usec; i++);
>  > }
> 
> Why not just use udelay() ?  The above code cannot possibly do
> the right thing on all processors.
> 
> 		Dave
> 
> -- 
>  Dave Jones     http://www.codemonkey.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

