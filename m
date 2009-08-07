From: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the
 IRQ context
Date: Fri, 07 Aug 2009 10:36:10 -0700 (PDT)
Message-ID: <20090807.103610.209136140.davem@davemloft.net>
References: <200908071355.21648.bzolnier@gmail.com>
	<20090807.090158.45976865.davem@davemloft.net>
	<200908071927.36367.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932087AbZHGRgD@vger.kernel.org>
In-Reply-To: <200908071927.36367.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Fri, 7 Aug 2009 19:27:36 +0200

> Are you trying to tell me that after 6 weeks there is still no public
> tree to hold future IDE changes?
> 
> If this is indeed a case here I hope that it will get addressed ASAP.

IDE is deep maintainence, we shouldn't be doing lots of changes,
cleanups, and things of this nature.  So urgency and timeliness
is on a sincerely different scale for it.

On the other hand, if you've been looking, I've been applying
networking patches to net-2.6 and net-next-2.6 by the truckload
on a daily basis because it is in active development.
