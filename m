From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [Linux 2.6.27-rc2] suspend to disk, libata problem
Date: Fri, 8 Aug 2008 09:57:43 +0200
Message-ID: <8db1092f0808080057n588fff24r940b20358f5869f3@mail.gmail.com>
References: <8db1092f0808071530o2f41b1b9p227dbb920e0a3961@mail.gmail.com>
	 <alpine.LFD.1.10.0808071541150.3462@nehalem.linux-foundation.org>
	 <200808080052.03443.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:37205 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYHHH5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 03:57:44 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1435653wfd.4
        for <linux-ide@vger.kernel.org>; Fri, 08 Aug 2008 00:57:43 -0700 (PDT)
In-Reply-To: <200808080052.03443.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Wilcox <matthew@wil.cx>

2008/8/8 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday, 8 of August 2008, Linus Torvalds wrote:

>>
>> Any chance to get this bisected? I realize that it's quite a few reboots,
>> and _maybe_ Jeff or Bartlomiej can just say "oh, duh, it's because of
>> Xyz", but the more likely thing is that without a bisect people will be
>> flailing around fairly blindly..
>
> Looks like another incarnation of http://bugzilla.kernel.org/show_bug.cgi?id=11178
>
> Maciej, can you try the patch at
> http://bugzilla.kernel.org/attachment.cgi?id=17043&action=view
> please?
>
> Thanks,
> Rafael
>

Thanks
s2disk works, but I notice other problem during resume and normal
booting. Kernel very often stoped booting while detect PATA drive (DVD
drive):
http://unixy.pl/maciek/download/kernel/2.6.27-rc2/msi_path/img_0008.jpg

On 2.6.25.* stable it never happen.
On 2.6.26-rc* and 2.6.26.* stable -  sometimes
On 2.6.27-rc* - very often

So I try disable CONFIG_IDE and test s2disk again. Problem seems has
gone But a I have many warnings during resume (USB related?):
http://unixy.pl/maciek/download/kernel/2.6.27-rc2/without_config_ide/dmesg_resume_ahci.txt

Config kernel without CONFIG_IDE:
http://unixy.pl/maciek/download/kernel/2.6.27-rc2/without_config_ide/config-2.6.27-rc2


@Linus
If anybody tells me how do it, why not. I'm not kernel programmer (or
programmer in  generality). I'm only Linux user - newbie - who found
problem in kernel and think that better report it before stable 2.6.27
will be released than after.

Regards
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
