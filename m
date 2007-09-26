From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH UPDATED #upstream-fixes,#upstream] sata_sil24: fix IRQ
 clearing race when PCIX_IRQ_WOC is used
Date: Tue, 25 Sep 2007 21:39:18 -0400
Message-ID: <46F9B846.7000505@garzik.org>
References: <20070923032614.GI10660@htj.dyndns.org> <20070923033705.GJ10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52579 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690AbXIZBjU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 21:39:20 -0400
In-Reply-To: <20070923033705.GJ10660@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> When PCIX_IRQ_WOC is used, sil24 has an inherent race condition
> between clearing IRQ pending and reading IRQ status.  If IRQ pending
> is cleared after reading IRQ status, there's possibility of lost IRQ.
> If IRQ pending is cleared before reading IRQ status, spurious IRQs
> will occur.
> 
> sata_sil24 till now cleared IRQ pending after reading IRQ status thus
> losing IRQs on machines where PCIX_IRQ_WOC was used.  Reverse the
> order and ignore spurious IRQs if PCIX_IRQ_WOC.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> The previous patch contained a stupid mistake.  This is the correct
> one.
> 
>  drivers/ata/sata_sil24.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

applied


