From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] ahci: st: Add ports-implemented property in support
Date: Thu, 11 Aug 2016 14:04:17 +0300
Message-ID: <72e008b8-25dd-ae87-fd8c-b9e60b6fb1a8@cogentembedded.com>
References: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
 <1470843450-20068-2-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34286 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcHKLEU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 07:04:20 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so3600974wma.1
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2016 04:04:20 -0700 (PDT)
In-Reply-To: <1470843450-20068-2-git-send-email-patrice.chotard@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: patrice.chotard@st.com, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com

On 8/10/2016 6:37 PM, patrice.chotard@st.com wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
> returns 0. So force_port_map to 1 by using ports-implemented
> DT property.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  drivers/ata/ahci_st.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index 8ff428f..bc345f2 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
> @@ -147,6 +147,7 @@ static struct scsi_host_template ahci_platform_sht = {
>
>  static int st_ahci_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;

    Why? You could just use 'pdev'.

>  	struct st_ahci_drv_data *drv_data;
>  	struct ahci_host_priv *hpriv;
>  	int err;
> @@ -170,6 +171,9 @@ static int st_ahci_probe(struct platform_device *pdev)
>
>  	st_ahci_configure_oob(hpriv->mmio);
>
> +	of_property_read_u32(dev->of_node,

    pdev->dev.of_node

> +			     "ports-implemented", &hpriv->force_port_map);
> +
>  	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
>  				      &ahci_platform_sht);
>  	if (err) {

MBR, Sergei

