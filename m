From: Jens Axboe <axboe@suse.de>
Subject: Re: Readahead with softraid1
Date: Fri, 8 Jul 2005 15:30:00 +0200
Message-ID: <20050708132959.GM7050@suse.de>
References: <1120824029.23681.18.camel@localhost.localdomain> <1120824984.3415.233.camel@vom> <1120828592.23681.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:25810 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262655AbVGHN20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 09:28:26 -0400
Content-Disposition: inline
In-Reply-To: <1120828592.23681.24.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: DCox@icc.net, Linux IDE List <linux-ide@vger.kernel.org>

On Fri, Jul 08 2005, Erik Slagter wrote:
> On Fri, 2005-07-08 at 08:16 -0400, Danny Cox wrote:
> 
> > > What am I doing wrong here???
> > 
> > 	Nothing.  I'll take a shot at answering this one instead of lurking
> > this time.  Then, I'll crawl back under my rock.
> > 
> > 	The raid1 driver keeps a "last visited block" for each drive.  This is
> > the block number that was most recently read or written by that drive.
> > When a read request arrives, the driver examines each drive for the
> > nearest last visited block to the one requested.  Guess what?  If the
> > read starts with drive sda, then it will *always* be the one chosen to
> > service the read in the future, because the last visited block number is
> > only one off.  This would only change if there are multiple processes
> > performing I/O on the md device.  Then, it may switch to another drive.
> > In any case, it will *tend* to stick with the same drive.
> > 
> > 	Did I explain that well, or only muddy the waters?
> 
> perfect explanation, thanks (and also Jens!).
> 
> Is this a design decision or is it fundamentaly impossible to split the
> work amongst several drives?  I guess the md driver at least do a
> prefetch of the next block/chunk on the "other" drive(s)?

Not sure if it's a design decision or just "this works ok, I'll fix it
later". Clearly there is a lot of room for improvement in the balancing
logic, to get more cases correct/faster. It's quite doable to split a
bio and send bits of it to various drives.

-- 
Jens Axboe

