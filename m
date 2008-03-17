From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: PCI device should be
 powered up before being accessed
Date: Mon, 17 Mar 2008 15:00:01 +0000
Message-ID: <20080317150001.552904bd@core>
References: <47D667DA.8050905@gmail.com>
	<47DE6300.4070004@garzik.org>
	<47DE65A5.8030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33276 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbYCQPOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 11:14:48 -0400
In-Reply-To: <47DE65A5.8030704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>


> > Did Alan ACK this?
> 
> ISTR he did.  Alan?

Sorry I've been travelling most of the past 2 weeks. I'm all for this
going into .26. If it causes any problems (unlikely) we'll just fix them
in -mm before hand.

Alan
