From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5 1/2] sata_promise: cleanups
Date: Tue, 03 Jul 2007 10:13:20 -0400
Message-ID: <468A5980.60709@garzik.org>
References: <200706191953.l5JJrU4K002663@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60290 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387AbXGCONX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:13:23 -0400
In-Reply-To: <200706191953.l5JJrU4K002663@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch applies some trivial cleanups to sata_promise:
> - repair whitespace damage
> - correct comment at board_2057x_pata definition
> - pull SATAII TX4 support code out to separate functions
> - rename ata_nr to ata_no for consistency with libata's port_no
> - remove some init-time debug printks (requested by Jeff)
> 
> This patch should cause no behavioural changes, except for
> the removed printks.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> --
>  drivers/ata/sata_promise.c |   56 ++++++++++++++++++---------------------------
>  1 files changed, 23 insertions(+), 33 deletions(-)

applied


