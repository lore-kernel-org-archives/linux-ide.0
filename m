From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 01/14] ata: ahci-platform: add reset control support and
 the flag to specify using reset
Date: Wed, 22 Aug 2018 12:34:30 +0300
Message-ID: <1d221236-636e-962e-2e4e-3db228689c5e@cogentembedded.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1534923430-9692-2-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534923430-9692-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hello!

On 8/22/2018 10:36 AM, Kunihiko Hayashi wrote:

> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
> 
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
> 
> However, according to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset make a path to occur double controls of resets.
> 
> Now this add the flag to ahci_platform_get_resources() indicating
> whether to use the resources, currently resets only, and existing
> drivers set 0 to this flags.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
[...]

> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 1b0a17b..eaedca5f 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -30,7 +30,7 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
>   int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
>   struct ahci_host_priv *ahci_platform_get_resources(
> -	struct platform_device *pdev);
> +	struct platform_device *pdev, unsigned int flags);

    That breaks all the users of this API. You should fix the callers in this 
same patch to avoid breakage.

[...]

MBR, Sergei
