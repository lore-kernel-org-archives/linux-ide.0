From: Chris Dearman <chris@linux-mips.org>
Subject: [PATCH 0/1] sata_sil: Option to use IO space to access TF registers.
Date: Wed, 22 Oct 2008 11:23:34 -0700
Message-ID: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dns1.mips.com ([63.167.95.197]:36705 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbYJVSaa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 14:30:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

I'm working on a board where byte reads from the processor get
converted into word reads on the PCI bus. This doesn't mix well
with reading the TaskFile registers...

IO space reads do generate the correct byte enables so this patch
gives the option of accessing the TF registers via IO space.

I'm not sure if its worth adding this to the driver... it's a work
around for the "unfortunate" PCI behaviour on this board, but there
may be other challenged hardware out there, so it might be worth
considering. 

Chris
