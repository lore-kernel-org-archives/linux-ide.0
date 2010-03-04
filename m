From: s ponnusa <foosaa@gmail.com>
Subject: Re: Linux kernel - Libata bad block error handling to user mode
	program
Date: Thu, 4 Mar 2010 13:23:40 -0500
Message-ID: <f875e2fe1003041023o5c6a3ddclb3d05033a4542eac@mail.gmail.com>
References: <f875e2fe1003032052p944f32ayfe9fe8cfbed056d4@mail.gmail.com>
	 <20100303224245.ae8d1f7a.akpm@linux-foundation.org>
	 <f875e2fe1003040458o3e13de97v3d839482939b687b@mail.gmail.com>
	 <201003041637.o24GbtJX005739@alien.loup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41175 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab0CDSXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 13:23:41 -0500
In-Reply-To: <201003041637.o24GbtJX005739@alien.loup.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Hayward <hayward@loup.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, linux-mm@kvack.org

I have used O_DIRECT with aligned buffers of 4k size (the default
linux page size). I have even tried fadvise calls according to Linus's
suggestion of not using the O_DIRECT method. None of the above method
causes the write call to fail and media errors to be propagated to my
program. It is handled at the driver / kernel level (either by
retrying / remapping the sector).

Please advise.

Thanks.

On Thu, Mar 4, 2010 at 11:37 AM, Mike Hayward <hayward@loup.net> wrote:
> I always take it for granted, but forgot to mention, you should also
> use O_DIRECT to bypass the linux buffer cache. =A0It often gets in th=
e
> way of error propagation since it is changing your io requests into
> it's own page sized ios and will also "lie" to you about having
> written your data in the first place since it's a write back cache.
>
> The point is you have to disable all the caches everywhere or the
> error information will get absorbed by the caches.
>
> - Mike
>
