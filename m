From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Thu, 12 Aug 2004 19:12:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408121912.35507.bzolnier@elka.pw.edu.pl>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408101916.17489.bzolnier@elka.pw.edu.pl> <20040810182353.GA17364@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11925 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268487AbUHLSKX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Aug 2004 14:10:23 -0400
In-Reply-To: <20040810182353.GA17364@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Tuesday 10 August 2004 20:23, Alan Cox wrote:
> On Tue, Aug 10, 2004 at 07:16:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 10 August 2004 18:19, Alan Cox wrote:
> > > -	Remove unsafe and essentially unfixable proc code for flipping
> > > 	between ide-cd and ide-scsi. Its no longer relevant with SG_IO.
> >
> > Shouldn't we deprecate it first...?
>
> It doesn't work now so it clearly isnt being used 8). We hold the lock
> because its a proc function and we then replace the proc functions in the
> attach method -> deadlock. It is also incredibly hard to fix without a
> major rewrite.

It is a correct analysis for /proc/ide/hdx/settings:ide-scsi but not 
for /proc/ide/hdx/driver which works just fine (modulo being racy)
and your patch removes both interfaces...

Bartlomiej
