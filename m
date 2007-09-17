From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: ata_piix, laptop cdrom, ICH7: EH, limiting speed to PIO
Date: Mon, 17 Sep 2007 21:18:26 +0400
Message-ID: <f19298770709171018x6c4a150yfe6e490d7cc1721b@mail.gmail.com>
References: <20070911212030.GA2817@slk.laptop>
	 <6bffcb0e0709120933p6d58127fv3c85076fe41daaca@mail.gmail.com>
	 <20070912200706.GA2620@slk.laptop> <46E849B7.9040402@googlemail.com>
	 <20070912212025.GB2620@slk.laptop> <46E8663E.3080205@googlemail.com>
	 <46ED19F0.8060205@gmail.com>
	 <ac0be4d70709170257o62e856f4re049c968ab5590a7@mail.gmail.com>
	 <46EE66EA.3090902@gmail.com>
	 <ac0be4d70709170505l6c4bba29pc8ad1c92fcb16ae9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:18291 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbXIQRS2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 13:18:28 -0400
Received: by ug-out-1314.google.com with SMTP id z38so769605ugc
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 10:18:27 -0700 (PDT)
In-Reply-To: <ac0be4d70709170505l6c4bba29pc8ad1c92fcb16ae9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Dolgov <dolgovs@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 9/17/07, Sergey Dolgov <dolgovs@gmail.com> wrote:
> On 9/17/07, Tejun Heo <htejun@gmail.com> wrote:
>
> [...]
> > >>>> BTW, this only happens when using libata of course. The
> > >>>> old CONFIG_IDE stuff works fine every time.
> > >>> This maybe one of libata weirdness (I really don't get it why some hardware
> > >>> works perfectly fine with an old IDE and don't work well with libata).
> > >> Hmmm... Is MWDMA2 mode used with ide driver too?
> > >>
> > >
> > > What's the best way to tell whether it does or not? (the log says
> > > "selected mode 0x22", see below)
> >
> > Yes, that's MWDMA2.  Hmm... We're seeing many cases where MWDMA doesn't
> > work with libata while it works fine with IDE but have no idea what's
> > going on yet.  :-(
> >
>

This may be well a hardware problem. Same laptop (HP nx7300 GB848ES)
works fine with either 2.6.22 and 2.6.23-rc. Maybe actually using the
DVD is required to trigger the problem on the next reboot?

Sergey, btw, on this laptop I've observed lockups twice with the -rc5.
After switching to 2.6.22 it was stable for at least one day. Can you
confirm or refute this?
