From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 13:15:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031008121523.GH705@redhat.com>
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk> <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com> <20031008174458.A32517@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20031008174458.A32517@in.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 08, 2003 at 05:44:58PM +0530, Srivatsa Vaddagiri wrote:

 > > Why not just use udelay() ?  The above code cannot possibly do
 > > the right thing on all processors.
 > 
 > Since my code is supposed to run when system is crashing, I would like 
 > to avoid calling any function in the kernel as far as possible, since 
 > the kernel and its data structures may be in a inconsistent state 
 > and/or corrupted.

By the same principle, your dump_udelay() is just as likely to get
stomped on as the kernels udelay() function.
 
 > I do realize that the above code does not provide accurate 
 > delay and may not work on all platforms. In that direction
 > I was considering using the loops_per_jiffy variable 
 > which may provide more accurate/platform-independent delay (?) ..

If you must reinvent a wheel, use a round one. Copy udelay().

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
