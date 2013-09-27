From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Fri, 27 Sep 2013 09:28:12 -0400
Message-ID: <20130927132812.GB3205@htj.dyndns.org>
References: <523EF645.7050808@linux.com>
 <20130922153959.GB28571@htj.dyndns.org>
 <523F10BB.8020503@gmail.com>
 <20130922160551.GD28571@htj.dyndns.org>
 <CAAsK9AF_sJFcNTkCAR1vE5O80bJ0OoUL2AykqOoUvZt=5AYnxQ@mail.gmail.com>
 <20130926140930.GA3482@htj.dyndns.org>
 <CAPXgP13UZYEgdm6er8HrsoCiajwAXEzg_jn4Q7OgY2zDMGv-9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:61200 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab3I0N2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Sep 2013 09:28:16 -0400
Received: by mail-qa0-f54.google.com with SMTP id bv4so461396qab.20
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 06:28:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPXgP13UZYEgdm6er8HrsoCiajwAXEzg_jn4Q7OgY2zDMGv-9g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: Levente Kurusa <levex@linux.com>, linux-ide@vger.kernel.org

Hello,

On Thu, Sep 26, 2013 at 07:57:35PM +0200, Kay Sievers wrote:
> > Kay, Levente is seeing the above output from
> > drivers/ata/ata_piix.c::piix_init_sata_map().  Any ideas?
> 
> Yes, the dev_printk() versions are "atomic lines", cannot be
> concatenated with other invocations of printk() like the normal
> printks can. The reason is that the dev_* versions carry structured
> data to userspace, and there, the logs are indexed by device.
> 
> We don't want to allow the convenient but very racy and
> non-thread-safe concatenation lines for dev_* versions, they might
> pick up unrelated text fragments from other threads into the logged
> text line; userspace (non-human tools) can not really cope with that.
>
> So, the printk should not use the dev_* version, or print all in one
> call, if a single line is expected.

I see.  Levente, can you please go ahead and update the patch?

Thanks.

-- 
tejun
