From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Sun, 27 May 2007 22:21:05 -0400
Message-ID: <465A3C91.7020002@garzik.org>
References: <20070515061239.611A2DDEE9@ozlabs.org>	<1179209697.32247.153.camel@localhost.localdomain>	<20070523144217.5abd9fdf@the-village.bc.nu>	<1179960518.32247.948.camel@localhost.localdomain>	<20070524003123.77b9c81c@the-village.bc.nu>	<1179963820.32247.996.camel@localhost.localdomain>	<20070524001302.GA18571@devserv.devel.redhat.com>	<1179978137.32247.1035.camel@localhost.localdomain>	<20070524105407.64514929@the-village.bc.nu>	<46556E5D.3070203@pobox.com>	<20070524120915.40b594a8@the-village.bc.nu>	<46562E03.3020503@garzik.org>	<20070525014027.3feabe50@the-village.bc.nu>	<4656330E.2000604@garzik.org> <20070525152028.05b79c83@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42742 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbXE1CVJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 May 2007 22:21:09 -0400
In-Reply-To: <20070525152028.05b79c83@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux IDE <linux-ide@vger.kernel.org>

Alan Cox wrote:
> Correct, but it is also extremely slow. No point discussing fast paths
> for odd if() tests through the code when you burn 100nS unneccessarily
> every time you issue a command via PIO is there.

BTW if you wanna start PIO speed tuning, ISTR the device-select code 
does not cache selections.  We always unconditionally select a device 
before a command in ata_qc_issue_prot(), IIRC.

ISTR for some cases this was intentional (following ATADRVR) but I bet 
adding code to -not- select a device, if it is already selected, would 
speed things up on slow PATA machines.

ata_qc_issue_prot() and ata_dev_select() would be starting points if 
you're interested.

	Jeff




