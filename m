From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: clear link->eh_info.serror from
 ata_std_postreset()
Date: Mon, 17 Dec 2007 20:37:29 -0500
Message-ID: <47672459.9070007@garzik.org>
References: <4759DB17.9010505@gmail.com> <4759DB75.1010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37123 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760346AbXLRBhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:37:31 -0500
In-Reply-To: <4759DB75.1010702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, mark.paulus@technologist.com, sveint@gmail.com, bug-track@fisher-privat.net

Tejun Heo wrote:
> link->eh_info.serror is used to cache SError for controllers which
> need it cleared from interrupt handler to clear IRQ.  It also should
> be cleared after reset just like SError itself.
> 
> Make ata_std_postreset() clear link->eh_info.serror too and update
> sata_sil such that it doesn't care about bookkeeping the value.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  drivers/ata/sata_sil.c    |   11 +----------
>  2 files changed, 2 insertions(+), 10 deletions(-)

applied #upstream-fixes


