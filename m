From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pci: rename __pci_reenable_device() to pci_reenable_device()
Date: Wed, 01 Aug 2007 10:02:05 -0400
Message-ID: <46B0925D.1070102@garzik.org>
References: <20070710063605.GA21994@htj.dyndns.org>	<20070710065543.GA23568@htj.dyndns.org>	<46A66842.6040803@garzik.org> <20070724225747.1dd4d141@the-village.bc.nu> <46A677C3.9090107@garzik.org> <46A98607.7000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41651 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbXHAOCK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 10:02:10 -0400
In-Reply-To: <46A98607.7000401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Tejun Heo wrote:
> Rename __pci_reenable_device() to pci_reenable_device().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, Greg wanted to drop the preceding underscores before exporting
> the function and the updated patch was posted but the earlier version
> was applied.  This patch renames the function.

applied these three to #upstream-fixes


