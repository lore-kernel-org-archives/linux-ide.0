From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc7] libata: quirk IOMEGA ZIP 250 ATAPI FLOPPY
Date: Tue, 10 Jul 2007 21:38:10 -0400
Message-ID: <46943482.5070802@garzik.org>
References: <20070705033131.GW29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37644 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbXGKBiN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:38:13 -0400
In-Reply-To: <20070705033131.GW29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bruinjm@xs4all.nl, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> The Zip 250 which chokes on MWDMA SET_XFERMODE sometimes have "Floppy"
> appeneded to its model number.  Quirk it too.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=8563
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Hans de Bruin <bruinjm@xs4all.nl>
> ---
> It seems the Zip 250 mwdma failure on libata doesn't seem to be
> libata's fault after all.  IDE also fails SET_XFERMODE on this drive
> but IDE simply ignores the error and continues to operate in MWDMA
> mode, so I guess we can remove the 'temporary fix' comment or add
> another quirk type - ATA_HORKAGE_SETXFER_MAY_FAIL - and use it.
> 
> Anyways, for the time being, this should do.
> 
>  drivers/ata/libata-core.c |    2 ++
>  1 file changed, 2 insertions(+)

applied


