From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/1] sata_sil: Option to use IO space to access TF
 registers.
Date: Wed, 22 Oct 2008 22:16:23 +0100
Message-ID: <20081022221623.344aea62@lxorguk.ukuu.org.uk>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:32854 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752956AbYJVVQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 17:16:51 -0400
In-Reply-To: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Dearman <chris@linux-mips.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

> I'm not sure if its worth adding this to the driver... it's a work
> around for the "unfortunate" PCI behaviour on this board, but there
> may be other challenged hardware out there, so it might be worth
> considering. 

You need to fix your ioread8/iowrite8 and other accessors to work around
this if at all possible and that will cover all your devices.

Alan
