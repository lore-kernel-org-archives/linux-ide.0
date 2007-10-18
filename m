From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_acpi: fix build breakage if !CONFIG_PM
Date: Wed, 17 Oct 2007 20:57:39 -0400
Message-ID: <4716AF83.30607@garzik.org>
References: <20071017062416.GA18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33958 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522AbXJRA5m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 20:57:42 -0400
In-Reply-To: <20071017062416.GA18322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Avuton Olrich <avuton@gmail.com>

Tejun Heo wrote:
> There are configurations where CONFIG_ACPI but !CONFIG_PM.  In this
> case, pata_acpi can be selected but won't build.  Fix it.
> 
> Reported by Avuton Olrich.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Avuton Olrich <avuton@gmail.com>
> ---
>  drivers/ata/pata_acpi.c |    2 ++
>  1 file changed, 2 insertions(+)

applied


