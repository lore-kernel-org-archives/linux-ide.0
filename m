From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] [libata] Add irq_flags to struct pata_platform_info
Date: Tue, 03 Jul 2007 10:13:31 -0400
Message-ID: <468A598B.6050905@garzik.org>
References: <1181900749.23447.7.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60298 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759047AbXGCONd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:13:33 -0400
In-Reply-To: <1181900749.23447.7.camel@sevens.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Sonic Zhang wrote:
> On some embedded platforms, such as blackfin, the gpio interrupt for
> IDE interface is designed to be triggered with high voltage. The gpio
> port should be configured properly by set_irq_type() when register
> the irq. This patch enable the generic pata platform driver to
> accept platform irq flags data.
> 
> Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
> ---
>  drivers/ata/pata_platform.c   |    6 ++++--
>  include/linux/pata_platform.h |    5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)

applied


