From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in cdrom_read_capacity
Date: Wed, 30 Jul 2008 23:23:24 +0200
Message-ID: <200807302323.24807.bzolnier@gmail.com>
References: <1217405406.11834.11.camel@elijah.suse.cz> <200807302125.54124.bzolnier@gmail.com> <20080730130255.9538678a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:26222 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYG3WXE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 18:23:04 -0400
Received: by fk-out-0910.google.com with SMTP id 18so179779fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 15:23:02 -0700 (PDT)
In-Reply-To: <20080730130255.9538678a.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: petkovbb@gmail.com, gregkh@suse.de, ptesarik@suse.cz, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, jack@suse.cz

On Wednesday 30 July 2008, Andrew Morton wrote:
> On Wed, 30 Jul 2008 21:25:53 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > > > Bart owns this patch now.  It got lost for a month and it has already
> > > > been fixed twice and it is also on the route to 2.6.25.x and 2.6.26.x,
> > > > so it'll get complicated.  Not a happy little patch.
> > > 
> > > Greg, can you please apply this one on top of -stable.
> > 
> > The usual policy is to not apply to -stable patches which are not in
> > Linus' tree so please notify stable@kernelorg team after patch hits
> > mainline.
> 
> Please put a Cc: <stable@kernel.org> into the changelog.  Then the
> stable people will notice it when Linus commits it.

Done.
