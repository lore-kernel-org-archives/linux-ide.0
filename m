From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 25/30] pata_hpt3x3: clean up by using cable method
Date: Tue, 06 Mar 2007 06:59:54 -0500
Message-ID: <45ED57BA.4000800@garzik.org>
References: <200703061038.l26AcAVD019539@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53727 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933233AbXCFL74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:59:56 -0500
In-Reply-To: <200703061038.l26AcAVD019539@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_hpt3x3.c |   22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)

dropped patches 9-25.

they should all be rolled up into a single "update ->cable_detect hook" 
patch, as discussed.


