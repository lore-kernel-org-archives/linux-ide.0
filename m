From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
Date: Tue, 31 Mar 2015 17:33:23 +0200
Message-ID: <551ABE43.60602@st.com>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org> <1427787309-1601-4-git-send-email-peter.griffin@linaro.org> <20150331152958.GF9974@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60113 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755254AbbCaPeD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2015 11:34:03 -0400
In-Reply-To: <20150331152958.GF9974@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org

Hello Tejun,

On 03/31/2015 05:29 PM, Tejun Heo wrote:
> On Tue, Mar 31, 2015 at 08:35:09AM +0100, Peter Griffin wrote:
>> Currently the ahci_st driver will hang the system on probe, as the
>> st_configure_oob function does some register writes before the IP
>> is clocked. This patch moves the function call to after
>> ahci_platform_enable_resources (which enables the IP clock), and
>> resolves the hang.
>>
>> Addtionally st_ahci_configure_oob should be called in the st_ahci_resume
>> function, so we also rectify that ensuring it is also called after
>> the IP clock has been enabled.
>>
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> How should this patch be routed?  Should I pick this up and apply to
> libata/for-4.1 or should it go together with the other patches?  If
> the latter, please feel free to add my acked-by.

I think you can pick patches 1 & 3.
I will apply patch 2 to STi DT branch.

Thanks,
Maxime
>
> Thanks.
>

