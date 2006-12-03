From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Sun, 3 Dec 2006 23:07:20 +0000
Message-ID: <20061203230720.65832f93@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061203171216.GB21947@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2534 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1760150AbWLCXAN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 18:00:13 -0500
In-Reply-To: <20061203171216.GB21947@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

> I modified pci_request_regions to request only the first 5 regions.
> Now the detection works, but access to the drive does not work:

Some drives do that with the new EH code. Its ATAPI specific and I don't
know why. With the older libata it all works. It may also be a driver bug
but since it also pops up all over the place with the new EH code and not
the old its damn near impossible to debug any PATA problems that look
like this at the moment.

Alan
