From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [Linux 2.6.27-rc2] suspend to disk, libata problem
Date: Fri, 08 Aug 2008 12:19:26 +0100
Message-ID: <489C2BBE.8040600@tuffmail.co.uk>
References: <8db1092f0808071530o2f41b1b9p227dbb920e0a3961@mail.gmail.com>	 <alpine.LFD.1.10.0808071541150.3462@nehalem.linux-foundation.org>	 <200808080052.03443.rjw@sisk.pl> <8db1092f0808080057n588fff24r940b20358f5869f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.181]:17530 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYHHLUC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 07:20:02 -0400
Received: by ik-out-1112.google.com with SMTP id c28so877533ika.5
        for <linux-ide@vger.kernel.org>; Fri, 08 Aug 2008 04:20:01 -0700 (PDT)
In-Reply-To: <8db1092f0808080057n588fff24r940b20358f5869f3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Wilcox <matthew@wil.cx>

Maciej Rutecki wrote:
> Thanks
> s2disk works, but I notice other problem during resume and normal
> booting. Kernel very often stoped booting while detect PATA drive (DVD
> drive):
> http://unixy.pl/maciek/download/kernel/2.6.27-rc2/msi_path/img_0008.jpg
> 
> On 2.6.25.* stable it never happen.
> On 2.6.26-rc* and 2.6.26.* stable -  sometimes
> On 2.6.27-rc* - very often
> 
> So I try disable CONFIG_IDE and test s2disk again. Problem seems has
> gone But a I have many warnings during resume (USB related?):
> http://unixy.pl/maciek/download/kernel/2.6.27-rc2/without_config_ide/dmesg_resume_ahci.txt

That looks like <http://bugzilla.kernel.org/show_bug.cgi?id=11263>.

Comment  #9 From Alan Stern 2008-08-07 07:30:17  [reply] -------  
This is a known problem caused by changes to the driver core.  I haven't had
time yet to update the USB suspend/resume infrastructure to match.

> Config kernel without CONFIG_IDE:
> http://unixy.pl/maciek/download/kernel/2.6.27-rc2/without_config_ide/config-2.6.27-rc2
> 
> 
> @Linus
> If anybody tells me how do it, why not. I'm not kernel programmer (or
> programmer in  generality). I'm only Linux user - newbie - who found
> problem in kernel and think that better report it before stable 2.6.27
> will be released than after.
> 
> Regards

