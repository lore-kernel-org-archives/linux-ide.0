From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [lkcd-devel] Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 11:34:06 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031008113406.2f2591c9.shemminger@osdl.org>
References: <20030917144120.A11425@in.ibm.com>
	<1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>
	<20031008151357.A31976@in.ibm.com>
	<20031008115051.GD705@redhat.com>
	<20031008174458.A32517@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:48096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261719AbTJHSex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2003 14:34:53 -0400
In-Reply-To: <20031008174458.A32517@in.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: vatsa@in.ibm.com
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, 8 Oct 2003 17:44:58 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Wed, Oct 08, 2003 at 12:50:51PM +0100, Dave Jones wrote:
> > 
> > Why not just use udelay() ?  The above code cannot possibly do
> > the right thing on all processors.
> 
> Since my code is supposed to run when system is crashing, I would like 
> to avoid calling any function in the kernel as far as possible, since 
> the kernel and its data structures may be in a inconsistent state 
> and/or corrupted.

If your kernel context is alive enough to take the dump, then it should
be able to call things like udelay() that don't modify any data.  If it
can't your hosed already...
