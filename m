From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI
 devices
Date: Wed, 3 Jan 2007 01:07:24 +0000
Message-ID: <20070103010724.19b17522@localhost.localdomain>
References: <200701021939.10496.liml@rtr.ca>
	<459AFDC2.6060900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37290 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752581AbXACA5N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 19:57:13 -0500
In-Reply-To: <459AFDC2.6060900@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

> I do not wish to completely eliminate the current behavior, which passes 
> through all opcodes to the ATAPI device.  You cannot guarantee that 
> ATA_16 is never used for a vendor-reserved opcode, for example.

For 16 byte commands via SG_IO you know the command is 16 bytes long as
the command length is passed in hdr->cmd_len which becomes rq->cmd_len.
Is that not sufficient to avoid this ATA_16 test if you pass it on to the
required functions ?

Alan
