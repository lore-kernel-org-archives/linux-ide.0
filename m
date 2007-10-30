From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Deal with ATA8-ACS proposed Trusted/Treacherous
 Computing features
Date: Tue, 30 Oct 2007 13:32:13 +0000
Message-ID: <20071030133213.28b28d14@the-village.bc.nu>
References: <20071012173918.3f6d2760@the-village.bc.nu>
	<4727314B.1090801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40765 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbXJ3Na2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 09:30:28 -0400
In-Reply-To: <4727314B.1090801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> > Finally as with CPRM print a warning so that the user knows they may not
> > be able to full access and use the device.
> > 
> > Alan
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> seems fairly reasonable... 2.6.24-rc?

I think so yes.

Alan
