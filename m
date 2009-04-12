From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 0/3] libahci and friends
Date: Sun, 12 Apr 2009 13:37:12 -0400
Message-ID: <49E226C8.2000308@garzik.org>
References: <20090412172453.GA5763@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51435 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbZDLRhQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Apr 2009 13:37:16 -0400
In-Reply-To: <20090412172453.GA5763@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Sagar Borikar <sagar.borikar@gmail.com>


This patchset creates libahci, as mentioned in the recent NVMHCI thread:
http://marc.info/?l=linux-kernel&m=123947130114037&w=2

Although these changes help set the groundwork for NVMHCI support, they 
are also more immediately useful in three cases:

- Marvell PATA support.  Marvell 6101, 6121, 6145 (and others?) added a 
PATA support to an existing AHCI SATA design.  The controller supports 
both PATA and SATA.  SATA is compatible with AHCI.  PATA uses new DMA 
data structures and reset methods.

- ACard support.  ATP 8620 is a 99% AHCI clone, that primarily differs 
in its DMA data structures.

- non-PCI support.  Sagar Borikar posted some preliminary work, getting 
AHCI going on a non-PCI bus.  My libahci work should hopefully assist 
Sagar.  http://marc.info/?l=linux-ide&m=123807608819226&w=2

Regards,

	Jeff



