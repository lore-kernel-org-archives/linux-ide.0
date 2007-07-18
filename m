From: Greg KH <gregkh@suse.de>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by
	warnings
Date: Tue, 17 Jul 2007 19:46:37 -0700
Message-ID: <20070718024637.GC6146@suse.de>
References: <20070717214239.GF28448@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759923AbXGRPqr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jul 2007 11:46:47 -0400
Content-Disposition: inline
In-Reply-To: <20070717214239.GF28448@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org

On Tue, Jul 17, 2007 at 05:42:39PM -0400, Jeff Garzik wrote:
> commit ae97fec3701a559929c3529e35417fab133a4d39
> Author: Jeff Garzik <jeff@garzik.org>
> Date:   Tue Jul 17 01:08:29 2007 -0400
> 
>     drivers/usb/misc/auerswald: fix status check, remove redundant check
>     
>     1) We should only set 'actual_length' output variable if usb length is
>     known to be good.
>     
>     2) No need to check actual_length for NULL.  The only caller always
>     passes non-NULL value.
>     
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>

I have no objection to this patch at all, however it does not remove the
compiler warning :(

thanks,

greg k-h
