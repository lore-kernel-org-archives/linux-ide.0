From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: make functions/variables static
Date: Wed, 20 Jan 2010 14:33:33 -0500
Message-ID: <4B575A8D.8010908@garzik.org>
References: <4B568EAB.1030207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:57265 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab0ATTdf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 14:33:35 -0500
Received: by mail-gx0-f217.google.com with SMTP id 9so6490337gxk.8
        for <linux-ide@vger.kernel.org>; Wed, 20 Jan 2010 11:33:34 -0800 (PST)
In-Reply-To: <4B568EAB.1030207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>

On 01/20/2010 12:03 AM, Robert Hancock wrote:
> Make some variables in ahci and a function in pata_pcmcia static, as found
> using sparse.
>
> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index b8bea10..265d0d4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -356,10 +356,10 @@ static ssize_t ahci_show_host_version(struct device *dev,
>   static ssize_t ahci_show_port_cmd(struct device *dev,
>   				  struct device_attribute *attr, char *buf);
>
> -DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
> -DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
> -DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
> -DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
> +static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
> +static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
> +static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
> +static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
>
>   static struct device_attribute *ahci_shost_attrs[] = {
>   	&dev_attr_link_power_management_policy,
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index 1b392c9..3610353 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
> @@ -136,7 +136,7 @@ static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
>    *
>    */
>
> -void pcmcia_8bit_drain_fifo(struct ata_queued_cmd *qc)
> +static void pcmcia_8bit_drain_fifo(struct ata_queued_cmd *qc)
>   {
>   	int count;
>   	struct ata_port *ap;
>


applied


