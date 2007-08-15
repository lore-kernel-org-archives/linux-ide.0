From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 24/25] pata_cmd64x: Set up MWDMA modes properly
Date: Wed, 15 Aug 2007 03:46:31 -0400
Message-ID: <46C2AF57.7060609@garzik.org>
References: <200708102059.l7AKxnUd008639@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36992 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268AbXHOHqd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 03:46:33 -0400
In-Reply-To: <200708102059.l7AKxnUd008639@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, mikpe@it.uu.se

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Set the MWDMA timing by updating the correct registers.  Split the PIO path as
> this is mostly shared code.  Wants testing.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Tested-by: Mikael Pettersson <mikpe@it.uu.se>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_cmd64x.c |   37 +++++++++++++++++++++++++-----------
>  1 files changed, 26 insertions(+), 11 deletions(-)

applied

not sure why Alan's original patch did not apply, but this one did


