From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: add FIXME above ata_dev_xfermask()
Date: Fri, 24 Mar 2006 23:09:31 -0500
Message-ID: <4424C27B.1090000@pobox.com>
References: <11431768704184-git-send-email-htejun@gmail.com> <4424026A.1080504@pobox.com> <20060325021407.GF5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14230 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750765AbWCYEJh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 23:09:37 -0500
In-Reply-To: <20060325021407.GF5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add FIXME above ata_dev_xfermask noting that the current
> implementation limits all transfer modes to the fastest of the slowest
> device on a port which isn't necessary.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 0aff888..e4bd673 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2634,6 +2634,10 @@ static int ata_dma_blacklisted(const str
>   *	known limits including host controller limits, device
>   *	blacklist, etc...
>   *
> + *	FIXME: The current implementation limits all transfer modes to
> + *	the fastest of the lowested device on the port.  This is not
> + *	required on most controllers. 

applied, though git complained about...

[jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
1 patch(es) to process.

Applying 'libata: add FIXME above ata_dev_xfermask()'

Adds trailing whitespace.
.dotest/patch:11: *     required on most controllers.
warning: 1 line adds trailing whitespaces.
Wrote tree 0fc6b51c6ddfb5d3f759bb88a34d8003386a50d7
Committed: 600511e86babe3727264a0883a3a264f6fb6caf5

