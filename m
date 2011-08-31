From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Wed, 31 Aug 2011 12:03:31 +0200
Message-ID: <87k49t99u4.fsf@lebrac.rtp-net.org>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:39668 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1HaKEO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2011 06:04:14 -0400
In-Reply-To: <1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
	(Richard Zhu's message of "Wed, 31 Aug 2011 11:50:31 +0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

Richard Zhu <richard.zhu@linaro.org> writes:
Hi,


> @@ -1503,6 +1519,9 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>  	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
>  	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
> +	_REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
> +	_REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
> +	_REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
>  };
>  
>  static void clk_tree_init(void)

Which tree has been used for this patch ? For instance, on current
imx-features branch of Sascha's tree, there's a pata_imx clock defined
here (see [1]). Should I try to apply it on top of some other branch ?

Arnaud

[1] http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=03b20b07be130e44faf29f787c66ce5cce5afb2a
