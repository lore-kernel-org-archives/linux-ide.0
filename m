From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sil680: PIO1 taskfile transfers oveclocking fix
Date: Sun, 28 Jan 2007 18:41:38 +0000
Message-ID: <20070128184138.512b13f7@localhost.localdomain>
References: <200701282024.17518.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54813 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752478AbXA1Sbz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 13:31:55 -0500
In-Reply-To: <200701282024.17518.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, 28 Jan 2007 20:24:17 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Fix PIO mode 1 overclocked taskfile transfers -- probably a typo carried over
> from drivers/ide/pci/siimage.c where I've found it by documentation check...
> 
>  drivers/ata/pata_sil680.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 

Looks right to me , thanks - but does need a signoff
