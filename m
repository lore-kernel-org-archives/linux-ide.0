From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/2] phy: qcom: Add driver for QCOM APQ8064 SATA PHY
Date: Wed, 16 Jul 2014 07:28:16 +0100
Message-ID: <53C61B80.5070600@linaro.org>
References: <1405336651-32135-1-git-send-email-srinivas.kandagatla@linaro.org> <1405336679-32179-1-git-send-email-srinivas.kandagatla@linaro.org> <12555066.QsMd3v2SOo@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59917 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329AbaGPG2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2014 02:28:22 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so386650wgh.15
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2014 23:28:21 -0700 (PDT)
In-Reply-To: <12555066.QsMd3v2SOo@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>


On 15/07/14 17:56, Bartlomiej Zolnierkiewicz wrote:
>> +
>> >+/* Helper function to do poll and timeout */
>> >+static int read_poll_timeout(void __iomem *addr, u32 mask)
>> >+{
>> >+	unsigned long timeout = jiffies + msecs_to_jiffies(TIMEOUT_MS);
>> >+
>> >+	do {
>> >+		if (readl_relaxed(addr) & mask)
>> >+			return 0;
>> >+
>> >+		 usleep_range(DELAY_INTERVAL_US, DELAY_INTERVAL_US + 50);
>> >+	} while (!time_after(jiffies, timeout));
>> >+
>> >+	return -ETIMEDOUT;
>> >+}
> Thanks for reworking this code, unfortunately it still has a one
> (unlikely but still theoretically possible) problem.  If there is
> i.e. a big IRQ load between first usleep_range() call and first

Very unlikely but as you said it possible in theory :-)

> time_after() check the function will timeout without checking
> the register.  To fix it you needs to add an additonal register
> checking before returning -ETIMEDOUT value or replace time_after()
> condition with a fixed number of retries (100000 to cover 1sec
> timeout).
I will send out a fix on top of my previous patches to fix this.

thanks,
srini
