From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 15:35:57 +0300
Message-ID: <3273ba2f-ea32-0ed6-5d84-39a80e627be6@cogentembedded.com>
References: <20170630052210.GA19186@embeddedgus>
 <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 06/30/2017 12:42 PM, Sergei Shtylyov wrote:

>> Print error message and propagate the return value of
>> platform_get_irq on failure.
>
>    You should have probably mentioned that this function no longer returns 0
> on error.

    It's prolly also worth mentioning that enforcing the error # on return 
from probe defeats the deferred probing.

MBR, Sergei
