From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Tue, 25 Sep 2007 03:08:40 -0400
Message-ID: <46F8B3F8.1050909@garzik.org>
References: <200709251323031982245@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41756 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbXIYHIm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 03:08:42 -0400
In-Reply-To: <200709251323031982245@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <peerchen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Peer Chen wrote:
> Add the ahci controller legacy mode support to sata_nv.
> Move the DIDs of legacy mode from ahci.c to sata_nv.c
> 
> The patch base on kernel 2.6.23-rc8
> 
> Signed-off-by: Peer Chen <peerchen@gmail.com>

I don't understand why these are being moved?

If an interface can be driven via the AHCI driver, that is greatly 
preferred over the sata_nv driver.

	Jeff



