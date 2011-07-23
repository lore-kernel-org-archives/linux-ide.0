From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata/ahci_platform: Add support for enabling/disabling
 clock.
Date: Sat, 23 Jul 2011 18:14:04 -0400
Message-ID: <4E2B47AC.1010101@pobox.com>
References: <211461c299bab630fda07f81963cab0b5f40c98d.1307609821.git.viresh.kumar@st.com> <4E08634F.3040902@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52881 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab1GWWOI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jul 2011 18:14:08 -0400
Received: by qwk3 with SMTP id 3so1595964qwk.19
        for <linux-ide@vger.kernel.org>; Sat, 23 Jul 2011 15:14:06 -0700 (PDT)
In-Reply-To: <4E08634F.3040902@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 06/27/2011 07:02 AM, viresh kumar wrote:
> On 06/09/2011 02:28 PM, Viresh KUMAR wrote:
>> On many architectures, drivers are supposed to enable/disable functional clock
>> of device. This patch adds support for clock enabling/disabling in
>> ahci_platform.c.
>>
>> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
>> ---
>>   drivers/ata/ahci.h          |    4 ++++
>>   drivers/ata/ahci_platform.c |   36 +++++++++++++++++++++++++++++++-----
>>   2 files changed, 35 insertions(+), 5 deletions(-)
>>
>
> Hi Jeff,
>
> Any inputs on this patch?

Is it actually -used- somewhere?

It certainly looks straightforward...


