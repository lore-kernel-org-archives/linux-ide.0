From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core: Don't have screaming fits over DF/ERR
 combinations
Date: Mon, 15 Oct 2007 21:58:16 +0100
Message-ID: <20071015215816.101ad11d@the-village.bc.nu>
References: <20071015192313.5892ed42@the-village.bc.nu>
	<4713C549.6010704@ru.mvista.com>
	<4713C74F.3020205@pobox.com>
	<4713C821.6090303@ru.mvista.com>
	<4713C910.1070909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56568 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486AbXJOUys (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 16:54:48 -0400
In-Reply-To: <4713C910.1070909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, akpm@osdl.org

> Yes, hence the recent FIFO drain patches.
> 
> But that doesn't make sense for SATA devices, where the FIFO is really 
> emulated, and it works on older PATA devices.

The FIFO is emulated on PATA. Basically speaking the device prefetches
data and buffers the irq arrival until the right moment. Hence the need
to drain it on some chips. Others reset themselves in this case and post
reset a data read on some promise chips hangs the bus solid
