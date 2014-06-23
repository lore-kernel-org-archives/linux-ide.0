From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/5] ata: ahci_imx: allow hardware parameters to be
 specified in DT
Date: Mon, 23 Jun 2014 17:32:03 +0200
Message-ID: <1403537523.5375.0.camel@paszta.hi.pengutronix.de>
References: <E1Wz2u1-0000eI-Py@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47615 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbaFWPcS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2014 11:32:18 -0400
In-Reply-To: <E1Wz2u1-0000eI-Py@rmk-PC.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi Russell,

Am Montag, den 23.06.2014, 12:59 +0100 schrieb Russell King:
[...]
> +struct reg_value {
> +	u32 of_value;
> +	u32 reg_value;
> +};
[...]
> +static const struct reg_value gpr13_tx_boost[] = {
> +	{    0, IMX6Q_GPR13_SATA_TX_BOOST_0_00_DB },
> +	{  370, IMX6Q_GPR13_SATA_TX_BOOST_0_37_DB },
> +	{  740, IMX6Q_GPR13_SATA_TX_BOOST_0_74_DB },
> +	{  111, IMX6Q_GPR13_SATA_TX_BOOST_1_11_DB },

I think this .of_value has to be multiplied by 10,
and the same for the following ones:

> +	{  148, IMX6Q_GPR13_SATA_TX_BOOST_1_48_DB },
> +	{  185, IMX6Q_GPR13_SATA_TX_BOOST_1_85_DB },
> +	{  222, IMX6Q_GPR13_SATA_TX_BOOST_2_22_DB },
> +	{  259, IMX6Q_GPR13_SATA_TX_BOOST_2_59_DB },
> +	{  296, IMX6Q_GPR13_SATA_TX_BOOST_2_96_DB },
> +	{  333, IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB },
> +	{  370, IMX6Q_GPR13_SATA_TX_BOOST_3_70_DB },
> +	{  407, IMX6Q_GPR13_SATA_TX_BOOST_4_07_DB },
> +	{  444, IMX6Q_GPR13_SATA_TX_BOOST_4_44_DB },
> +	{  481, IMX6Q_GPR13_SATA_TX_BOOST_4_81_DB },
> +	{  528, IMX6Q_GPR13_SATA_TX_BOOST_5_28_DB },
> +	{  575, IMX6Q_GPR13_SATA_TX_BOOST_5_75_DB }
> +};

regards
Philipp


