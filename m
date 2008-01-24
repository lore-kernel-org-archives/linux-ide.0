From: "Thomas Evans" <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Thu, 24 Jan 2008 10:07:21 -0500
Message-ID: <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>
References: <4794459C.3090200@gmail.com> <4795545E.5010908@gmail.com>
	 <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>
	 <4796DC44.6010100@gmail.com>
	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>
	 <4797ECF3.5000306@gmail.com>
	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>
	 <4797F8D0.6060302@gmail.com>
	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>
	 <47980B71.3000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:61458 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYAXPHX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 10:07:23 -0500
Received: by wr-out-0506.google.com with SMTP id c49so55506wra.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 07:07:22 -0800 (PST)
In-Reply-To: <47980B71.3000408@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

I will work on getting that log - is there anything non-kernel that
may have changed that could cause this?  udev changes or something
like that?  Just so odd for it to start failing after having worked
for so long.

...tom

On Jan 23, 2008 10:52 PM, Tejun Heo <htejun@gmail.com> wrote:
> Thomas Evans wrote:
> > Um, I can, but it's not all that different than the others - is there
> > something I am missing that would collect more info in the logs?
>
> Well, at times, small differences can tell us more information.  The
> best we can do here is to gather as much information as possible.  Even
> if we fail to solve the issue now, it may come handy later when similar
> instances happen and more clues are gathered.
>
> --
> tejun
>
