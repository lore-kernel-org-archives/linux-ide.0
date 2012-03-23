From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef,
 #endif macros
Date: Fri, 23 Mar 2012 13:38:27 +0530
Message-ID: <4F6C2F7B.2000302@st.com>
References: <427196876874fef7e956b10d035d06eed5895743.1330588911.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:36413 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756862Ab2CWIJ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2012 04:09:28 -0400
In-Reply-To: <427196876874fef7e956b10d035d06eed5895743.1330588911.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "jgarzik@pobox.com" <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 3/1/2012 1:34 PM, Viresh KUMAR wrote:
> #ifdef, #endif is not required in definition/usage of arasan_cf_pm_ops. So, move
> this definition and its usage outside of them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/ata/pata_arasan_cf.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Hi Jeff,

Can you please apply this patch.

-- 
viresh
