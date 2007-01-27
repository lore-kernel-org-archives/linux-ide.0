From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ahci: Marvell 6145 SATA support (preliminary)
Date: Sat, 27 Jan 2007 13:43:46 +0000
Message-ID: <20070127134346.71d8ecf4@localhost.localdomain>
References: <20070127034023.GA25959@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45811 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751639AbXA0NcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Jan 2007 08:32:05 -0500
In-Reply-To: <20070127034023.GA25959@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> Were it not for the PATA and interrupt storm bits, I would say that
> Marvell 6145 works with a simple PCI ID addition.


The 6101 driver should drive the 6145 pata port via the legacy registers
