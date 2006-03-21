From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 16:09:21 -0500
Message-ID: <44206B81.1030309@garzik.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org> <20060321204435.GE25066@favonius> <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965125AbWCUVJ1@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sander <sander@humilis.net>, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 21 Mar 2006, Sander wrote:
> 
>>Is there a quick patch to suspect, or should I narrow down some more per
>>Andrew's instructions?
> 
> 
> Well, the only thing that changes the sata_mv driver in the -mm1 patchset 
> is the "git-libata-all.patch" patch, so you might start out just applying 
> that one broken-out patch and verifying that it fixes things for you.
> 
> That's git commit 2086a4aa2b41846801fad01f0fb1723134865ebb from Jeff's 
> libata tree.
> 
> At that point, if that fixes it for you, you'd be best off bisecting it in 
> Jeff's libata tree using git, to figure out what it is that fixed things. 
> Jeff?

There were a bunch of sata_mv fixes in git-libata-all, all of which are 
actually now in your linux-2.6.git tree.  This latest libata push gets 
sata_mv working on my 6042 card, and in the process fixes several bugs I 
found while doing the 6042 work.

Post-pull, git-libata-all is down to just a few development patches, 
none of which involve sata_mv.

In any case, one could be lazy, and simply bisect the main tree (and/or 
simply verify that the problem is gone in 2.6.16-git<today>).

	Jeff
