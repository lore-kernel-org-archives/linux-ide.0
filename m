From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2.6.28-rc2] sata_promise: proper hardreset
Date: Tue, 28 Oct 2008 11:06:35 +0900
Message-ID: <490673AB.2090502@kernel.org>
References: <200810270049.m9R0ngI8027933@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33902 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbYJ1CHJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 22:07:09 -0400
In-Reply-To: <200810270049.m9R0ngI8027933@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

Hello, Mikael.

Mikael Pettersson wrote:
> +static int pdc_pata_hardreset(struct ata_link *link, unsigned int *class,
> +			      unsigned long deadline)
> +{
> +	pdc_reset_port(link->ap);
> +	return 0;
> +}

You either need to return -EAGAIN here to ask for follow-up SRST or
override softreset.  I think pdc_reset_port() doesn't actually reset the
ATA channel, right?  In that case, the latter would be the correct thing
to do.

Thanks.

-- 
tejun
