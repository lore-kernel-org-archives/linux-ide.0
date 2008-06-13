From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ahci.c
Date: Fri, 13 Jun 2008 04:49:26 -0400
Message-ID: <48523496.3090208@pobox.com>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41846 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668AbYFMItb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 04:49:31 -0400
In-Reply-To: <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dunneil <dunneil@live.cn>
Cc: linux-ide@vger.kernel.org

dunneil wrote:
> if there are two ASATA controller inside motherboard, it will cause 
> conflict
> for BUS Master Enable bit? Do i need disable the motherboard integrated 
> ASATA controoller for my separate ASATA controller FPGA board?

You can have as many AHCI PCI devices as you wish.

Each PCI device has its own Bus Master Enable bit in the PCI Command
register.

	Jeff



