From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 14:26:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031008142631.B2345@flint.arm.linux.org.uk>
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk> <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com> <20031008174458.A32517@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20031008174458.A32517@in.ibm.com>; from vatsa@in.ibm.com on Wed, Oct 08, 2003 at 05:44:58PM +0530
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 08, 2003 at 05:44:58PM +0530, Srivatsa Vaddagiri wrote:
> I do realize that the above code does not provide accurate 
> delay and may not work on all platforms. In that direction
> I was considering using the loops_per_jiffy variable 
> which may provide more accurate/platform-independent delay (?) ..

loops_per_jiffy is meaningless when applied to anything other than the
udelay function.  It bears no resemblence in any way to the number of
loops around a for loop.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
