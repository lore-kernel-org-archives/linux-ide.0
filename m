From: Jeff Garzik <jeff@garzik.org>
Subject: Re: pata_ixp4xx_cf: fix compilation introduced by ata_port_desc()
 conversion
Date: Thu, 10 Jan 2008 16:55:21 -0500
Message-ID: <47869449.9060902@garzik.org>
References: <47802958.4080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33706 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541AbYAJVzZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:55:25 -0500
In-Reply-To: <47802958.4080602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, rod@whitby.id.au

Tejun Heo wrote:
> From: Rod Whitby <rod@whitby.id.au>
> 
> Fixes a compilation error caused by ata_port_desc() conversion
> (cbcdd87593a1d85c5c4b259945a3a09eee12814d).
> 
> Signed-off-by: Rod Whitby <rod@whitby.id.au>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/pata_ixp4xx_cf.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied #upstream-fixes


