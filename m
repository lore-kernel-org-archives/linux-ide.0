From: Calvin Walton <calvin.walton@gmail.com>
Subject: Re: Spurious completions during NCQ
Date: Fri, 15 Feb 2008 10:00:00 -0500
Message-ID: <1203087600.25150.5.camel@zem>
References: <20080215134658.GB27745@vlad.carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:2674 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758118AbYBOPAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 10:00:09 -0500
Received: by py-out-1112.google.com with SMTP id u52so903495pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 07:00:08 -0800 (PST)
In-Reply-To: <20080215134658.GB27745@vlad.carfax.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, 2008-02-15 at 13:46 +0000, Hugo Mills wrote:
> I'm getting these on my Dell Latitude D830:
> 
> Feb 15 13:06:00 willow kernel: ata1.00: exception Emask 0x2 SAct 0x4 SErr 0x0 action 0x2 frozen
> Feb 15 13:06:00 willow kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x4 FIS=004040a1:00000002

>    In some cases, there are several cmd/res lines listed. It's
> happening about once an hour or so (not correlated with any other
> event that I can see). It doesn't seem to be affecting operation of
> the machine, but it's making me nervous.
> 
>    Can anyone set my mind at rest? (Or suggest a fix?)

You didn't mention which SATA chipset your laptop has, but some quick
googling says that it's AHCI. Until 2.6.24, the AHCI driver has a
problem where it'll report superious NCQ completions due to a bug in the
driver logic.

> uname -a reports:
> Linux willow 2.6.23.1-hrt3 #1 SMP Sun Nov 4 14:51:20 GMT 2007 x86_64 GNU/Linux

The fix is simple, upgrade your kernel to 2.6.24 :)

>    It's a kernel.org kernel with the patch for tickless operation on
> amd64.

Handily, the 2.6.24 kernel.org kernel includes amd64 tickless support
already.

-- 
Calvin Walton <calvin.walton@gmail.com>


