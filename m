From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_isapnp: use MODULE_DEVICE_TABLE()
Date: Thu, 2 Aug 2007 13:00:31 +0100
Message-ID: <20070802130031.29cbdbd1@the-village.bc.nu>
References: <20070802110606.GA26087@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34892 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752108AbXHBLxU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 07:53:20 -0400
In-Reply-To: <20070802110606.GA26087@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2 Aug 2007 07:06:07 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> I found this while doing ISDN PCI API conversions...  I presume this
> omission was not intentional?
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Looks fine to me 

Alan
