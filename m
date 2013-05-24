From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: do not limit R-Car SATA driver to shmobile
Date: Fri, 24 May 2013 22:35:55 +0400
Message-ID: <519FB30B.3080508@cogentembedded.com>
References: <1369361159-20724-1-git-send-email-horms+renesas@verge.net.au> <CAOS58YNvK=8v_fYTz-oLTxQZJ-PtYA1FWOMbXFEUnDom38FNHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAOS58YNvK=8v_fYTz-oLTxQZJ-PtYA1FWOMbXFEUnDom38FNHg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-ide <linux-ide@vger.kernel.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

Hello.

On 05/24/2013 06:34 AM, Tejun Heo wrote:

>
>> The motivation for this is to allow the driver to be
>> used with the r8a7790 SoC.
>>
>> I believe that rather than adding another SoC to the list of allowed SoCs
>> it is better to simply remove the dependency of the driver on shmobile all
>> together.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Applied to libata/for-3.11.

     I guess you haven't pushed it out -- I don't see the commit when 
pulling.

> Thanks.
>
> --
> tejun

WBR, Sergei

