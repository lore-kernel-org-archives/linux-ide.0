From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/3] ide-{cd,floppy}: do not map all cmds to an sg
Date: Thu, 12 Mar 2009 18:10:02 +0100
Message-ID: <9ea470500903121010y26ced87ck9f11a60f7b91a06b@mail.gmail.com>
References: <1236158216-23052-1-git-send-email-petkovbb@gmail.com>
	 <200903111734.28956.bzolnier@gmail.com>
	 <20090312071248.GA26881@liondog.tnic>
	 <200903121758.56808.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:57204 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbZCLRKF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 13:10:05 -0400
In-Reply-To: <200903121758.56808.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

> Ah I see it now but this is a separate issue from the original one
> (OOPS on DEBUG_VIRTUAL=y)!

Hmm, no, this oopses on the same DEBUG_VIRTUAL check due to rq->data being NULL,
it is the same issue happening when entered from a different path:

> I somehow missed it (probably becasue
> patch description fails to mention this important information)
> and thus tried to be smart while merging the patch...

... and yes, we could add something along the lines of "Make sure ->data pointer
in sg mapping is set from all command issuing paths" to the commit message. My
bad, I'm being too economical wrt commit messages, as always :).

-- 
Regards/Gruss,
Boris
