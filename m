From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Tue, 08 Sep 2009 21:25:35 -0400
Message-ID: <4AA7040F.1050707@garzik.org>
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58443 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbZIIBZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Sep 2009 21:25:36 -0400
In-Reply-To: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ashish kalra <ashish.kalra@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On 07/29/2009 12:03 PM, ashish kalra wrote:
> From: Ashish Kalra <Ashish.Kalra@freescale.com>
> Date: Wed, 29 Jul 2009 21:15:49 +0530
>
> Fix for non-ncq & ncq commands causing timeouts when both are issued
> simultaneously to the same device.
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> ---
> drivers/ata/sata_fsl.c | 1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 5a88b44..a33f130 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1262,6 +1262,7 @@ static struct scsi_host_template sata_fsl_sht = {
> static struct ata_port_operations sata_fsl_ops = {
> .inherits = &sata_pmp_port_ops,
>
> + .qc_defer = ata_std_qc_defer;

Applied version with obvious s/;/,/ fix...

	Jeff




