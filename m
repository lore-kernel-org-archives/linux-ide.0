From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious
 IRQs
Date: Wed, 26 Nov 2008 10:33:46 +0000
Message-ID: <20081126103346.409e443e@lxorguk.ukuu.org.uk>
References: <49263552.8090602@kernel.org>
	<492C30FC.2090200@garzik.org>
	<20081125171559.222e499f@lxorguk.ukuu.org.uk>
	<492CB84C.8090706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55547 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751113AbYKZKdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Nov 2008 05:33:47 -0500
In-Reply-To: <492CB84C.8090706@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Well, the BMDMA status register read and cleared iff no qc is in
> flight so the patch isn't likely to break any of that.  That said,
> it's true that this is a big change this late in the release cycle.

Well the kind of thing that bothers me is disk corruption. On the PIIX4
for example a simple read of some of the control registers during a PIO
block transfer corrupts the data silently.... (See errata #15).

Alan
