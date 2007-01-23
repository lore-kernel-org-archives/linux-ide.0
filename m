From: "Art Haas" <ahaas@airmail.net>
Subject: Re: PATA ATAPI detection debug
Date: Tue, 23 Jan 2007 07:55:23 -0600
Message-ID: <20070123135523.GA3961@artsapartment.org>
References: <45AB36B0.2050702@gmail.com> <45B5AB6B.5070903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:46687 "EHLO
	ms-smtp-01.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965135AbXAWNzZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 08:55:25 -0500
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-01.texas.rr.com (8.13.6/8.13.6) with ESMTP id l0NDtNTK009734
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 07:55:24 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <45B5AB6B.5070903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2007 at 03:30:03PM +0900, Tejun Heo wrote:
> Tejun Heo wrote:
> > Hello, all.
> > 
> > Many people have been reporting libata PATA ATAPI detection problem.  In
> > many but not all cases, the ATAPI device was occupying the slave slot
> > while a disk drive occupies the master slot.  Based on that and J.
> > Taimr's nullify freeze on via fix, I made a cocktail patch which
> > contained four different fixes and it seemed to have fixed the problem
> > for (at least) several people, but the reports are not all consistent.
> > 
> > The attached patches contain the same four fixes but has a selector
> > parameter to enable each fix separately.  Both are equivalent but using
> > 2.6.20-rc5 is recommended to rule out detection problems fixed by
> > polling IDENTIFY.
> > 
> > If your libata driver is compiled into the kernel, add
> > 'libata.debug_cocktail=N' to your kernel parameter.  If you compile
> > libata.ko as module, add 'debug_cocktail=N' module parameter to the
> > module parameter.  e.g. 'modprobe libata.ko debug_cocktail=1'.
> 
> Daniel Fraga and Sero's cases are different issue while I can't
> determine whether J. Taimr's case is limted on via chipset.  So, I need
> more input to proceed.
> 
> *Please* test and report the results.
> 
> Thanks.
> 
> -- 
> tejun

Hi.

I got a chance to test your patches yesterday. Enclosed is the 'dmesg'
output for tests of 'debug_cocktail' values of 1,2,4,8,5,9,6, and 10.
My machine booted successfully each time, but the CD-ROM drive was
never detected.

Sorry it took a while to get to testing. Hope the enclosed info provides
you with useful clues in solving the problem.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

--J/dobhs11T7y2rNN
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="debug_dmesg.tar.gz"
Content-Transfer-Encoding: base64

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

--J/dobhs11T7y2rNN--
