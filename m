From: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: ahci rmmodable and shouldn't
Date: Thu, 16 Sep 2010 14:58:56 -0700 (PDT)
Message-ID: <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net>
References: <201009162256.04765.pedrogfrancisco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.115.56]:37373 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756343Ab0IPV7G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Sep 2010 17:59:06 -0400
Received: from www.xenotime.net ([2001:470:0:13c::4834:7338]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 16 Sep 2010 14:58:56 -0700
In-Reply-To: <201009162256.04765.pedrogfrancisco@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Francisco <pedrogfrancisco@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Thu, September 16, 2010 2:56 pm, Pedro Francisco wrote:
> I reported this here for 2.6.35.4 -- http://lkml.org/lkml/2010/9/7/321 --
> but still happens on latest -git.

Please copy linux-ide@vger.kernel.org on ATA issues.
(done now)

> `rmmod ahci' works even if the module is being used (`lsmod' thinks it's
> not being used but rmmoding ahci triggers filesystem erros and I've to
> force a reboot).
>
> I've been told it's the same as plugging a cable. IMO that's what
> /sys/stuff/eject_or_similar is to, not `rmmod ahci'.
>
>
> I *assume* it was caused by the split between libahci & ahci, since in
> 2.6.32
> `rmmod ahci' is impossible because it's marked as being in use. Didn't try
>  `rmmod -f ahci' but that's not the point.
>
>
> I'm posting again about this because it doesn't make sense to me the
> actual behaviour.
>
> TIA,
> --
> Pedro
> --

-- 
~Randy

