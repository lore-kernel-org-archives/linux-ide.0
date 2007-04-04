From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_pdc2027x: Bring into line with changes, add the
 mode filters as per Jeff's report
Date: Wed, 04 Apr 2007 01:47:56 -0400
Message-ID: <46133C0C.8050302@pobox.com>
References: <20070323190718.1475f23b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41514 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992639AbXDDFsA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 01:48:00 -0400
In-Reply-To: <20070323190718.1475f23b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> - Fix theoretical pdc2027x crash if the BIOS didn't assign BAR4 for DMA. (Needs a default modefilter)
> - Use cable methods
> - Replace post_set_mode() use with wrapped set_mode() [Removes last use of post_set_mode]
> - Mode filter Maxtor UDMA133 rule

ACK, ditto "confusion" comment


