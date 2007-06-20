From: Thanos Kyritsis <djart@linux.gr>
Subject: Re: [PROBLEM]: hdparm strange behaviour for 2.6.21 and later
Date: Wed, 20 Jun 2007 18:07:41 +0300
Message-ID: <200706201807.41646.djart@linux.gr>
References: <200706161958.05313.djart@linux.gr> <4676E47E.5050209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aiolos.otenet.gr ([195.170.0.93]:60967 "EHLO aiolos.otenet.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757AbXFTPmb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 11:42:31 -0400
In-Reply-To: <4676E47E.5050209@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Monday 18 June 2007, Mark Lord wrote:
> Thanos Kyritsis wrote:
[snip]
> > /etc/rc.d/rc.local contains the following:
> > /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hda
> > /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdb
[snip]

> Sounds like a (kernel) timing issue.
> The "-q" option gets rid of some intermediary printf's,
> and nothing else.  So with -q, the ioctl() calls happen
> much closer together in time.  Without -q, the intermediary
> printf's likely cause a resched, giving the kernel more time
> to complete anything left over from the earlier call.
>
> ????
>
> Any difference with a modern version of hdparm?

The same issue happens when using hdparm 7.4 as well as 7.5.


> -ml



-- 
Thanos Kyritsis <djart at linux.gr>

- What's your ONE purpose in life ?
- To explode, of course! ;-)
