From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Un-break ATA blacklist
Date: Tue, 7 Oct 2014 13:24:23 -0400
Message-ID: <20141007172423.GA31328@mtj.dyndns.org>
References: <20141007112638.20944.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:43997 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbaJGRY3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Oct 2014 13:24:29 -0400
Received: by mail-vc0-f169.google.com with SMTP id hy4so5196174vcb.14
        for <linux-ide@vger.kernel.org>; Tue, 07 Oct 2014 10:24:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141007112638.20944.qmail@ns.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org, stevenhoneyman@gmail.com

On Tue, Oct 07, 2014 at 07:26:38AM -0400, George Spelvin wrote:
> lib/glob.c provides a new glob_match() function, with arguments in
> (pattern, string) order.  It replaced a private function with arguments
> in (string, pattern) order, but I didn't swap the call site...
> 
> The result was the entire ATA blacklist was effectively disabled.
> 
> The lesson for today is "I f***ed up *how* badly *how* many months ago?",
> er, I mean "Nobody Tests RC Kernels On Legacy Hardware".
> 
> This was not a subtle break, but it made it through an entire RC
> cycle unreported, presumably because all the people doing testing
> have full-featured hardware.
> 
> (FWIW, the reason for the argument swap was because fnmatch() does it that
> way, and for a while implementing a full fnmatch() was being considered.)
> 
> Fixes: 428ac5fc056e0 (libata: Use glob_match from lib/glob.c)
> Reported-by: Steven Honeyman <stevenhoneyman@gmail.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=71371#c21
> Signed-off-by: George Spelvin <linux@horizon.com>
> Cc: <stable@vger.kernel.org> # 3.17

Oops, lol.  Appiled to libata/for-3.17-fixes.

Thanks!

-- 
tejun
