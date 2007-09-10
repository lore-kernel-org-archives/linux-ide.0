From: Raz <raziebe@gmail.com>
Subject: Re: a disk timeout and a disk state
Date: Mon, 10 Sep 2007 20:27:18 +0300
Message-ID: <5d96567b0709101027g3553fc7evfb42f8a7121c84ba@mail.gmail.com>
References: <5d96567b0709040009o2b1580fel4bcd91e629b5bef3@mail.gmail.com>
	 <46E25696.4000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:41352 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635AbXIJR1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2007 13:27:20 -0400
Received: by nz-out-0506.google.com with SMTP id s18so543891nze
        for <linux-ide@vger.kernel.org>; Mon, 10 Sep 2007 10:27:20 -0700 (PDT)
In-Reply-To: <46E25696.4000504@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 9/8/07, Tejun Heo <htejun@gmail.com> wrote:
> Raz wrote:
> > Jeff Hello
> >
> > We have in our machines several sata (mostly maxtor-segate) disks in an array.
> > These disks generate too many ata-io errors at clients sites.
> > From raid1 code I have learned that a re-write sometimes fixes a disk.
> >
> > Question: Why ?
> > Question: Does it always work ?
> > Question: Does rewriting a slow sector also reduces a disk error rate,
> > does it make any sense ?
>
> You need to post much more information to get anyone on the list interested.
I am not trying to fix any problem. I am asking a genera question. We
found that rewriting over a slow sector for several times, speeds up
the read from this sector.
My question is, does it make any sense to you,or Mr. garzik ?

thank you

> * lspci -nn
> * boot log (/var/log/boot.msg on some distros or the result of dmesg
> after boot)
> * kernel error messages (dmesg after errors)
>
> --
> tejun
>
>


-- 
Raz
