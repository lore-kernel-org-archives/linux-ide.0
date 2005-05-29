From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 15:05:18 -0400
Message-ID: <20050529190518.GA7928@havoc.gtf.org>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <4299CD31.8020805@rtr.ca> <20050529190421.GB29770@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:57502 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261363AbVE2TFb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 May 2005 15:05:31 -0400
Content-Disposition: inline
In-Reply-To: <20050529190421.GB29770@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Mark Lord <liml@rtr.ca>, Michael Thonke <iogl64nx@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 09:04:21PM +0200, Jens Axboe wrote:
> On Sun, May 29 2005, Mark Lord wrote:
> > My basic hdparm timing test shouldn't show much of a difference
> > with NCQ tests, becase hdparm just does a single request at a time,
> > and waits for the results before issuing another.  Now, kernel read-ahead
> > may result in some command overlap and a slight throughput increase, but..
> > 
> > Something like dbench and/or bonnie++ are more appropriate here.
> 
> I don't like bonnie++ very much and dbench is very write intensive. I
> would suggest trying tiotest, find it on sf.net. It gets easily readable
> results and they are usually fairly consistent across runs if you limit
> the RAM to something sensible (eg 256MB and using a data set size of
> 768MB).

As an FYI...  download Stephen Tweedie's verify-data tool at
http://people.redhat.com/sct/src/verify-data/

Robin Miller's 'dt' is also nice to have.

	Jeff



