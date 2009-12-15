From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 15 Dec 2009 15:37:59 +0100
Message-ID: <200912151537.59646.bzolnier@gmail.com>
References: <bug-14583-11633@http.bugzilla.kernel.org/> <200912150058.nBF0w8WR022101@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34676 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZLOOje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 09:39:34 -0500
Received: by ewy6 with SMTP id 6so18509ewy.29
        for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 06:39:32 -0800 (PST)
In-Reply-To: <200912150058.nBF0w8WR022101@demeter.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Tuesday 15 December 2009 01:58:08 am bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14583
> 
> 
> Tejun Heo <tj@kernel.org> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |kay.sievers@vrfy.org
> 
> 
> 
> 
> --- Comment #36 from Tejun Heo <tj@kernel.org>  2009-12-15 00:58:06 ---
> cc'ing Kay Sievers as he knows one or two things about how these things are
> going.  Bartlomiej, yeah, it would have been nice if the code base were shared
> but well nobody did that and it's good to have desktop integration.  It's

After reading project's homepage it is clear that it was done in order
for desktop integration.  However I couldn't find any previous discussions
about the best way to solve the problem on the net and it just seems like
there wasn't even any attempt of involving smartmontools developers in the
loop (I didn't look very carefully though).

While this is not a lot of code it is a very sensitive area and bugs
involving S.M.A.R.T. support (or firmware issues in general) have been
always real hassle to debug and workaround/fix.

Sharing low-level code base with smartmontools will be great as it is not
Linux-only thing (which in this case helps a lot with additional testing
and verification on other platforms) and actually has a people with a lot
of needed ATA background/experience behind the project.
