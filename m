From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit
 operation
Date: Fri, 8 Jun 2012 07:12:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1206080711370.1793@hadrien>
References: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr> <1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr> <20120607.144616.2224976714259476349.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120607.144616.2224976714259476349.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Julia.Lawall@lip6.fr, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, julia@diku.dk
List-Id: linux-ide@vger.kernel.org

On Thu, 7 Jun 2012, David Miller wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> Date: Wed,  6 Jun 2012 23:41:35 +0200
>
>> -	if (!(pdev->resource[0]->flags & IO_DATA_PATH_WIDTH_8)) {
>> +	if ((p1dev->resource[0]->flags & IO_DATA_PATH_WIDTH)
>
> I'm really surprised someone as thorough as yourself did not
> compile test this.

Sorry, I changed the patch at the last minute, and it was indeed not a 
good idea not to have compiled again.  I will send another version, in 
case it is useful.

julia
