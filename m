From: Olaf Hering <olaf@aepfle.de>
Subject: Re: request_queue_t depends on CONFIG_BLOCK
Date: Fri, 23 Mar 2007 20:14:28 +0100
Message-ID: <20070323191428.GA23413@aepfle.de>
References: <20070322215234.GA13219@aepfle.de> <20070322215351.GA7216@infradead.org> <20070323001002.GA14583@aepfle.de> <200703231929.19406.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43198 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbXCWTOT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 15:14:19 -0400
Content-Disposition: inline
In-Reply-To: <200703231929.19406.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, Mar 23, Bartlomiej Zolnierkiewicz wrote:

> > Because it is needed in a few places.
> 
> Is there really any PPC64 specific code which needs <linux/ide.h>
> (ppc_ide_md is used only by PPC32)?

This is about CONFIG_BLOCK=n, not about arch/... Is all non-driver
code which has to poke into ide code supposed to put an #ifdef
CONFIG_IDE around #include <linux/ide.h>?

