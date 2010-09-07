From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] via82cxxx: fix typo for VT6415 PCIE PATA IDE Host
 Controller support.
Date: Mon, 06 Sep 2010 22:02:40 -0700 (PDT)
Message-ID: <20100906.220240.71572839.davem@davemloft.net>
References: <20100718232838.GA3245@home.lan>
	<20100718.165620.133871819.davem@davemloft.net>
	<20100719220736.GB3245@home.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36072
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463Ab0IGFCX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Sep 2010 01:02:23 -0400
In-Reply-To: <20100719220736.GB3245@home.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ydirson@free.fr
Cc: linux-ide@vger.kernel.org

From: Yann Dirson <ydirson@free.fr>
Date: Tue, 20 Jul 2010 00:07:37 +0200

> OTOH, we see here that the system believes in existence of "ide1",
> although the vt6415 appears to be single-channel
> (http://www.via.com.tw/en/products/peripherals/pci_pcie/vt6415/)

I think this is unlikely as the ATA layer pata_via.c driver also
does not mark this device as single-channel.

Have you tried just booting up with the ATA driver enabled instead
of the IDE layer one?  Please do that as it might help narrow this
down.
