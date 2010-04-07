From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
Date: Wed, 07 Apr 2010 14:11:28 +0900
Message-ID: <4BBC1400.6030106@gmail.com>
References: <4BBBB975.7000203@teksavvy.com> <4BBBDFE3.4000602@gmail.com> <4BBBFC3A.3000605@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:42553 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0DGFLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2010 01:11:40 -0400
Received: by ywh2 with SMTP id 2so421711ywh.33
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2010 22:11:40 -0700 (PDT)
In-Reply-To: <4BBBFC3A.3000605@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

Hello,

On 04/07/2010 12:30 PM, Mark Lord wrote:
> The cast was there already, so I left it there.
> Just moved it to cover the entire compile-time expression as a unit,
> rather than just the (u64)1  as the existing code did it.

Oh, but there's functional difference between the two.  In the
original place, the initial casting ripples through the whole
expression making each step of the calculation u64.  It's meant to
prevent int overflow during calculation (which isn't necessary in the
current expression BTW) but if you cast the end result, it doesn't
really mean anything.  If you want to kill the casting, kill it but
moving the casting outside doesn't make much sense.  Can you repost
without moving the cast?

Thanks.

-- 
tejun
