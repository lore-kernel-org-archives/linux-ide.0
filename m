From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: pata_arasan: Initialize cf clock to 166MHz
Date: Thu, 15 Nov 2012 23:40:43 -0500
Message-ID: <50A5C3CB.8040408@pobox.com>
References: <382d2087350ff0955ba14f125294ace4ed28382b.1352387366.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37479 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2KPEkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2012 23:40:46 -0500
In-Reply-To: <382d2087350ff0955ba14f125294ace4ed28382b.1352387366.git.viresh.kumar@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>

On 11/08/2012 10:09 AM, Viresh Kumar wrote:
> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
>
> PATA arasan driver expects the clock to be set to 166 MHz for proper functioning.
> This patch sets clk to 166 MHz in probe.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/ata/pata_arasan_cf.c | 6 ++++++
>   1 file changed, 6 insertions(+)

applied



