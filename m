From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller
 driver
Date: Thu, 12 Jun 2014 12:50:19 -0700
Message-ID: <539A047B.3010306@codeaurora.org>
References: <1402600404-19214-1-git-send-email-galak@codeaurora.org> <1402600404-19214-2-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47341 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbaFLTuV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2014 15:50:21 -0400
In-Reply-To: <1402600404-19214-2-git-send-email-galak@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 06/12/14 12:13, Kumar Gala wrote:
> +static int qcom_ahci_probe(struct platform_device *pdev)
> +{
> +	struct ahci_host_priv *hpriv;
> +	struct clk *rxoob_clk;
> +	int rc;
> +
> +	hpriv = ahci_platform_get_resources(pdev);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	/* Try and set the rxoob clk to 100Mhz */
> +	rxoob_clk = of_clk_get_by_name(pdev->dev.of_node, "rxoob");

Any reason we can't use devm_clk_get() here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

