From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/11] libata: add probeinit component operation to ata_drive_probe_reset()
Date: Thu, 09 Feb 2006 02:02:11 -0500
Message-ID: <43EAE8F3.7000505@pobox.com>
References: <11388720002859-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43417 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422838AbWBIHCQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 02:02:16 -0500
In-Reply-To: <11388720002859-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch adds probeinit component operation to
> ata_drive_probe_reset().  If present, this new operation is called
> before performing any reset.  The operations's roll is to prepare @ap
> for following probe-reset operations.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
[...]
>  extern int ata_drive_probe_reset(struct ata_port *ap,
> +			ata_probeinit_fn_t probeinit,
>  			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
>  			ata_postreset_fn_t postreset, unsigned int *classes);

Applied patches 3-4, although I dislike that ata_drive_probe_reset() is 
growing a ton of function pointer arguments.  Please consider a better 
approach when you have some free time.  Perhaps these need to be added 
to ata_port_operations?  Perhaps another ata_reset_operations struct? 
What do you think?

	Jeff


