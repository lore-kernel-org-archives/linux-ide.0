From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata error messages?
Date: Thu, 9 Aug 2007 18:17:34 +0100
Message-ID: <20070809181734.736e8ed4@the-village.bc.nu>
References: <5E26159C-2122-4FE3-9CBF-F50644B7EE5C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57515 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932890AbXHIRKL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 13:10:11 -0400
In-Reply-To: <5E26159C-2122-4FE3-9CBF-F50644B7EE5C@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linux-ide@vger.kernel.org

On Thu, 9 Aug 2007 10:59:12 -0500
Kumar Gala <kumar.gala@freescale.com> wrote:

> I'm trying to figure out what could cause the following error  
> messages.  This is on a PPC host using a ULI 1575 southbridge:

I'm still chasing problems with ATAPI DMA on some ALi host bridges. I'd
like to say I knew what was going on but the truth is I'm currently
diffing lspci out and staring at spec sheets with little result.

