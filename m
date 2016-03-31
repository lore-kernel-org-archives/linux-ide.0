From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: apq8064: add ahci ports-implemented mask
Date: Thu, 31 Mar 2016 23:25:38 +0300
Message-ID: <56FD87C2.3020503@cogentembedded.com>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459445500-9071-4-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1459445500-9071-4-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com
List-Id: linux-ide@vger.kernel.org

On 03/31/2016 08:31 PM, Srinivas Kandagatla wrote:

> This patch adds new ports-implemented mask, which is required to get
> achi working on the mainline. Without this patch value read from
> PORTS_IMPL register which is zero would not enable any ports for
> software to use.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 252b310..71d6fcb 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -696,7 +696,7 @@
>   		};
>
>   		sata0: sata@29000000 {
> -			compatible		= "generic-ahci";
> +			compatible		= "generic-ahci", "qcom,apq8064-ahci";

    The order of values should be reverse, no?

[...]

MBR, Sergei
