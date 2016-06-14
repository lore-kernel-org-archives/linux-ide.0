From: "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] ata: fix return value check in
 ahci_seattle_get_port_info()
Date: Tue, 14 Jun 2016 03:02:02 +0000
Message-ID: <7AF60F92-22D7-4F30-AF95-CEE08D3472E5@amd.com>
References: <1465864009-26774-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0056.outbound.protection.outlook.com ([157.56.111.56]:36896
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422929AbcFNDRf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2016 23:17:35 -0400
In-Reply-To: <1465864009-26774-1-git-send-email-weiyj_lk@163.com>
Content-Language: en-US
Content-ID: <F44541F8B514A84088A1DF27CF932DBB@namprd12.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "weiyj_lk@163.com" <weiyj_lk@163.com>
Cc: Tejun Heo <tj@kernel.org>, "Singh, Brijesh" <brijesh.singh@amd.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


> On Jun 13, 2016, at 7:26 PM, weiyj_lk@163.com wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_kzalloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> drivers/ata/ahci_seattle.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
> index 6e702ab..1d31c0c 100644
> --- a/drivers/ata/ahci_seattle.c
> +++ b/drivers/ata/ahci_seattle.c
> @@ -137,7 +137,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
> 	u32 val;
> 
> 	plat_data = devm_kzalloc(dev, sizeof(*plat_data), GFP_KERNEL);
> -	if (IS_ERR(plat_data))
> +	if (!plat_data)
> 		return &ahci_port_info;
> 
> 	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
> 
> 

Acked-by: Brijesh Singh <brijesh.singh@amd.com>

-Brijesh


