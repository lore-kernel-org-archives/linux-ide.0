From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sl82c105: wrong assumptions about compatible PIO
 modes
Date: Tue, 30 Jan 2007 19:27:27 +0000
Message-ID: <20070130192727.37778e52@localhost.localdomain>
References: <200701302040.30895.sshtylyov@ru.mvista.com>
	<20070130190759.3d941365@localhost.localdomain>
	<45BF979C.80200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57423 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751647AbXA3TP2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 14:15:28 -0500
In-Reply-To: <45BF979C.80200@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 30 Jan 2007 22:08:12 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>     You just said set_piomode() is called before set_dmamode() by the libata 
> core anyway -- there seems to be no point in re-writing the modes until the 
> actual DMA is started.

Agreed, I'll remove that bit of the code.

Alan
