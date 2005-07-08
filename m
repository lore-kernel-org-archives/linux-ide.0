From: Danny Cox <DCox@icc.net>
Subject: Re: Readahead with softraid1
Date: Fri, 08 Jul 2005 09:42:40 -0400
Message-ID: <1120830160.3415.256.camel@vom>
References: <1120824029.23681.18.camel@localhost.localdomain>
	 <1120824984.3415.233.camel@vom>
	 <1120828592.23681.24.camel@localhost.localdomain>
Reply-To: DCox@icc.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.ecweb.com ([209.168.254.136]:7615 "EHLO
	webmail.ecweb.com") by vger.kernel.org with ESMTP id S262660AbVGHNmr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jul 2005 09:42:47 -0400
In-Reply-To: <1120828592.23681.24.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Linux IDE List <linux-ide@vger.kernel.org>

Erik,

On Fri, 2005-07-08 at 15:16 +0200, Erik Slagter wrote:
> > 	Did I explain that well, or only muddy the waters?
> 
> perfect explanation, thanks (and also Jens!).

	Now, I don't know about perfect.... ;-)

> Is this a design decision or is it fundamentaly impossible to split the
> work amongst several drives?  I guess the md driver at least do a
> prefetch of the next block/chunk on the "other" drive(s)?

	If you're doing random reads on the drive, the raid1 logic can really
help.  I don't know of a benchmark off the top of my head that may
demonstrate that, although something from the Samba suite may.  I seem
to recall a program named something like 'tbench', but I don't remember
if that's the random reader or not.

> Now I am still wondering about the readahead issue. What would be a sane
> setting? I guess having both the drives and md doing readahead is not
> optimal?

	The readahead is implemented at the block layer (I think), and I can't
help you with that.  That's two levels (at least) up from the driver.
As I recall, the chain is: driver->md->block->filesystem->vfs, with
possibly the logical disk manager inserted also.  The only detail I seem
to recall is that the md driver changes a READA to a READ (read ahead to
a regular read), or at least it used to.

	Hmm.  I just took a look at 2.6.9 (yes, I'm out of date ;-), and the
function 'read_balance' actually special cases sequential reads, and
reuses the same drive.  I didn't find the READA to READ change that I
remembered, so scratch that.  Looks like Neil has been busy, and I've
been out of touch for awhile.

-- 
Daniel S. Cox
Internet Commerce Corporation

