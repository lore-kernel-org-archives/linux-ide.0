From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_rdc: driver for RDC ATA devices
Date: Wed, 24 Jun 2009 19:38:23 -0400
Message-ID: <4A42B8EF.1010100@garzik.org>
References: <20090624172930.24354.80799.stgit@t61.ukuu.org.uk>	 <4A42800D.6020202@garzik.org> <20090624235548.681b8992@lxorguk.ukuu.org.uk> <1245886425.29098.117.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39878 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756755AbZFXXht (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jun 2009 19:37:49 -0400
In-Reply-To: <1245886425.29098.117.camel@Joe-Laptop.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, kevin.huang@rdc.com.tw, greg@kroah.com, Linux IDE mailing list <linux-ide@vger.kernel.org>

Joe Perches wrote:
> On Wed, 2009-06-24 at 23:55 +0100, Alan Cox wrote:
>>> Seems fine and fairly straightforward to me.  My lone comment -- go 
>>> through and replace magic numbers with named constants, for e.g. the PCI 
>>> config registers that program timings...
>> Its based on your ata_piix driver. Feel free to update that and I'll pull
>> names and things across to match.
> 
> I sent a few patches to Jeff privately to do just that.
> 
> I'm waiting for Jeff to see if he wants me to post
> them publicly or not.

Always post patches publicly...  private mail is easily lost, left 
undiscussed and unarchived, etc.


> Jeff, your email address in MAINTAINERS is jgarzik@pobox.com.
> Should it be changed to redhat.com or garzik.org or left as is.

MAINTAINERS is accurate :)

	Jeff



