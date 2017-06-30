From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] sata_rcar: fix error return code in
 sata_rcar_probe()
Date: Fri, 30 Jun 2017 16:11:56 -0500
Message-ID: <20170630161156.Horde.id9lz2qyRnuSBKx3KBfTM7r@gator4166.hostgator.com>
References: <20170630210806.GA9391@embeddedgus>
 <dbc9fcd5-e57a-780e-4618-d9c6a19d7433@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbc9fcd5-e57a-780e-4618-d9c6a19d7433@cogentembedded.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Quoting Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:

> On 07/01/2017 12:08 AM, Gustavo A. R. Silva wrote:
>
>> platform_get_irq() returns an error code, but the sata_rcar driver
>> ignores it and always returns -EINVAL. This is not correct, and
>> prevents -EPROBE_DEFER from being propagated properly. Also,
>> notice that platform_get_irq() no longer returns 0 on error.
>>
>> Print error message and propagate the return value of platform_get_irq
>> on failure.
>>
>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
>    You forgot to collect:
>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>

Oh I'm sorry. Should I send v3?

Thanks
--
Gustavo A. R. Silva
