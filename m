From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [V1] ata: sata_mv:- Handle return value of devm_ioremap.
Date: Mon, 9 Jan 2017 00:08:49 +0200
Message-ID: <CAHp75VdEdhikycdW=_Hu4wA2mBrgC0bXnrk7=hPnJkeGKxJthA@mail.gmail.com>
References: <1481564607-9626-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20170106204620.GD29909@mtj.duckdns.org> <CAHp75Vf79R8H89npEPjbWkWqPXEKAiJ4Yru98T5nYK0x+FZuxw@mail.gmail.com>
 <20170108184922.GC9403@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170108184922.GC9403@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 8, 2017 at 8:49 PM, Tejun Heo <tj@kernel.org> wrote:
> On Sat, Jan 07, 2017 at 12:52:57AM +0200, Andy Shevchenko wrote:
>> On Fri, Jan 6, 2017 at 10:46 PM, Tejun Heo <tj@kernel.org> wrote:
>> > On Mon, Dec 12, 2016 at 11:13:27PM +0530, Arvind Yadav wrote:
>> >> Here, If devm_ioremap will fail. It will return NULL.
>> >> Then hpriv->base = NULL - 0x20000; Kernel can run into
>> >> a NULL-pointer dereference. This error check will avoid
>> >> NULL pointer dereference.
>> >>
>> >> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> >
>> > Applied to libata/for-4.10-fixes.
>>
>> Hold on, why not to convert to devm_ioremap_resource() ?
>
> Care to send the patch?

Incremental or substitute?


-- 
With Best Regards,
Andy Shevchenko
