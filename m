From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef,
 #endif macros
Date: Thu, 12 Apr 2012 16:07:37 -0400
Message-ID: <4F873609.20107@pobox.com>
References: <427196876874fef7e956b10d035d06eed5895743.1330588911.git.viresh.kumar@st.com> <4F83FE48.8000607@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50629 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965939Ab2DLUHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 16:07:40 -0400
Received: by qcro28 with SMTP id o28so1475357qcr.19
        for <linux-ide@vger.kernel.org>; Thu, 12 Apr 2012 13:07:39 -0700 (PDT)
In-Reply-To: <4F83FE48.8000607@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 04/10/2012 05:32 AM, Viresh Kumar wrote:
> On 3/1/2012 1:34 PM, Viresh KUMAR wrote:
>> #ifdef, #endif is not required in definition/usage of arasan_cf_pm_ops. So, move
>> this definition and its usage outside of them.
>>
>> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
>> ---
>>   drivers/ata/pata_arasan_cf.c |    4 +---
>>   1 files changed, 1 insertions(+), 3 deletions(-)
>
> Hi Jeff,
>
> Can you please apply this patch?

This has been upstream for a while now.



