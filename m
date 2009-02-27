From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/10] ide: flags query macros
Date: Fri, 27 Feb 2009 09:21:07 +0100
Message-ID: <200902270921.08182.bzolnier@gmail.com>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com> <200902262235.58796.bzolnier@gmail.com> <20090227063822.GA26358@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:46720 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZB0IUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2009 03:20:10 -0500
In-Reply-To: <20090227063822.GA26358@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 27 February 2009, Borislav Petkov wrote:

[...]

> > BTW you may want to delay this patch after 2.6.30 as things should
> > become much more peaceful then.
> 
> What exactly is the timeframe here? Do you want to have the updated

Timeframe for 2.6.30 [1] or things becoming more peaceful [2]?

[1] We're in -rc6 so it is probably two-three more weeks before -final
    (then we have two weeks of merge window for draining ide tree queue).

[2] I think that it will happen once we finish unification of ATAPI support.

> version for the 2.6.31 merge window?

That would be ideal from my POV.

Thanks,
Bart
