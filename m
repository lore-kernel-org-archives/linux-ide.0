From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 9 Aug 2013 17:51:48 -0400
Message-ID: <20130809215148.GW20515@mtj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
 <20130809140358.GA20515@mtj.dyndns.org>
 <5204FE63.4010903@cogentembedded.com>
 <20130809145311.GK20515@mtj.dyndns.org>
 <5205617C.3010308@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:37791 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031254Ab3HIVvy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 17:51:54 -0400
Received: by mail-qe0-f45.google.com with SMTP id x7so2625027qeu.4
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 14:51:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5205617C.3010308@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

Hello, Sergei.

On Sat, Aug 10, 2013 at 01:39:08AM +0400, Sergei Shtylyov wrote:
>    I've started to work on my taskfile patchset about a year ago
> (while being in hospital) and worked on it on my copious free time
> (perhaps, not actively enough until I realized I don't have much
> time anymore), so it doesn't sound funny for me. If you're going to
> reject my patches once submitted outright, just tell me now, and
> with some regret for the wasted time, I'll find a better use for my
> free time, making a note to myself that the taskfile support in
> libata is hopeless and the maintainer doesn't care a bit about that.
> (In case you want an example of better taskfile support, look at
> IDE).

Can you explain why following the traditional TF definition matters so
much?  What practical difference does that make?  The new field is
part of command code definition, so it belongs with the rest of them
regardless of what the structure it's contained in is named.  If the
only reason for strictly separating TF regs into a separate struct is
because the spec says so, I indeed don't give a flying hoot.

Also, the only controller interface which would continue to be
relevant is ahci and that's it.  There will be no new development
whatsoever happening with TF based interface, ever.  I don't see why
you're getting all passive agressive about it.  If you have technical
arguments, dish them out.

Thanks.

-- 
tejun
