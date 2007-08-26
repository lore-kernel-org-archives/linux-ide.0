From: Izik Weksler <iweksler@bezeqint.net>
Subject: Re: Fwd: Re: libata pmp support
Date: Sun, 26 Aug 2007 18:36:56 +0300
Message-ID: <200708261836.56416.iweksler@bezeqint.net>
References: <200708241951.45684.iweksler@bezeqint.net> <46CF8F20.5040107@gmail.com>
Reply-To: iweksler@bezeqint.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sa7.bezeqint.net ([192.115.104.21]:56349 "EHLO sa7.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbXHZPhD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Aug 2007 11:37:03 -0400
In-Reply-To: <46CF8F20.5040107@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org



 >>>On Saturday 25 August 2007, Tejun Heo wrote:
> Izik Weksler wrote:
> > ----------  Forwarded Message  ----------
> >
> > Subject: Re: libata pmp support
> > Date: Thursday 23 August 2007
> > From: Izik Weksler <iweksler@bezeqint.net>
> > To: Tejun Heo <htejun@gmail.com>
> >
> >  >>>On Thursday 23 August 2007, you wrote:
> >>
> >> Izik Weksler wrote:
> >>> Tejun,
> >>>
> >>> If you're sending the patch please send it to this address.
> >>
> >> Okay, please test the attached patch and please cc
> >> linux-ide@vger.kernel.org when replying.  Thanks.
> >
> > Tejun,
> >
> > The patch failed. It sais:
>
> Against which version?  The patch will apply to 2.6.22.5 & 2.6.23-rcX
> w/o the PMP patches.

Yeah. I realized that it applies to a version that doesn't contain pmp 
support. I tried to apply it to the 2.6.22.2-3 that goes with the SUSE 10.3 
and of course it failed because it is pmp patched.
So you suggest that I use the 2.6.22.5 vanilla from the www.kernel.org? If not 
please send me a link to the applicable version.

Isaac
