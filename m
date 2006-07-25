From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Fwd: - ide-remove-dma_base2-field-form-ide_hwif_t.patch
	removed from -mm tree]
Date: Tue, 25 Jul 2006 19:25:49 +0100
Message-ID: <1153851949.4725.6.camel@localhost>
References: <44C52CCE.7070204@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57312 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750743AbWGYRYX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jul 2006 13:24:23 -0400
In-Reply-To: <44C52CCE.7070204@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, Jes Sorensen <jes@sgi.com>, Brent Casavant <bcasavan@sgi.com>, jpk@sgi.com, Andrew Morton <akpm@osdl.org>, Linux IDE <linux-ide@vger.kernel.org>

On Maw, 2006-07-25 at 00:25 +0400, Sergei Shtylyov wrote:
> Hello.
> 
>     Alan and Andrew wanted me to coordinate the change with SGI before 
> recasting this patch because the sgiioc4.c is the only real user of the
> 'dma_base2' field which the IDE maintaner wanted me to remove. The use of
> this field in this driver doesn't seem necessary or even well grounded -- 
> hwif_data seem to fit the task better... Will you ACK this change?

The change looks good to me. 

Alan

