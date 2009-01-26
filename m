From: Mark Lord <liml@rtr.ca>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Mon, 26 Jan 2009 18:56:50 -0500
Message-ID: <497E4DC2.1090708@rtr.ca>
References: <20090120002923.065f24ca@diego-desktop> <497E0940.3020409@ij.net> <497E14DD.20506@rtr.ca> <200901261557.42752.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:50314 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbZAZX4x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 18:56:53 -0500
In-Reply-To: <200901261557.42752.gene.heskett@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Felix Miata <mrmazda@ij.net>, linux-ide@vger.kernel.org

Gene Heskett wrote:
..
> Should I be worried about this one? Seagate 500GB sata
> 
> /dev/sdb:
> 
> ATA device, with non-removable media
>         Model Number:       ST3500320AS
>         Serial Number:      9QM5BB7Y
>         Firmware Revision:  SD15
>         Transport:          Serial
..

According to Seagate, that particular unit has a 1/320 chance
of being bricked at power-on, so.. yeah, I'd worry.

But there's a simple bootable .iso image with a firmware-updater on it
(along with an exceptionally confusing README, which you should ignore)
at these links:

http://seagate.custkb.com/seagate/crm/selfservice/search.jsp?DocId=207951
http://support.seagate.com/firmware/MooseDT-SD1A-2D-8-16-32MB.ISO

Cheers
