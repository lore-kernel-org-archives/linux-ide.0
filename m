From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2] ata: ahci_st: fixup layering violations / drvdata
 errors
Date: Wed, 29 Apr 2015 16:30:51 +0200
Message-ID: <5540EB1B.10505@st.com>
References: <1429537265-22367-1-git-send-email-peter.griffin@linaro.org> <1429537265-22367-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58334 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422821AbbD2Oba (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Apr 2015 10:31:30 -0400
In-Reply-To: <1429537265-22367-2-git-send-email-peter.griffin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, patrice.chotard@st.com, tj@kernel.org, computersforpeace@gmail.com
Cc: lee.jones@linaro.org, linux-ide@vger.kernel.org

Hi Peter,

On 04/20/2015 03:41 PM, Peter Griffin wrote:
> Brian noticed while working on another SATA driver that uses libahci_platform,
> an error in this driver; it tries to the the driver data for its
> device, while libata also thinks it can set the driver data. See:
>
>    ahci_platform_init_host()
>    -> ata_host_alloc_pinfo()
>       -> ata_host_alloc()
>          -> dev_set_drvdata()
>
> So instead of sticking the IP-specific platform data into drvdata, let's
> use the plat_data variable that is reserved for this use.
>
> Addtionally plat_data isn't set until ahci_platform_init_host() has been
> called further down in probe(). So re-work the st_ahci_probe_resets and
> st_ahci_deassert_resets functions to take ahci_host_priv *hpriv as a
> parameter.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Suggested-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
>

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
