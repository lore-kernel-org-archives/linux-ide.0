From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_amd: remove contamination added during cable_detect
 conversion
Date: Sat, 28 Apr 2007 14:46:29 -0400
Message-ID: <46339685.7080009@garzik.org>
References: <20070422170438.GK10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53372 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161255AbXD1Sqb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:46:31 -0400
In-Reply-To: <20070422170438.GK10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> This is added by added by cff63dfceb52c564fe1ba5394d50ab7d599a11b9
>  - pata: cable methods.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/pata_amd.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

applied


