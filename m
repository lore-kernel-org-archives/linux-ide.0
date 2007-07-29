From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream] libata: implement and use
 ata_port_desc() to report port configuration
Date: Sun, 29 Jul 2007 14:31:06 +0100
Message-ID: <20070729143106.446924ba@the-village.bc.nu>
References: <20070729103421.GG22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38218 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762207AbXG2NYE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 09:24:04 -0400
In-Reply-To: <20070729103421.GG22374@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> How about this?  It's much more flexible and drivers like ahci and
> sil24 can report something which make sense.

Looks as sane an approach. Some obvious errors in the conversion but
simply wrong types I/O v MMIO etc not flaws in the proposal

Unfortunately there is one big horror you've left unconverted - the status
address printing in ata_wait_... That is why I ended up going the way I
did.

Alan


