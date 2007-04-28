From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 06/10] pata_hpt37x: Further small fixes
Date: Sat, 28 Apr 2007 15:17:00 -0400
Message-ID: <46339DAC.4090402@garzik.org>
References: <200704260719.l3Q7JPB2023694@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53683 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084AbXD1TRC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 15:17:02 -0400
In-Reply-To: <200704260719.l3Q7JPB2023694@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Further HPT37x changes
> 
> - No 66MHz 370/370A
> - Remove dead special case check now we use the DPLL (as per the IDE driver)
> 
> Pointed out by Sergei
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_hpt37x.c |   23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

applied 6-7


