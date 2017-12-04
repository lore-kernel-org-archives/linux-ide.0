From: Tejun Heo <tj@kernel.org>
Subject: Re: Wiki account on ata.wiki.kernel.org?
Date: Mon, 4 Dec 2017 13:00:32 -0800
Message-ID: <20171204210032.GJ2421075@devbig577.frc2.facebook.com>
References: <c5a9fde7-0950-08bb-bef4-eef563d0890a@uni-muenster.de>
 <20171204202413.GG2421075@devbig577.frc2.facebook.com>
 <f2bb97f4-9006-6a38-a8b5-e7f581255d18@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:39273 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdLDVAg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2017 16:00:36 -0500
Received: by mail-qt0-f170.google.com with SMTP id k19so24274822qtj.6
        for <linux-ide@vger.kernel.org>; Mon, 04 Dec 2017 13:00:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f2bb97f4-9006-6a38-a8b5-e7f581255d18@uni-muenster.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: m.wa@wwu.de
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Dec 04, 2017 at 09:36:46PM +0100, Matthias Peter Walther wrote:
> okay thanks, I guess you've been the one who unlocked my account today.
> So you wouldn't spend the time to update that page?

That wasn't me and no I wouldn't.

> Where is the in-kernel documentation? I'm rather new to this. Is this
> within the kernel's git or where do I find it?

There's driver-api/libata.rst in the source tree but it's also
horribly outdated.  If we want up-to-date hardware support
documentation, I think we'd have to move it into the source code and
generate it from there.  However, I'm not sure how useful it all
really is.  The wiki hasn't been updated for eons, most other
subsystems don't have the counterpart, and not much is really painful
because of that.

But, regardless of what we're gonna do in the long term, if someone is
interested in keeping it fresh, that is really great.  The other thing
is that libata development is pretty stale at this point, so maybe we
don't need a grand long term plan and just bringing the wiki
up-to-date is enough.

Thanks.

-- 
tejun
