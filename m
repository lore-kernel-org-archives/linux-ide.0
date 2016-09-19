From: Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH 07/19] ahci: st: Remove STiH416 dt example
Date: Mon, 19 Sep 2016 09:19:45 +0200
Message-ID: <2d5feb77-49ed-1a2c-5195-82d4a1db38a8@st.com>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-8-git-send-email-peter.griffin@linaro.org>
 <20160916155449.GB26371@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49106 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756367AbcISHUU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2016 03:20:20 -0400
In-Reply-To: <20160916155449.GB26371@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, linux-ide@vger.kernel.org



On 09/16/2016 05:54 PM, Tejun Heo wrote:
> On Wed, Sep 14, 2016 at 02:27:45PM +0100, Peter Griffin wrote:
>> This platform is being removed from the kernel so remove
>> the dt example.
>>
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>> Cc: <tj@kernel.org>
>> Cc: <robh+dt@kernel.org>
>> Cc: <linux-ide@vger.kernel.org>
> 
> This is gonna go through dt tree, right?  If it should go through
> libata, please let me know.

Hi Tejun

I will take care of this patch and include it in the next STi DT pull request.

Thanks

> 
> Thanks.
> 
