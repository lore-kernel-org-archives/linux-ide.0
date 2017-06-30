From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] sata_highbank: fix error return code in
 ahci_highbank_probe()
Date: Fri, 30 Jun 2017 16:24:11 -0500
Message-ID: <20170630162411.Horde.GjeJ-C8ZzX8IfXgaH6AiBhY@gator4166.hostgator.com>
References: <20170630050306.GA17486@embeddedgus>
 <b73bd295-238a-c0b0-de14-5f5186600217@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b73bd295-238a-c0b0-de14-5f5186600217@cogentembedded.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Quoting Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:

> On 06/30/2017 08:03 AM, Gustavo A. R. Silva wrote:
>
>> Propagate the return value of platform_get_irq on failure.
>
>    Needs the same explanations as the sata_rcar patch.
>

Yep, I already sent v2 a minute ago.

Thanks!
--
Gustavo A. R. Silva
