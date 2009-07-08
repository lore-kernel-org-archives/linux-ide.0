From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use
 HORKAGE_NOSETXFER
Date: Wed, 8 Jul 2009 13:21:04 +0100
Message-ID: <20090708132104.10e969a1@lxorguk.ukuu.org.uk>
References: <1229894315.6931.17.camel@Thutmosis>
	<494EDDBE.3010306@shaw.ca>
	<494F65C1.80602@kernel.org>
	<1229947998.6045.10.camel@Thutmosis>
	<49505500.8080409@kernel.org>
	<1230126055.6430.17.camel@Thutmosis>
	<495886E7.7050204@kernel.org>
	<1230586376.11130.46.camel@Thutmosis>
	<1231282276.6376.13.camel@Thutmosis>
	<49640CE1.6070808@kernel.org>
	<20090107094043.580f5bf7@lxorguk.ukuu.org.uk>
	<496483A5.6020105@kernel.org>
	<20090107105339.289f47a4@lxorguk.ukuu.org.uk>
	<49648C41.6030002@kernel.org>
	<4A1A0C1B.7020801@kernel.org>
	<20090525091110.626da5f8@lxorguk.ukuu.org.uk>
	<4A545236.6080808@kernel.org>
	<20090708111413.7bb25e1e@lxorguk.ukuu.org.uk>
	<4A547FF6.7010609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45983 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753428AbZGHMWE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jul 2009 08:22:04 -0400
In-Reply-To: <4A547FF6.7010609@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org, m.nov4k@gmail.com, lars21ce@gmx.de

> > What if there is a bridge, what if the controller needs SETXFER for
> > internal use (HPT PATA with on card SATA bridges) ?
> 
> The device is horridly broken. 

I know 8(

> 1. Don't do anything.  The device is broken everywhere.
> 
> 2. Skip SETXFER.  Any direct SATA connection to the device would work
>    fine.
> 
> 2. Ignore SETXFER timeout.  Probably would work for TF based
>    controllers but it's largely untested for sata controllers and the
>    behavior is likely undefined for more advanced controllers.

> So, #2 seems like the logical choice here.  If worst comes to worst

You have two #2's but I agree that providing its for this specific drive
and we document it carefully so people don't add it to stuff that is
wrong then your first #2 is probably safest.

Possibly  HORKAGE_NO_SETXFER_SATA and check word 93 ?


Alan
