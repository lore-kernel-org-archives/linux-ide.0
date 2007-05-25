From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sil680 MMIO changes moved to branch
Date: Fri, 25 May 2007 15:11:34 +0100
Message-ID: <20070525151134.730a15d2@the-village.bc.nu>
References: <4656591A.6090701@garzik.org>
	<1180066312.32247.1098.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57264 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752106AbXEYOGq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 10:06:46 -0400
In-Reply-To: <1180066312.32247.1098.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Fine with me. I've been busy with other things and waiting for you and
> Alan to decide what should be done for the reset stuff anway :-)
> 
> So Alan, do you think we should add something or do you think that just
> reading altstat like ata_pause does is good enough ?

Reading altstat is unneccessary for PIO so we do want to get these
changes in so we can sort out performance of command sending, pause and
anything else where it would help.

The PDC driver may well want to use altstatus reads for this but thats
driver specific.
