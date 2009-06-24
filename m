From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] pata_rdc: driver for RDC ATA devices
Date: Wed, 24 Jun 2009 16:33:45 -0700
Message-ID: <1245886425.29098.117.camel@Joe-Laptop.home>
References: <20090624172930.24354.80799.stgit@t61.ukuu.org.uk>
	 <4A42800D.6020202@garzik.org> <20090624235548.681b8992@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1149 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbZFXXev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 19:34:51 -0400
In-Reply-To: <20090624235548.681b8992@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, kevin.huang@rdc.com.tw, greg@kroah.com, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Wed, 2009-06-24 at 23:55 +0100, Alan Cox wrote:
> > Seems fine and fairly straightforward to me.  My lone comment -- go 
> > through and replace magic numbers with named constants, for e.g. the PCI 
> > config registers that program timings...
> 
> Its based on your ata_piix driver. Feel free to update that and I'll pull
> names and things across to match.

I sent a few patches to Jeff privately to do just that.

I'm waiting for Jeff to see if he wants me to post
them publicly or not.

btw:

Jeff, your email address in MAINTAINERS is jgarzik@pobox.com.
Should it be changed to redhat.com or garzik.org or left as is.

$ git log --since=1-year-ago | grep -i "by:.*garzik" | \
	cut -f2- -d":" | sort | uniq -c | sort -rn
    865  Jeff Garzik <jgarzik@redhat.com>
     13  Jeff Garzik <jgarzik@pobox.com>
     13  Jeff Garzik <jeff@garzik.org>


