From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.17] ata_piix device probe fixes
Date: Tue, 11 Jul 2006 18:04:13 -0400
Message-ID: <44B4205D.1050407@garzik.org>
References: <20060711214923.GA20652@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4012 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932177AbWGKWEP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jul 2006 18:04:15 -0400
In-Reply-To: <20060711214923.GA20652@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> +static void piix_host_stop(struct ata_host_set *host_set)
> +{
> +	kfree(host_set->private_data);
> +	ata_host_stop(host_set);

Crap, this introduces a double-kfree.  Fix pending...

	Jeff



