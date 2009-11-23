From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] block: Allow devices to indicate whether discarded
	blocks are zeroed
Date: Mon, 23 Nov 2009 12:03:25 -0500
Message-ID: <20091123170325.GA23217@infradead.org>
References: <1258771524-26673-1-git-send-email-martin.petersen@oracle.com> <1258771524-26673-2-git-send-email-martin.petersen@oracle.com> <20091121101356.GA21716@infradead.org> <20091121195802.GC8502@parisc-linux.org> <4B08A543.909@rtr.ca> <4B0ABA2F.2090407@redhat.com> <87f94c370911230854v46c1dc35g417a54b8a415ba16@mail.gmail.com> <4B0AC038.6050606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:57866 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZKWRDf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 12:03:35 -0500
Content-Disposition: inline
In-Reply-To: <4B0AC038.6050606@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Mark Lord <liml@rtr.ca>, Matthew Wilcox <matthew@wil.cx>, Christoph Hellwig <hch@infradead.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, jens.axboe@oracle.com, james.bottomley@hansenpartnership.com, willy@wil.cx, jgarzik@pobox.com, sandeen@redhat.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Mon, Nov 23, 2009 at 12:02:48PM -0500, Ric Wheeler wrote:
> I agree - the discard of the whole device is a good idea.
>
> I just want to make clear that "discard block X; write block X with 
> zeroed data" undoes the discard in general :-)

We can skip the writing of zeroes if we know the device returns zeroed
blocks after a trim.  Martin's patch exports that information to
userspace, and once we have a nice enough interface (e.g. blkid or an
ioctl) we can actually use it in mkfs to optimize the writing of zeroes
away.  Raw growling in sysfs is a bit too nasty to add it to mkfs for
those few blocks IMHO.

