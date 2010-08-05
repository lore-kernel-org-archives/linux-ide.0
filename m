From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 06/15] drivers: ide: ide-tape.c removed duplicated
 #include
Date: Thu, 5 Aug 2010 17:31:06 +0200
Message-ID: <20100805153106.GA27313@a1.tnic>
References: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
 <1281016299-23958-6-git-send-email-andrea.gelmini@gelma.net>
 <20100805142736.GA25859@a1.tnic>
 <AANLkTintVGc+M0uep6gBWKhgoDXFJ80ZfJvJTAi5KzKE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47092 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755696Ab0HEPbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2010 11:31:09 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTintVGc+M0uep6gBWKhgoDXFJ80ZfJvJTAi5KzKE@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Thu, Aug 05, 2010 at 05:06:03PM +0200

> 2010/8/5 Borislav Petkov <bp@alien8.de>:
> 
> Hi Borislav,
>    and thanks for your answer.
> 
> > I don't see the duplicates, are you sure about this?
>    You are right. I'm wrong.
>    Well, I'm trying to figure out how I did  this stupid mistake.
>    I was playing with some cloned kernel tree, to check if I found
> things already fixed in next tree.
>    Maybe I made a mess pushing and pulling.
> 
>    Sorry, I didn't mean to waste your time.

You didn't, no worries. You better keep looking, the next real bug is
right around the corner :).

-- 
Regards/Gruss,
Boris.
