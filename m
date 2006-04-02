From: Dan Aloni <da-x@monatomic.org>
Subject: Re: sata_mv: module reloading doesn't work
Date: Sun, 2 Apr 2006 19:14:49 +0300
Message-ID: <20060402161449.GA21822@localdomain>
References: <20060402155647.GB20270@localdomain> <442FF65A.6020209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from noname.neutralserver.com ([70.84.186.210]:13166 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932376AbWDBQNa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Apr 2006 12:13:30 -0400
Content-Disposition: inline
In-Reply-To: <442FF65A.6020209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sun, Apr 02, 2006 at 12:05:46PM -0400, Mark Lord wrote:
> Dan Aloni wrote:
> >Hello,
> >
> >I'm testing the sata_mv driver to see whether reloading (rmmod 
> >- insmod) works, and it seems something is broken there. The
> >first insmod goes okay - however all the insmods that follow
> >emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady 
> >SeekComplete } from all the drives.
> >
> >I've enabled DPRINTK and fixed a crash involved with register
> >dumping (posted in my previous mail).
> >
> >I hope these messages are sufficient, I can provide more 
> >information if needed.
> 
> What kernel?  Any patches applied to sata_mv.c ??
> 

2.6.16 + ncq branch. sata_mv.c was modified by me - I'll retry
with a cleaner configuration, sorry.

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
