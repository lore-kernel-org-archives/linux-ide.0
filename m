From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: drivers/ata/ahci.c driver questions / recommendations
Date: Sat, 8 Sep 2007 19:41:48 +0100
Message-ID: <20070908194148.20b1f5c2@the-village.bc.nu>
References: <324023.28314.qm@web35214.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37362 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753797AbXIHSd3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 14:33:29 -0400
In-Reply-To: <324023.28314.qm@web35214.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Adrian B. Weissman" <aweissma_ppc@yahoo.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> several of the various AHCI / Sata II controllers on
> PCI express card and build up a test suite.  Any
> pointers or recommendations would be greatly
> appreciated.

I would suggest taking that path as quite a few AHCI controllers aren't
quite AHCI compliant.

Alan
