From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 0/3] libata: add taskfile protocol ->proto_mask info member
Date: Sat, 14 Jul 2007 04:15:26 -0400
Message-ID: <20070714081526.GA26878@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:54681 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbXGNIP1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 04:15:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>


These patches add proto_mask alongside pio_mask, mwdma_mask, and
udma_mask.  This is a more uniform way to export which features host
controllers support (DMA? NCQ? ATAPI? ATAPI DMA?), rather than creating
a new ATA_FLAG_xxx for each.

This also opens the door to useful things like combining "if
protocol==foo || protocol==bar" tests into a single mask, or masking
between host and device to determine common protocols.

Suggestions for improvement welcome, this is just the first cut.  Stored
on libata-dev.git#pmask for now.

	Jeff




