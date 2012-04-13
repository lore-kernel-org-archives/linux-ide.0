From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef,
 #endif macros
Date: Fri, 13 Apr 2012 09:13:20 +0530
Message-ID: <4F87A0D8.70707@st.com>
References: <427196876874fef7e956b10d035d06eed5895743.1330588911.git.viresh.kumar@st.com> <4F83FE48.8000607@st.com> <4F873609.20107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:40750 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757184Ab2DMDox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 23:44:53 -0400
In-Reply-To: <4F873609.20107@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 4/13/2012 1:37 AM, Jeff Garzik wrote:
> On 04/10/2012 05:32 AM, Viresh Kumar wrote:
>> On 3/1/2012 1:34 PM, Viresh KUMAR wrote:
>>> #ifdef, #endif is not required in definition/usage of arasan_cf_pm_ops. So, move
>>> this definition and its usage outside of them.
>>>
>>> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
>>> ---
>>>   drivers/ata/pata_arasan_cf.c |    4 +---
>>>   1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> Hi Jeff,
>>
>> Can you please apply this patch?
> 
> This has been upstream for a while now.

I couldn't see this in linux-next/master :(

You pushed following patch earlier:

Author: Viresh Kumar <viresh.kumar@st.com>
Date:   Thu Feb 23 15:03:53 2012 +0530

    ata/pata_arasan_cf: Add Hibernation support


And this one is a fix over it.

-- 
viresh
