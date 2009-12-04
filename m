From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pata_cs5520: use ATA_DMA_* constants
Date: Fri, 4 Dec 2009 23:26:36 +0000
Message-ID: <20091204232636.5171bc15@lxorguk.ukuu.org.uk>
References: <200912042339.00746.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58694 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932409AbZLDXYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2009 18:24:45 -0500
In-Reply-To: <200912042339.00746.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sat, 5 Dec 2009 00:39:00 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Use ATA_DMA_* constants instead of the bare numbers for the BMIDE registers.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

If we are dropping out the virtual DMA support as Bartlomiej proposed
that bit can go completely.

Alan
