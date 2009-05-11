From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ide: remove driver_data direct access of struct device
Date: Mon, 11 May 2009 13:54:32 -0700
Message-ID: <20090511205432.GA30780@kroah.com>
References: <20090430221500.GA18462@kroah.com> <200905081416.15088.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60420 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbZEKVlr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 17:41:47 -0400
Content-Disposition: inline
In-Reply-To: <200905081416.15088.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On Fri, May 08, 2009 at 02:16:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 01 May 2009 00:15:00 Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > In the near future, the driver core is going to not allow direct access
> > to the driver_data pointer in struct device.  Instead, the functions
> > dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> > have been around since the beginning, so are backwards compatible with
> > all older kernel versions.
> > 
> > Cc: linux-ide@vger.kernel.org
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks, I've updated my copy of the patch.

greg k-h
