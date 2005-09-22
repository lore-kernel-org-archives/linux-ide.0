From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Thu, 22 Sep 2005 16:08:53 +0100
Message-ID: <1127401733.18840.116.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <20050921192932.GB13246@flint.arm.linux.org.uk>
	 <1127347845.18840.53.camel@localhost.localdomain>
	 <20050922102221.GD16949@flint.arm.linux.org.uk>
	 <1127396382.18840.79.camel@localhost.localdomain>
	 <1127398876.8242.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:48320 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030382AbVIVOmZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 10:42:25 -0400
In-Reply-To: <1127398876.8242.74.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Mark Lord <liml@rtr.ca>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Iau, 2005-09-22 at 15:21 +0100, Richard Purdie wrote:
> 1. Are ide-cs devices removable or not. See above.

Having done testing on the cards I have based on RMK's suggestion I
agree they are not removable except for specific cases (IDE PCMCIA cable
adapter plugged into a Syquest). That case is already handled in the
core code.

The fact cache flushing is all odd now is I guess bug 4. on the list but
easy to fix while fixing 1

Alan

