From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 18:38:37 +0100
Message-ID: <200901051838.37608.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <200901051815.24847.bzolnier@gmail.com> <20090105171935.4e0c077e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:44458 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbZAERj1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 12:39:27 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2894266muf.1
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2009 09:39:24 -0800 (PST)
In-Reply-To: <20090105171935.4e0c077e@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

On Monday 05 January 2009, Alan Cox wrote:
> > Both are done by block layer.  The former is controlled by the user-space
> > while the latter is controlled by the block driver.
> 
> And in the old IDE case erroneously set for any device reporting CFA via
> the kernel. Queue flag management belongs in user space because its far
> more complex than you seem to think to get it right.

Please stop playing straw man in almost every your mail.  Doing it once
in a while can be intriguing or even enjoyable but doing it on daily basis
kills any sensible debate...

There is nothing incorrect in setting non-rotational queue flag for CF
devices [1] and I wasn't suggesting where it should belong -- I was solely
describing how things look up currently.

[1] in fact some SSD devices present themselves as CF devices

Thanks,
Bart
