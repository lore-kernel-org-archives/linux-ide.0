From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sis: Remove bogus cable match
Date: Mon, 8 Dec 2008 11:39:35 +0000
Message-ID: <20081208113935.156d4baf@lxorguk.ukuu.org.uk>
References: <20081205194117.17036.74479.stgit@localhost.localdomain>
	<49398FAC.2060301@garzik.org>
	<20081206002705.46052575@lxorguk.ukuu.org.uk>
	<200812081213.56499.kai@kaishome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59919 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754185AbYLHLje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 06:39:34 -0500
In-Reply-To: <200812081213.56499.kai@kaishome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kai Krakow <kai@kaishome.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> Is there away to bypass this bogus-detection and force the driver into using 
> high-speed mode on the short 40-wire cable? Maybe by introducing a 
> kernel/module parameter? Or is it there? I found nothing in the docs.
> 
> Can I provide any information you need to properly detect the Targa Visionary 
> 1000?

Thats why I cc'd you on the changes. I am sure we can find something to
identify this machine.

Can you send the output of dmidecode ?

Alan
