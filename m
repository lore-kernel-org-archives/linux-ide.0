From: "Thomas Evans" <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Wed, 23 Jan 2008 22:39:24 -0500
Message-ID: <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com>
	 <4794CB8B.1070600@gmail.com> <4795545E.5010908@gmail.com>
	 <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>
	 <4796DC44.6010100@gmail.com>
	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>
	 <4797ECF3.5000306@gmail.com>
	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>
	 <4797F8D0.6060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:7600 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYAXDjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 22:39:25 -0500
Received: by nz-out-0506.google.com with SMTP id s18so63874nze.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Jan 2008 19:39:24 -0800 (PST)
In-Reply-To: <4797F8D0.6060302@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Um, I can, but it's not all that different than the others - is there
something I am missing that would collect more info in the logs?

Thanks,

...tom

On Jan 23, 2008 9:32 PM, Tejun Heo <htejun@gmail.com> wrote:
>
> Thomas Evans wrote:
> > I hadn't tried that until just now - I have 2 3124 cards, 1 without
> > internal connections.
> > Just tried the 1 with internal sata ports - it fails in the same way on
> > a single drive.
>
> There are cable which have SATA connector on one side and e-SATA on the
> other.  You can connect harddrives directly using such cables.  Can you
> please post the failing log?
>
> --
> tejun
>
