From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata/ahci_platform: Add support for enabling/disabling
 clock.
Date: Mon, 25 Jul 2011 23:47:37 -0400
Message-ID: <4E2E38D9.2010408@pobox.com>
References: <211461c299bab630fda07f81963cab0b5f40c98d.1307609821.git.viresh.kumar@st.com> <4E08634F.3040902@st.com> <4E2B47AC.1010101@pobox.com> <4E2E37FF.4040606@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45114 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1GZDrk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jul 2011 23:47:40 -0400
Received: by qyk9 with SMTP id 9so17372qyk.19
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2011 20:47:39 -0700 (PDT)
In-Reply-To: <4E2E37FF.4040606@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 07/25/2011 11:43 PM, viresh kumar wrote:
> On 07/24/2011 03:44 AM, Jeff Garzik wrote:
>> Is it actually -used- somewhere?
>>
>> It certainly looks straightforward...
>
> Yes, this will be used for SPEAr1340. (Yet to add support for 1340 in mainline)

We'll add it when the first user appears...


