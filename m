From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 9/9] drivers: ata: sata_rcar: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 18:06:23 +0300
Message-ID: <a12fd539-b5f0-177d-7b91-cc203263757c@cogentembedded.com>
References: <1552382374-28789-1-git-send-email-info@metux.net>
 <1552382374-28789-9-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552382374-28789-9-git-send-email-info@metux.net>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com, linus.walleij@linaro.org, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 03/12/2019 12:19 PM, Enrico Weigelt, metux IT consult wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

MBR, Sergei
