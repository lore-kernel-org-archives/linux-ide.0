From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] cmd64x: don't clear the other channels interrupt
Date: Fri, 16 Nov 2007 16:34:39 +0300
Message-ID: <473D9C6F.5070205@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200711091407.01369.sshtylyov@ru.mvista.com> <200711112252.58538.bzolnier@gmail.com> <200711132158.36205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:5700 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757073AbXKPNe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 08:34:27 -0500
In-Reply-To: <200711132158.36205.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, marogge@onlinehome.de, milon@wq.cz

Bartlomiej Zolnierkiewicz wrote:

>>>Make sure to not clear the other IDE channel's interrupt when clearing an IDE
>>>interrupt via the MRDMODE register.

>>>Thanks to Bart for finding a coding mistake.

>>Could you resend with "Signed-off-by:" and "Tested-by:" tags?

>>[ A reference to the problematic commit and crediting Martin for
>>  patiently bisecting the issue would score an extra points. :) ]

> Well, I dealt with it myself and just added "From:" (together
> with "Tested-by:"-s and an enhanced patch description)...

    Sorry, I somehow haven't noticed your mail in time... :-/

> For the future please always run your patches through
> scripts/checkpatch.pl before posting, this prevents missing

    Aye aye, sir! :-)

> "Signed-off-by:" (and few other issues :).

    Like not crediting testers? ;-)

> Thanks,
> Bart

WBR, Sergei
