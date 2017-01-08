From: Tejun Heo <tj@kernel.org>
Subject: Re: [V1] ata: sata_mv:- Handle return value of devm_ioremap.
Date: Sun, 8 Jan 2017 13:49:22 -0500
Message-ID: <20170108184922.GC9403@mtj.duckdns.org>
References: <1481564607-9626-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20170106204620.GD29909@mtj.duckdns.org>
 <CAHp75Vf79R8H89npEPjbWkWqPXEKAiJ4Yru98T5nYK0x+FZuxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33441 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdAHSt3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jan 2017 13:49:29 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75Vf79R8H89npEPjbWkWqPXEKAiJ4Yru98T5nYK0x+FZuxw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jan 07, 2017 at 12:52:57AM +0200, Andy Shevchenko wrote:
> On Fri, Jan 6, 2017 at 10:46 PM, Tejun Heo <tj@kernel.org> wrote:
> > On Mon, Dec 12, 2016 at 11:13:27PM +0530, Arvind Yadav wrote:
> >> Here, If devm_ioremap will fail. It will return NULL.
> >> Then hpriv->base = NULL - 0x20000; Kernel can run into
> >> a NULL-pointer dereference. This error check will avoid
> >> NULL pointer dereference.
> >>
> >> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >
> > Applied to libata/for-4.10-fixes.
> 
> Hold on, why not to convert to devm_ioremap_resource() ?

Care to send the patch?

Thanks.

-- 
tejun
