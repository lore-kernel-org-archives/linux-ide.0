From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] AHCI: disabled FBS prior to issuing software reset
Date: Sat, 28 Sep 2013 19:23:38 +0400
Message-ID: <5246F47A.8030200@cogentembedded.com>
References: <1380366816-16221-1-git-send-email-yxlraid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43373 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab3I1PXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Sep 2013 11:23:36 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so3121605lbh.23
        for <linux-ide@vger.kernel.org>; Sat, 28 Sep 2013 08:23:35 -0700 (PDT)
In-Reply-To: <1380366816-16221-1-git-send-email-yxlraid@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xiangliang Yu <yxlraid@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 28-09-2013 15:13, Xiangliang Yu wrote:

> If device is attached to port multiplier, the detection process
> look like this:
> 	ahci_hardreset(link, class, deadline)
> 	if (class == ATA_DEV_PMP) {
> 		sata_pmp_attach(dev)    /* will enable FBS */
> 		sata_pmp_init_links(ap, nr_ports);
> 		ata_for_each_link(link, ap, EDGE) {
> 			sata_std_hardreset(link, class, deadline);
> 			if (link_is_online)
> 				ahci_softreset(link, class, deadline);
> 		}
> 	}
> But, according to chapter 9.3.9 in AHCI spec: Prior to issuing software reset,
> software shall clear PxCMD.ST to '0' and then clear PxFBS.EN to '0'.

> Signed-off-by: Xiangliang Yu <yxlraid@gmail.com>
> ---
>   drivers/ata/libahci.c |   10 ++++++++++
>   1 files changed, 10 insertions(+), 0 deletions(-)

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index acfd0f7..8d024a4 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1267,9 +1267,11 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>   {
>   	struct ata_port *ap = link->ap;
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	struct ahci_port_priv *pp = ap->private_data;
>   	const char *reason = NULL;
>   	unsigned long now, msecs;
>   	struct ata_taskfile tf;
> +	bool flag = FALSE;

    Why not lowercase 'false'? And this is not a good name for a variable (too 
generic), it should better be called 'fbs' or something...

> @@ -1279,6 +1281,11 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>   	if (rc && rc != -EOPNOTSUPP)
>   		ata_link_warn(link, "failed to reset engine (errno=%d)\n", rc);
>
> +	if (!ata_is_host_link(link) && pp->fbs_enabled) {
> +		ahci_disable_fbs(ap);
> +		flag = TRUE;

    Why not lowercase 'true'?

WBR, Sergei

