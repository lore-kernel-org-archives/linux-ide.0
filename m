From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt3x3: Major reworking and testing
Date: Tue, 03 Jul 2007 11:40:11 -0400
Message-ID: <468A6DDB.706@garzik.org>
References: <20070703161002.1576c39d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33074 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759374AbXGCPkO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 11:40:14 -0400
In-Reply-To: <20070703161002.1576c39d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The HPT343/345 (aka 363) is a bit of a warped device. For many setups you
> need to access the other registers via BAR4 offsets. PIO is now rock
> solid, DMA isn't. Unfortunately the drivers/ide hpt34x driver is
> completely broken so doesn't help further debug.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

OK but doesn't apply


