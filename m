From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Prevent IDE boot ops on NUMA system in mainline
Date: Mon, 11 Feb 2008 20:04:38 +0100
Message-ID: <20080211190438.GB21824@one.firstfloor.org>
References: <20080211003520.GA32082@basil.nowhere.org> <alpine.LFD.1.00.0802110929230.2920@woody.linux-foundation.org> <alpine.LFD.1.00.0802110936231.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760354AbYBKS3r@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802110936231.2920@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 11, 2008 at 09:37:18AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Feb 2008, Linus Torvalds wrote:
> > 
> > So we should probably make pcibus_to_node() be an inline function for that 
> > case
> 
> Or, we could just do the ugliest patch ever, namely
> 
> 	-#define pcibus_to_node(node)   (-1)
> 	+#define pcibus_to_node(node)   ((int)(long)(node),-1)
> 
> Wow. It's so ugly it's almost wraps around and comes out the other sides 
> and looks pretty.

(void)arg, ... is better. Trick originally from Jan Beulich I think
(his code is always a good source for useful new C tricks) 

-Andi
