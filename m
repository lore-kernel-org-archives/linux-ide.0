From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] let BLK_DEV_AMD74XX depend on X86
Date: Thu, 11 Jan 2007 16:48:53 +0000
Message-ID: <20070111164853.5de4ddfa@localhost.localdomain>
References: <20070111134917.GE20027@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43434 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750725AbXAKQl4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 11:41:56 -0500
In-Reply-To: <20070111134917.GE20027@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 14:49:17 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> It's unlikely that this driver will ever be of any use on other 
> architectures.
> 
> This fixes the following compile error on ia64:

NAK

pci_get_legacy_ide_irq() is a required method for all platforms and is
usually filled in by asm-generic/pci.h

Please fix the IA64 tree to do the right thing.

Alan
