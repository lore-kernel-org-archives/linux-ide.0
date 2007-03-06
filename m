From: "Andrew Grover" <andy.grover@gmail.com>
Subject: Re: [PATCH 1/3] libata: add missing PM callbacks
Date: Tue, 6 Mar 2007 02:20:37 -0800
Message-ID: <c0a09e5c0703060220l18246d19kd1645a16067d1b3d@mail.gmail.com>
References: <20070302083001.GK20322@htj.dyndns.org>
	 <45E8B3C8.2090009@garzik.org> <45E8E749.4030406@gmail.com>
	 <20070306080509.GA2040@elf.ucw.cz> <45ED22AB.4090901@gmail.com>
	 <20070306082212.GC2040@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:63357 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbXCFKUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 05:20:38 -0500
Received: by wr-out-0506.google.com with SMTP id 37so1832994wra
        for <linux-ide@vger.kernel.org>; Tue, 06 Mar 2007 02:20:38 -0800 (PST)
In-Reply-To: <20070306082212.GC2040@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 3/6/07, Pavel Machek <pavel@ucw.cz> wrote:
> > 1. drop !CONFIG_PM configuration
> > 2. continue to sprinkle #ifdef's over device drivers
> > 3. find out prettier way to mark PM functions
>
> ...of 3., and code is nicely generic and fairly simple. I thought it
> would be too much work to implemente it, and it would get too messy.
>
> Given that it is so simple, I believe 3. is the best option. We can
> still do 1. in future if we feel like so...

How much room does it actually save? And, can we maybe have some
actual embedded people saying they need this special treatment?

-- Andy
