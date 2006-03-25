From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] libata: add @disable_on_err argument to
	ata_set_mode()
Date: Sat, 25 Mar 2006 23:58:14 +0000
Message-ID: <1143331095.28134.18.camel@localhost.localdomain>
References: <11431815313764-git-send-email-htejun@gmail.com>
	 <44240A67.7030001@pobox.com>
	 <1143215493.18986.11.camel@localhost.localdomain>
	 <20060325011432.GE5288@htj.dyndns.org>  <4424C12B.7070106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39834 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751979AbWCYXvW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Mar 2006 18:51:22 -0500
In-Reply-To: <4424C12B.7070106@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Gwe, 2006-03-24 at 23:03 -0500, Jeff Garzik wrote:
> BTW, got any PATA hardware lying about?  Since you're wandering into 
> xfer mode territory, it would better to test PATA than SATA, as xfer 
> mode matters more in the PATA realm.  Intel PATA should be fairly easy 
> to find, covered by ata_piix, and all the docs are on developer.intel.com.

I've got a fair amount of PATA stuff. If you want to play with failed
devices I'd suggest the best test device to work with is actually
something like the SIL680 with shared address setup. 

I've been watching the changes so far and the overall direction looks
right to me. As far as I can see from the PATA side of things the "we
care about another horked device on the bus" situation is

a) Extremely rare (I've almost never seen it on drivers/ide reports)
b) Usually a controller programming screwup (so wants fixing there)
c) With very few exceptions needs no special handling.

I can find no case where a set mode failure followed by a switch to PIO
0 on the controller for that device (which is right - the device didnt
switch so its in the old mode....), doesn't do the right thing.

Alan

