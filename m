From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/15] ali14xx: fix deadlock on error handling
Date: Tue, 2 Oct 2007 14:47:10 +0100
Message-ID: <20071002144710.7a3ade9a@the-village.bc.nu>
References: <200710012331.26965.bzolnier@gmail.com>
	<47023DA4.1020607@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51872 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752403AbXJBNl6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 09:41:58 -0400
In-Reply-To: <47023DA4.1020607@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Tue, 02 Oct 2007 16:46:28 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Bartlomiej Zolnierkiewicz wrote:
> 
> > Stop abusing ide_lock lock by switching to a private locking.
> 
> > Fixes same issue as fixed by Alan Cox in atiixp host driver with
> 
>     Has been also fixed in the piix driver.
> 
> > commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.
> 
>     Heh, I've looked hard at the code trying to understand how this can 
> happen, and was unable to figure out. Probably was not hard enough...

The old IDE code timer, error handling and interrupt paths all race each
other. Anything can happen including this.

The proper fix is to rewrite the error handling but it was easier to port
the drivers to working error handling instead - hence libata PATA

Alan
