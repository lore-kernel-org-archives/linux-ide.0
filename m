From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in
 cdrom_read_capacity
Date: Wed, 30 Jul 2008 13:02:55 -0700
Message-ID: <20080730130255.9538678a.akpm@linux-foundation.org>
References: <1217405406.11834.11.camel@elijah.suse.cz>
	<20080730011832.0ee55d47.akpm@linux-foundation.org>
	<9ea470500807300152p5d5414aaq2d0d0053c12ef3f5@mail.gmail.com>
	<200807302125.54124.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35929 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753819AbYG3UDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 16:03:41 -0400
In-Reply-To: <200807302125.54124.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@gmail.com, gregkh@suse.de, ptesarik@suse.cz, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, jack@suse.cz

On Wed, 30 Jul 2008 21:25:53 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> > > Bart owns this patch now.  It got lost for a month and it has already
> > > been fixed twice and it is also on the route to 2.6.25.x and 2.6.26.x,
> > > so it'll get complicated.  Not a happy little patch.
> > 
> > Greg, can you please apply this one on top of -stable.
> 
> The usual policy is to not apply to -stable patches which are not in
> Linus' tree so please notify stable@kernelorg team after patch hits
> mainline.

Please put a Cc: <stable@kernel.org> into the changelog.  Then the
stable people will notice it when Linus commits it.
