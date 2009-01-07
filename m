From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use
 HORKAGE_NOSETXFER
Date: Wed, 7 Jan 2009 10:53:39 +0000
Message-ID: <20090107105339.289f47a4@lxorguk.ukuu.org.uk>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38078 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752015AbZAGKxi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 05:53:38 -0500
In-Reply-To: <496483A5.6020105@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org

> > Sorry you can't just blindly do this because some of the controllers snoop
> > the SETXFER command to set their timings and whether they expect DMA. Also
> > we've no idea if this is a bug in a specific firmware revision, a quirky
> > pata/sata bridge or a timing problem of some sort.
> 
> I think it'll generally be okay for SATA unless it's bridged over to
> PATA controller.  Any other ideas?

We seem to have one report, from one user, with one configuration, on one
controller, using one firmware set.

That to me isn't meaningful evidence of anything that needs a workaround,
beyond maybe doing what old IDE does and if a setxfer times out
continuing in hope.

(We should of course then re-read the identify pages and check the mode
in use)

Alan
