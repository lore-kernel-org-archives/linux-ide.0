From: Jeff Garzik <jeff@garzik.org>
Subject: Re: seagate disks on sil3114 - slow?
Date: Thu, 18 Oct 2007 01:07:49 -0400
Message-ID: <4716EA25.7060205@garzik.org>
References: <1192683290.5720.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42742 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbXJRFHw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 01:07:52 -0400
In-Reply-To: <1192683290.5720.38.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
> Dear all,
> 
> I just now realize that all disk i.o. on my machine is quite slow
> compared with the pata disks I had before. Furthermore I recognized that
> I only have seagates (ST3400832AS,ST3400620AS,ST3750640AS,ST3750640AS)
> connected to a sil3114 controller.
> 
> Being on kernel 2.6.23.1 and stumbling across
> http://home-tj.org/wiki/index.php/Sil_m15w I am now wondering if this
> patch made it already in kernel (or when it will make it if it is not
> yet in/why never).

Are you sure you have a 3114?  the mod15write isn't applied to that chip.

Does your dmesg say "applying Seagate errata fix (mod15write workaround)" ?

	Jeff




