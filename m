From: Raz <raziebe@gmail.com>
Subject: Re: ata error codes
Date: Fri, 25 Jan 2008 13:13:33 +0200
Message-ID: <5d96567b0801250313x4f5d0b62q6147ec5d873bb002@mail.gmail.com>
References: <5d96567b0801150939y3802a73aqcbab553af5fe6015@mail.gmail.com>
	 <47945202.8090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:44330 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYAYLNg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 06:13:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1011649wah.23
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 03:13:36 -0800 (PST)
In-Reply-To: <47945202.8090107@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I saw in Jeff Garzik the link to http://www.t13.org/ for the ata 's
documentation. Unfortunately , I do seem to be able to correlate the
errors in the specs to the errors appear in dmesg. If you would be
kind to direct me a little, I would write a code that dumps more
information, something like ata_error err = <error code > utility.

thank you

On Jan 21, 2008 10:04 AM, Tejun Heo <htejun@gmail.com> wrote:
>
> Raz wrote:
> > Mr Garzik Hello
> > ata errors are some times cryptic. I am refering to this line, in the
> > ata_qc_timeout which holds lots of information.
> > printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
> >  ap->id,
> >  qc->tf.command,
> >  drv_stat,
> >  host_stat)
> >
> > These errors varries , and many times SMART cannot help. Is there a
> > repository for these error codes, (  ata_dump_status isn't enough ).
> > Is there an API to get these error codes translated to human readable format ?
> > thank you
>
> Those values are directly from hardware registers and can be decoded
> with information from ATA and SFF specs.  It could be nice to have
> decoded strings but I'm not too sure.  Even when decoded, they're pretty
> cryptic and don't carry too much information by themselves.
>
> --
> tejun
>



-- 
Raz
