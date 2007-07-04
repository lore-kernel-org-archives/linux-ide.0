From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream] libata: simplify PCI legacy SFF
 host handling
Date: Wed, 4 Jul 2007 10:39:17 +0100
Message-ID: <20070704103917.286c9b62@the-village.bc.nu>
References: <468B620F.3010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49871 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756326AbXGDJdG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:33:06 -0400
In-Reply-To: <468B620F.3010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> Gee, I like it.  The BAR fixup thing was a really good idea.  :-)


Told you it would 8)

Looks good to me

Acked-by: Alan Cox <alan@redhat.com>



[Jeff - this replaces the minimal tweak I sent out to use the PCI
 resources set by the pci layer and does the lot properly so drop the
 little patch of mine]
