From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Fri, 23 Oct 2009 18:15:55 +0100
Message-ID: <20091023181555.4999f6d7@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910212139.24675.bzolnier@gmail.com>
	<20091021.174155.44894825.davem@davemloft.net>
	<200910221144.04471.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56452 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752478AbZJWRO1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 13:14:27 -0400
In-Reply-To: <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

> Don't do it --- disks have cache and reading from the cache is as fast as 
> reading from SSD (or even faster), so if there is some speed-race in the 
> chip, there is a possibility that the data corruption happens with disks 
> too --- just with lower probability.
> 
> If we don't know why the chip corrupts data, we must treat it as always 
> corrupting data.

In which case we should delete the driver because serializing it is
probably not sufficient. There is a proper way to deal with IDE problems
and randomly turning things on and off isn't the solution from experience.

So
- It would be useful to get the data sheet that Daniela refers to
- If there is some kind of data path issue then serializing probably isn't
  enough on its own as has been said

and we need to understand why the libata case doesn't show corruption but
clearly shows it is unhappy. Libata doesn't serialize the device and
doesn't do fancy IRQ checking either.

Just serializing is likely to make it worse - it may well become a rare
deeply obscure corruption rather than a nice visible one like we have now
- and that is far far nastier. Most likely libata also needs work.




