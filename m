From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Wed, 31 Aug 2011 19:04:21 +0800
Message-ID: <27DACB75-EF61-4A32-B11C-E1044B0FB0B2@gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org> <1314762635-3923-2-git-send-email-richard.zhu@linaro.org> <87k49t99u4.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0 (iPhone Mail 8F190)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64480 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab1HaLEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2011 07:04:41 -0400
Received: by ywf7 with SMTP id 7so454386ywf.19
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2011 04:04:40 -0700 (PDT)
In-Reply-To: <87k49t99u4.fsf@lebrac.rtp-net.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: Richard Zhu <richard.zhu@linaro.org>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Arnaud,

You can just use Linus tree v3.1-rc4 as the base for this.

Sent from my iPhone

On Aug 31, 2011, at 6:03 PM, Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> wrote:

> Richard Zhu <richard.zhu@linaro.org> writes:
> Hi,
> 
> 
>> @@ -1503,6 +1519,9 @@ static struct clk_lookup mx53_lookups[] = {
>>    _REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>>    _REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
>>    _REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
>> +    _REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
>> +    _REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
>> +    _REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
>> };
>> 
>> static void clk_tree_init(void)
> 
> Which tree has been used for this patch ? For instance, on current
> imx-features branch of Sascha's tree, there's a pata_imx clock defined
> here (see [1]). Should I try to apply it on top of some other branch ?
> 
> Arnaud
> 
> [1] http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=03b20b07be130e44faf29f787c66ce5cce5afb2a
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
