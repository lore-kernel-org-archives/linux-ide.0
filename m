From: "Thomas Evans" <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Thu, 24 Jan 2008 11:40:26 -0500
Message-ID: <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>
	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>
	 <4797ECF3.5000306@gmail.com>
	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>
	 <4797F8D0.6060302@gmail.com>
	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>
	 <47980B71.3000408@gmail.com>
	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>
	 <4798AA88.5080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:21123 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYAXQkb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 11:40:31 -0500
Received: by wr-out-0506.google.com with SMTP id c49so106558wra.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 08:40:27 -0800 (PST)
In-Reply-To: <4798AA88.5080107@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

That's what I thought - is there another chip that support the 4726
PMP that you think I could try?

...tom


On Jan 24, 2008 10:11 AM, Tejun Heo <htejun@gmail.com> wrote:
> Thomas Evans wrote:
> > I will work on getting that log - is there anything non-kernel that
> > may have changed that could cause this?  udev changes or something
> > like that?  Just so odd for it to start failing after having worked
> > for so long.
>
> Nope, this is way before userland has any say in it.  The same kernel
> version which used to work doesn't work on two slightly different
> machines.  That's just weird.  :-(
>
> --
> tejun
>
