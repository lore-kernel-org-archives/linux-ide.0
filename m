From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-dev.git clean up and branch status
Date: Fri, 25 Jul 2008 12:35:10 +0100
Message-ID: <20080725123510.183f65f8@lxorguk.ukuu.org.uk>
References: <468EDC76.9050708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60221 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752414AbYGYLxd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jul 2008 07:53:33 -0400
In-Reply-To: <468EDC76.9050708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> mv-ahci-pata	Marvell 6121/6141 AHCI clone PATA support
> 		Parent: mv-ahci
> 		Status: Need to update for proper use of PATA
> 			controller commands (provides direct access to
> 			PATA device shadow registers)

What is the status on this - we've now had the regression where you
can't use all of a marvell chip for over 6 months ?

Alan
