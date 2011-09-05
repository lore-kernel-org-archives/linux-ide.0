From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Mon, 05 Sep 2011 21:25:46 +0200
Message-ID: <877h5m7pvp.fsf@lebrac.rtp-net.org>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
	<CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
	<CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:51607 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab1IET0e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2011 15:26:34 -0400
In-Reply-To: <CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
	(Hector Oron's message of "Wed, 31 Aug 2011 13:57:06 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hector Oron <hector.oron@gmail.com>
Cc: Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, Wolfram Sang <w.sang@pengutronix.de>, eric.miao@linaro.org, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

Hector Oron <hector.oron@gmail.com> writes:

> Hello,

Hi,

>
> 2011/8/31 Richard Zhu <richard.zhu@linaro.org>:
>> Hi Hector:
>> Thanks for your help to tests these patches.
>
> Note I rebased this patches against 'imx-features' branch on Sascha's tree.
> I am noticing some obscure (to me) messages from kernel:

Currently testing with probably same checkout of imx-features branch
with a sata 3.5" drive. Running badblocks in non destructive write mode
and so far, so good (it's slow but it may comes from my drive).

Did you test if there was a bad cable or faulty drive PSU ?

Arnaud
