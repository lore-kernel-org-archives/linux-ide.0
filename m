From: Mark Lord <liml@rtr.ca>
Subject: Re: Need help understanding SATA error message.
Date: Mon, 31 Mar 2008 10:53:07 -0400
Message-ID: <47F0FAD3.9060001@rtr.ca>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca> <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se> <47EDBC87.8090109@rtr.ca> <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se> <47F0376F.2090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2157 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755186AbYCaOxI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 10:53:08 -0400
In-Reply-To: <47F0376F.2090000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tomas Lund <tlund@nxs.se>, linux-ide@vger.kernel.org

> XXXXX wrote (by private email):
> On Fri, Mar 28, 2008 at 9:59 AM, Mark Lord <liml@rtr.ca> wrote:
>> >  Duh..  actually, we were just discussing this very error in another thread.
>> >  The drive is really telling us that it hit an unrecoverable WRITE error
>> >  at sector 0a:24:f9 on the drive.  Bad sector.
>> >
>> >  There are patches queued up for 2.6.26 to automatically resume the cache
>> >  flush after the failed sector, but you'll still lose data at that sector.
>> >
>> >  Time for a low-level reformat, if the manufacturer has a utility for that.
>> >  Otherwise, RMA it.
> 
> The response to an unrecoverable sector shouldn't be 51/04 if the
> flush fails, it should be 51/10 or 51/40.
> 
> 51/04 would be the response if the FLUSH CACHE command was issued when
> there were still outstanding NCQ commands active.
..

Tejun:  I see we have another thread as well with FLUSH errors.
I really doubt that these are bad drives.
There's very likely a bug in libata / LLD there someplace.

-ml
