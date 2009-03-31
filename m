From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [RFC PATCHSET pata-2.6] ide: clean up ide-tape
Date: Tue, 31 Mar 2009 09:48:51 +0200
Message-ID: <20090331074851.GA9347@liondog.tnic>
References: <1237990673-8358-1-git-send-email-tj@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:54218 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZCaHs7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 03:48:59 -0400
Content-Disposition: inline
In-Reply-To: <1237990673-8358-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

On Wed, Mar 25, 2009 at 11:17:43PM +0900, Tejun Heo wrote:
> Hi, Bartlomiej, Jens.
> 
> This RFC patchset cleans up ide-tape.  Note that the patchset
> currently is only compile tested, so it's likely to be broken, so the
> RFC status.  Albert Lee is sending me some IDE tape drives, so I'll
> test these patches as soon as I receive them and repost with whatever
> necessary fixes.

By the way,

we may have another potential tester for ide-tape if we ask him nicely
enough :)

See http://bugzilla.kernel.org/show_bug.cgi?id=12874.

-- 
Regards/Gruss,
    Boris.
