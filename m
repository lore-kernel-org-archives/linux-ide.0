From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Fri, 25 Jan 2008 00:11:04 +0900
Message-ID: <4798AA88.5080107@gmail.com>
References: <4794459C.3090200@gmail.com> <4795545E.5010908@gmail.com>	 <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>	 <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com> <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:26534 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYAXPLN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 10:11:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so311571rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 07:11:10 -0800 (PST)
In-Reply-To: <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> I will work on getting that log - is there anything non-kernel that
> may have changed that could cause this?  udev changes or something
> like that?  Just so odd for it to start failing after having worked
> for so long.

Nope, this is way before userland has any say in it.  The same kernel
version which used to work doesn't work on two slightly different
machines.  That's just weird.  :-(

-- 
tejun
