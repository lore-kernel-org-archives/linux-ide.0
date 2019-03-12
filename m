From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/9] drivers: ata: ahci_xgene: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 17:43:49 +0300
Message-ID: <4cab769a-f4cf-4042-fd0b-1a33f0dbd4f7@cogentembedded.com>
References: <1552382374-28789-1-git-send-email-info@metux.net>
 <1552382374-28789-4-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552382374-28789-4-git-send-email-info@metux.net>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com, linus.walleij@linaro.org, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 03/12/2019 12:19 PM, Enrico Weigelt, metux IT consult wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ata/ahci_xgene.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 7e157e1..99c622c 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -752,7 +752,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
[...]
>  	/* Retrieve the optional IP mux resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
> -	if (res) {
> -		void __iomem *csr = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(csr))
> -			return PTR_ERR(csr);
> -
> -		ctx->csr_mux = csr;
> +	ctx->csr_mux = csr = devm_platform_ioremap_resource(pdev, 4);
> +	if (IS_ERR(ctx->csr_mux)) {
> +		dev_info(&pdev->dev, "cant get ip mux resource (optional)");

   Can't.

> +		ctx->csr_mux = NULL;

MBR, Sergei
