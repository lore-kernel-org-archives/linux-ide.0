From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Wed, 29 Jul 2009 13:48:29 -0600
Message-ID: <4A70A78D.7070601@gmail.com>
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:60647 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZG2Tsb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 15:48:31 -0400
Received: by pzk34 with SMTP id 34so638384pzk.4
        for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 12:48:31 -0700 (PDT)
In-Reply-To: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ashish kalra <ashish.kalra@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On 07/29/2009 10:03 AM, ashish kalra wrote:
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
> .qc_prep = sata_fsl_qc_prep,
> .qc_issue = sata_fsl_qc_issue,
> .qc_fill_rtf = sata_fsl_qc_fill_rtf,

This doesn't look like it should change anything. sata_fsl_ops inherits 
from sata_pmp_port_ops, which inherits from sata_port_ops, which already 
sets qc_defer to ata_std_qc_defer.
