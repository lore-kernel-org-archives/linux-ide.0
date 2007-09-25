From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 12:28:22 -0600
Message-ID: <46F95346.7090601@gmail.com>
References: <46F7FBCB.4030803@gmail.com> <46F8665A.4000206@garzik.org> <46F94FF3.1000400@gmail.com> <20070925182123.GC2367@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:32307 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbXIYS2a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 14:28:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1777543rvb
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 11:28:29 -0700 (PDT)
In-Reply-To: <20070925182123.GC2367@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Jens Axboe wrote:
> On Tue, Sep 25 2007, Berck E. Nash wrote:
>> Jeff Garzik wrote:
>>
>>> The first step would be to clone the "upstream" branch of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>>
>>> and see if the problem is reproducible there.  If yes, then you have
>>> narrowed down the problem to something my ATA devel tree has introduced
>>> into -mm.
>> Nope, you're off the hook.  The libata tree works great, so it must be
>> something else in -mm conflicting.

Whoops, sorry!  I just lied.  I'm a git newbie, and failed to actually
get the "upstream" branch the first time, so rc8 is clean, but it fails
when I actually pull the upstream branch.  I'll git bisect and get back
to you.

BErck
