From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: drivers/ide/ide.c question
Date: Fri, 17 Dec 2004 20:22:35 +0100
Message-ID: <58cb370e04121711226a83e7a2@mail.gmail.com>
References: <Pine.LNX.4.58.0412152228380.22022@shell3.speakeasy.net>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:47215 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262128AbULQTWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2004 14:22:38 -0500
Received: by wproxy.gmail.com with SMTP id 55so90108wri
        for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2004 11:22:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0412152228380.22022@shell3.speakeasy.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vlobanov <vlobanov@speakeasy.net>
Cc: linux-ide@vger.kernel.org

On Wed, 15 Dec 2004 22:38:25 -0800 (PST), vlobanov
<vlobanov@speakeasy.net> wrote:
> Hello,
> 
> I was reading through the ide_setup() function, specifically the portion
> which scans through the "idex=" parameter options, and I have a
> question. It might be silly (and if so, I apologize for the noise), but
> I can't seem to grok it.
> 
> The comment pertaining to 'static const char *ide_words[] = { ... };'
> states that indices -8, -9, and -10 are reserved, in order to ease the
> hardcoding of the code that follows. However, as far as I can tell,
> these indices are not used anywhere in a significant way --
> 
> In the check to ensure that the chipset is not redefined, only indices
> (-11 ... -18) play any significant role. And in the big switch
> statement, indices (-8 ... -10) are simply dropped into the bad_option
> case.
> 
> So, what's so special about these indices? Is there any reason why -8
> can't be used for other, possibly nefarious :), purposes?

The only special thing about hard-coded indexes is that if you have
something like this in the ide_words[] table:

"autotune", "noautotune", "minus8", "swapdata", "bswap",

and if i.e. you delete "minus8" from the table you have to
change numbers used by "swapdata", "bswap" etc. or instead
put NULL in place of "minus8".

> The reason why I ask is that I want to try to fix bug 3907 in
> bugzilla.kernel.org, and want to place the "nodma" option right next to
> the "dma" option for clarity, but that would require replacing "minus8"
> with "ata66" which the comment warns against ominously.

Is there a valid reason for adding a new parameter to the IDE core
which should belong to specific host drivers?  This option won't work
with some of drivers without modificating them anyway.

Could you just fix documentation instead?

Thanks.

> Thanks in advance,
> Vadim Lobanov
