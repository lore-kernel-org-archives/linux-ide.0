From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata-sff: fix 32-bit PIO regression
Date: Mon, 09 Feb 2009 19:42:48 +0300
Message-ID: <49905D08.4050302@ru.mvista.com>
References: <200902082253.07438.sshtylyov@ru.mvista.com> <Pine.LNX.4.64.0902082108290.18661@blonde.anvils> <498F73A5.2070300@ru.mvista.com> <Pine.LNX.4.64.0902091016520.14410@blonde.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16759 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753218AbZBIQmZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 11:42:25 -0500
In-Reply-To: <Pine.LNX.4.64.0902091016520.14410@blonde.anvils>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl

Hugh Dickins wrote:

>>>Yes, looks nice, and works for me.  My only criticism would be,
>>>minor issue unchanged by your patch, that actually "slop" isn't
>>>unlikely enough to deserve an "unlikely" - slop of 1 or 3 is
>>>unlikely, but slop of 2 is quite common.

>> Common on what types of ATAPI commands? I can hardly believe that they are
>>common on the block I/O...

> When I checked (mounting and listing a CD), about 34% of
> commands had slop 2.

    Hm, that probably involved the raw block reads. I don't remember the raw 
sector length off-hand but it may well be just even, not divisble by 4.

> But you're right, now I try copying
> a large file, there's no slop involved in that at all.

> Hugh

MBR, Sergei
