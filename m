From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ATA] Rename routerboard 500 to 532
Date: Tue, 29 Apr 2008 02:18:15 -0400
Message-ID: <4816BDA7.4020204@garzik.org>
References: <20080428114136.GA4766@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51613 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541AbYD2GSv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 02:18:51 -0400
In-Reply-To: <20080428114136.GA4766@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-ide@vger.kernel.org, Gabor Juhos <juhosgatopenwrt.org@linux-mips.org>, Florian Fainelli <florian@openwrt.org>

Ralf Baechle wrote:
> The platform is actually named routerboard 532 so let's call it this.  This
> patch only rename files, Kconfig and C symbols; no functional changes.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  drivers/ata/Kconfig         |    8 -
>  drivers/ata/Makefile        |    2 
>  drivers/ata/pata_rb500_cf.c |  277 --------------------------------------------
>  drivers/ata/pata_rb532_cf.c |  277 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 282 insertions(+), 282 deletions(-)

applied


