From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: promise ncq
Date: Sat, 14 Apr 2007 00:51:56 +0300
Message-ID: <5d96567b0704131451n1d420460seecd99b79d1c0554@mail.gmail.com>
References: <200704132127.l3DLRPe3020473@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:34012 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030856AbXDMVv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 17:51:58 -0400
Received: by nz-out-0506.google.com with SMTP id s1so855680nze
        for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2007 14:51:57 -0700 (PDT)
In-Reply-To: <200704132127.l3DLRPe3020473@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

I am using a driver supplied by promise called stex.

On 4/14/07, Mikael Pettersson <mikpe@it.uu.se> wrote:
> On Fri, 13 Apr 2007 23:43:03 +0300, "Raz Ben-Jehuda(caro)" <raziebe@gmail.com> wrote:
> > Jeff hello
> > I have a promise cotroller that exports its disks as logical volumes
> > to the OS, and the OS sees them as physical drives . kernel is 2.6.17.
> > I have set  a disk manualy to support ncq using a command line tool
> > provided by promise.
> > I have "echo 1 > /sys/block/..../dev/rescan" and the ncq bit did not
> > show in dmesg.
> > queue_depth is set to 32 no matter if ncq is enabled or not. I cannot echo
> > to queue_depth , I get "permision denied" error ( libata faq says i
> > can do that ).
>
> Assuming you're using libata's sata_promise driver and not Promise's
> driver, then the answer is that sata_promise doesn't yet support NCQ.
> It will display the disk's NCQ capability, but NCQ won't be activated.
>
> Implementing NCQ is on the TODO list, but I'm ignoring it as long as
> the problems with SATAII/3Gbps disks remain unresolved.
>
> /Mikael
>


-- 
Raz
