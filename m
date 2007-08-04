From: "David Madsen" <david.madsen@gmail.com>
Subject: Re: ASUS P5W motherboard PMP
Date: Fri, 3 Aug 2007 23:38:31 -0700
Message-ID: <ec7e30370708032338x250c4689j49aabfcac373837f@mail.gmail.com>
References: <ec7e30370708031753m668f68a2kd67ad8278eb78675@mail.gmail.com>
	 <46B414C0.2060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:32785 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbXHDGif (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 02:38:35 -0400
Received: by py-out-1112.google.com with SMTP id d32so1718960pye
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 23:38:34 -0700 (PDT)
In-Reply-To: <46B414C0.2060606@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Yes, I patched the 2.6.22.1 vanilla kernel with the libata patch from here.

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.22.1-20070803.tar.bz2

--David Madsen

On 8/3/07, Tejun Heo <htejun@gmail.com> wrote:
> David Madsen wrote:
> > * The long boot delay on ASUS boards with on-board PMP chips should be
> >   fixed by this patchset but I don't have such a board or Sil4723
> >   which is used on those boards, so I'm not sure.  Anyone up for
> >
> >   testing?
> >
> > Hi Tejun,
> >
> >   I have one of the above mentioned ASUS motherboards that has a PMP device connected
> > to one of the SATA ports on the ICH7R southbridge.  I came across your libata patches
> > and mention of a tester for this motherboard so I downloaded the patchset and tried it
> >
> > on my motherboard.  Booting with the new kernel appears to have the same errors and delay
> > that the previous kernel had.
> >
> > I have attached a tar file with the dmesg output as well as my kernel's .config.  I'm not
> >
> > sure what else may be of use to you to help with the debugging so let me know if I can
> > provide you with any more info.
>
> Please cc linux-ide@vger.kernel.org next time.
>
> You patched the kernel with PMP patches, right?
>
> --
> tejun
>
