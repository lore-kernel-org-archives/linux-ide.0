From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
Date: Wed, 07 Apr 2010 13:52:35 -0400
Message-ID: <4BBCC663.2060001@teksavvy.com>
References: <4BBBB975.7000203@teksavvy.com> <4BBBDFE3.4000602@gmail.com> <4BBBFC3A.3000605@teksavvy.com> <4BBC1400.6030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:29235 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755913Ab0DGRwh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2010 13:52:37 -0400
In-Reply-To: <4BBC1400.6030106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

On 07/04/10 01:11 AM, Tejun Heo wrote:
> Hello,
>
> On 04/07/2010 12:30 PM, Mark Lord wrote:
>> The cast was there already, so I left it there.
>> Just moved it to cover the entire compile-time expression as a unit,
>> rather than just the (u64)1  as the existing code did it.
>
> Oh, but there's functional difference between the two.  In the
> original place, the initial casting ripples through the whole
> expression making each step of the calculation u64.  It's meant to
> prevent int overflow during calculation (which isn't necessary in the
> current expression BTW) but if you cast the end result, it doesn't
> really mean anything.  If you want to kill the casting, kill it but
> moving the casting outside doesn't make much sense.  Can you repost
> without moving the cast?
..

No.  But I can/did repost with it completely gone.
