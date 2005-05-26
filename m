From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CSB5 IDE does not fully support native mode??
Date: Thu, 26 May 2005 18:22:03 +0100
Message-ID: <1117128122.5743.158.camel@localhost.localdomain>
References: <200505242026.DJT32107@ms3.netsolmail.com>
	 <1117117463.5743.149.camel@localhost.localdomain>
	 <200505261055.38137.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:40113 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261655AbVEZRYX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 May 2005 13:24:23 -0400
In-Reply-To: <200505261055.38137.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: evt@texelsoft.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Iau, 2005-05-26 at 17:55, Bjorn Helgaas wrote:
> This has been niggling in my mind for a while -- in legacy mode,
> the device should use IRQ 14/15.  But I think we still call
> pci_enable_device(), which sets up IRQ routing according to
> the usual PCI rules.  Should we be using pci_enable_device()
> at all in legacy mode?

For all the other enables yes. The IRQ is an interesting case and I'd
have to look into the newer code to even guess - Bartlomiej has probably
has a much better idea as maintainer.

