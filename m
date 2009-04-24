From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Enable parallel scan on ata_piix
Date: Fri, 24 Apr 2009 12:28:22 +0100
Message-ID: <20090424122822.64b143c7@lxorguk.ukuu.org.uk>
References: <20090423214411.515310df@infradead.org>
	<49F19491.2030901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46674 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751419AbZDXL2h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2009 07:28:37 -0400
In-Reply-To: <49F19491.2030901@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org

> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> I tend to doubt "safe", given the complicated and buggy silicon state 
> machine that recreates the legacy IDE interface on SATA...

The two channels on the ICH and PIIX are independant. There are other
controllers that have all sorts of nasty dependancies and shared state,
and there is also a bug/known limitation in the case of simplex hardware
- we don't honour the can queue checks during probing.

Alan
