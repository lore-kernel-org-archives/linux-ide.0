From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Sat, 21 Apr 2007 17:11:10 +0200
Message-ID: <b637ec0b0704210811t3815ebb9y6f601637e5b21571@mail.gmail.com>
References: <88SeR-5Sf-15@gated-at.bofh.it>
	 <20070418160627.7ab77c30@the-village.bc.nu> <46263650.3080705@rtr.ca>
	 <46263859.2060309@gmail.com> <46265089.4000409@rtr.ca>
	 <46265307.7060405@rtr.ca> <4626596E.4040304@seclark.us>
	 <4627ABE9.8090906@redhat.com>
	 <b637ec0b0704201257l24d9e9c8ha31221c9c9d8da3e@mail.gmail.com>
	 <Pine.LNX.4.61.0704211631540.9989@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:3490 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbXDUPLM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2007 11:11:12 -0400
Received: by an-out-0708.google.com with SMTP id b33so1287639ana
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2007 08:11:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0704211631540.9989@yvahk01.tjqt.qr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Chuck Ebbert <cebbert@redhat.com>, Stephen.Clark@seclark.us, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, emisca <emisca.ml@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Jan,
mine does not pop running Linux but  only during the shutdown. As I
wrote before, switching from PATA to IDE has solved the problem for
me.
Regards,
Fabio


On 4/21/07, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >On Apr 20 2007 21:57, Fabio Comolli wrote:
> >
> > hda: TOSHIBA MK8025GAS, ATA DISK drive
>
> MK...? These sort of disks do that stupid pop. Mine -- a MK2003GAH --
> does it even while running Linux, if the disk is _idle_.
> See http://lkml.org/lkml/2006/11/15/413 - hope it provides some pointers.
>
> Regards,
> Jan
> --
>
