From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 4/4] pata_platform: Use 16-bit wide data transfer
Date: Thu, 18 Sep 2014 20:40:20 +0400
Message-ID: <20140918204020.6a7d5e7ab6b8eb8c88aa5aa6@mail.ru>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
	<1408790772-5305-3-git-send-email-shc_work@mail.ru>
	<20140823165326.GA13540@mtj.dyndns.org>
	<1408814955.452399984@f133.i.mail.ru>
	<20140825193454.GD21688@htj.dyndns.org>
	<20140825204817.0b8cdf68@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.181.189]:32810 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaIRRCW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2014 13:02:22 -0400
In-Reply-To: <20140825204817.0b8cdf68@alan.etchedpixels.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Mon, 25 Aug 2014 20:48:17 +0100
One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:

> On Mon, 25 Aug 2014 15:34:54 -0400
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Sat, Aug 23, 2014 at 09:29:15PM +0400, Alexander Shiyan wrote:
> > > > Shouldn't we distinguish them instead of forcing 16bit transfer on
> > > > all?
> > > 
> > > I do not see any reason to distinguish. This embodiment can be used with
> > > 16-bit and 32-bit bus, and even for 64-bit ;)
> > 
> > Hmmm... we do care about doing 32bit when possible as there are cases
> > where PIO is the only data tarnsfer mode available 
> 
> Because some environments you get faster data transfers if you throw data
> at the controller in 32bit chunks. In some cases that's because the
> controller is clever about it and pipelining (eg some VLbus devices) in
> others for the simple reason that the external bus cycles are either
> 16bit or converted that way and the CPU executes a 32bit move followed by
> an add faster than 16bit/add/16bit/add.
> 
> (There are legacy memory mapped devices around where the fastest way
> to read them on an older x86 is to use the FPU to do 64bit reads, but some
> things should not be encouraged ;-) )

Seems my response to this message was lost in space ...
Just to repeat:

I did not understand a bit of the final solution...
I hope I have clearly explained the original problem, which was written for
this patch? This is not theory.

-- 
Alexander Shiyan <shc_work@mail.ru>
