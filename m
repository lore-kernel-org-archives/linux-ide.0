From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Fri, 11 Feb 2011 18:25:47 +0000
Message-ID: <20110211182547.2ede69b5@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
	<20110209214118.GA7196@atj.dyndns.org>
	<4D5332D2.5090701@cfl.rr.com>
	<4D534378.3050304@gmail.com>
	<20110210091325.GK3770@htj.dyndns.org>
	<4D54387F.3030809@cfl.rr.com>
	<20110210193124.321b7ad6@lxorguk.ukuu.org.uk>
	<4D557D8A.6050607@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44304 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757767Ab1BKSVx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 13:21:53 -0500
In-Reply-To: <4D557D8A.6050607@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, 11 Feb 2011 13:18:50 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:

> On 2/10/2011 2:31 PM, Alan Cox wrote:
> > If you start the smart stuff then it also sometimes locks when it
> > shouldn't with devastating results for non technical users. I'd say
> 
> When?  Is there any specific case you can think of?

Think about a raid volume where it is full disk and then the magic
autolocking crap guesses wrong, the volume goes partly inaccessible while
the box is running. Nasty mess.

> > No - because the drive may not even have a partition table on the other
> > OS.
> 
> Huh?  Either the drive has a partition table or it doesn't.

There are lots of table formats and tables in different locations. It's
not simple as you seem to think. One persons partition table is another
persons data block.

