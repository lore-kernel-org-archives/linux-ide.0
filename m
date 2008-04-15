From: Tejun Heo <htejun@gmail.com>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 16 Apr 2008 08:31:29 +0900
Message-ID: <48053AD1.8010007@gmail.com>
References: <200804021524.27222.elendil@planet.nl> <200804021820.04610.elendil@planet.nl> <20080402194938.GI24237@csclub.uwaterloo.ca> <200804031947.07674.elendil@planet.nl> <48017248.4030600@gmail.com> <20080414134734.GB7385@csclub.uwaterloo.ca> <20080414145302.4239b0b9@core> <480414E6.2090205@gmail.com> <20080415144748.GO7385@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760251AbYDOXbt@vger.kernel.org>
In-Reply-To: <20080415144748.GO7385@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi,

Lennart Sorensen wrote:
> Yes.  After all you would quickly see a problem if you built a kernel
> with all the IDE drivers built in, which some people do.  In that case
> ide generic is always activated last and anything bad that would happen
> with loading a module would happen built in too.

Yeah, pick the right configuration.  You can make it malfunction.

> I think it is the wrong place to worry about problems.  If a native
> driver takes control of a chip, it is that drivers responsibility to
> reserve any relevant ports on that chip sufficiently to prevent another
> driver from messing with it that doesn't know anything about that chip.
> If the native driver doesn't load at all, then ide-generic ought to try
> and drive the chip if it has legacy ports.

I'm not too sure whether that will be always possible and I'm less sure 
we'll get enough test coverage over this kind of stuff.

> So my opinion is that making life easy to those machines with legacy ide
> ports is a good thing, while trying to be overly paranoid about one
> driver potentially hitting a bug in another driver is just silly.  Why
> couldn't two native ide drivers potentially go looking for the same
> ports too?  Are you sure no native driver uses the legacy IDE port
> numbers to control a chip in native mode?  Finding bugs is good since
> then they can be fixed.  Trying to prevent hitting bugs (which shouldn't
> be there in the first place) doesn't seem useful.

Yeah, theoretically, you're right.  The problem is that what breaks when 
things go wrong.  If you don't probe generic ports by default, harddisks 
won't be detected on some legacy systems but you can always prompt the 
user about loading the generic driver.  If you probe generic ports by 
default, when things go wrong, you break modern machines in an 
unrecoverable (w/o reset) way.  I'd rather choose bothering the user on 
legacy machines.

thanks.

-- 
tejun
