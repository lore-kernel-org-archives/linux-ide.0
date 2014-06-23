From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] phy: qcom: Add driver for QCOM APQ8064 SATA PHY
Date: Mon, 23 Jun 2014 19:38:51 +0100
Message-ID: <53A8743B.8020404@linaro.org>
References: <1403546409-10860-1-git-send-email-srinivas.kandagatla@linaro.org> <C77397FA-1247-4D99-A0AC-9EFE45F7036E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:41121 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbaFWSiy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2014 14:38:54 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so7455180wes.40
        for <linux-ide@vger.kernel.org>; Mon, 23 Jun 2014 11:38:53 -0700 (PDT)
In-Reply-To: <C77397FA-1247-4D99-A0AC-9EFE45F7036E@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>



On 23/06/14 19:12, Kumar Gala wrote:
>
> On Jun 23, 2014, at 1:00 PM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> Add a PHY driver for uses with AHCI based SATA controller driver on the
>> APQ8064 family of SoCs.
>>
>> This patch is a forward port plus separating PHY code of SATA driver
>> from Qualcomm's v3.4 andriod kernel.
>>
>> Tested on IFC6410 board.
>>
>> CC: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> drivers/phy/Kconfig                 |   7 +
>> drivers/phy/Makefile                |   1 +
>> drivers/phy/phy-qcom-apq8064-sata.c | 358 ++++++++++++++++++++++++++++++++++++
>> 3 files changed, 366 insertions(+)
>> create mode 100644 drivers/phy/phy-qcom-apq8064-sata.c
>
> Did you look at the 3.10 Android kernel tree version of the phy driver?
>
No, I did not get a chance to look at it. I will have a look at it today.
> Also do you have a DT binding spec to go with this?
yes, I did add it into the same binding spec qcom-phy.txt as ipq806x.

I will send this in a different patch.

thanks,
srini
>
> - k
>
