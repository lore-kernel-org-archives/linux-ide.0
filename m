From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] libata: implement support for 32-bit PIO transfers
Date: Sun, 17 Feb 2008 22:32:39 +0000
Message-ID: <20080217223239.1f04e095@core>
References: <20080217211810.GA15001@1wt.eu>
	<20080217212004.GB15327@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49773 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753967AbYBQWlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 17:41:04 -0500
In-Reply-To: <20080217212004.GB15327@1wt.eu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 17 Feb 2008 22:20:04 +0100
Willy Tarreau <w@1wt.eu> wrote:

> 
> >From 4ea313fe6a3c46a90226cf40d0e3ece4b36b48f9 Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sun, 17 Feb 2008 21:28:25 +0100
> Subject: [PATCH 2/2] libata: implement support for 32-bit PIO transfers
> 
> When ATA_DFLAG_32BIT_PIO is set in ata flags, PIO transfers
> will be performed in 32-bit, just like with the plain old IDE
> drivers.

Acked-by: Alan Cox <alan@redhat.com>

Although I think ata_data_xfer_32() would be safer and easier to add to
controllers as we check the docs. But that can be a follow up improvement.

Alan
