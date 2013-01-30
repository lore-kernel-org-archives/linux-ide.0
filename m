From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] driver: ata: add new Exynos5250 SATA controller driver
Date: Wed, 30 Jan 2013 11:13:48 +0530
Message-ID: <5108B314.5090207@linaro.org>
References: <1359472964-31445-1-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359472964-31445-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

On 01/29/2013 08:52 PM, Vasanth Ananthan wrote:
> Adding platform driver for AHCI based SATA controller for Exynos5250.
> The SATA controller in Exynos5250 is an AHCI based controller. Though
> the controller implements only one port, the driver is scalable for
> maximum number of ports possible. The drivers uses libahci framework
> to initialize the controller and the ports implemented.
> 
> The driver also initializes the PHY controllers associated with the
> sata controller, for which the port-phy mapping have to provided
> in the device tree node of the sata controller node. The driver extracts
> the device_node of the PHY controller provided in the mapping, passes it
> the SATA PHY framework. The framework, return the corresponding PHY,
> if it has be registered with the framework, after which the driver
> intializes the PHY controller(s).
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---

[ ... ]

> +
> +static int __init exynos_sata_probe(struct platform_device *pdev)
> +{

__init would result in a section mismatch warning.

[ ... ]

> +
> +static int __devexit exynos_sata_remove(struct platform_device *pdev)
> +{

Use of __devexit is deprecated now. Please remove that.


-- 
Tushar Behera
