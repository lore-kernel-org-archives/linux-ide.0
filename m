From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH] Re: [git patches] libata updates - (improve post-reset device ready test) regression
Date: Fri, 9 May 2008 04:27:21 +0000
Message-ID: <dd18b0c30805082127h51fb9264w62fb22139d2d35e9@mail.gmail.com>
References: <20080506154847.GA15299@havoc.gtf.org>
	 <20080507145616.GA2210@gentoox2.trippelsdorf.de>
	 <48231DAF.7070900@garzik.org> <4823BD8E.40109@gmail.com>
	 <4823BE6F.1090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:43490 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673AbYEIE1W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 May 2008 00:27:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so228366and.103
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 21:27:21 -0700 (PDT)
In-Reply-To: <4823BE6F.1090307@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Markus Trippelsdorf <markus@trippelsdorf.de>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, marc.c.dionne@gmail.com, dl9pf@gmx.de, bug-track@fisher-privat.net, sitsofe@yahoo.com

On Fri, May 9, 2008 at 3:01 AM, Tejun Heo <htejun@gmail.com> wrote:
> Tejun Heo wrote:
>>
>> Markus, Alexey, Marc, which controllers are you using?
>
> Never mind, found the rest of the thread.
>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

This patch here is what fixes this issue for the macbook pro.
http://lkml.org/lkml/2008/5/8/245
regards;
-- 
Justin P. Mattock
