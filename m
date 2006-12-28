From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: hda on Via Epia-ML motherboard seen on 2.6.18, but not 2.6.19
Date: Thu, 28 Dec 2006 16:21:22 +0100
Message-ID: <58cb370e0612280721p4f1282c1m5e3d9d7d8f084cd3@mail.gmail.com>
References: <200612280531.kBS5VlrO015115@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:27671 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbWL1PVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Dec 2006 10:21:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so5585277nfa
        for <linux-ide@vger.kernel.org>; Thu, 28 Dec 2006 07:21:22 -0800 (PST)
In-Reply-To: <200612280531.kBS5VlrO015115@freya.yggdrasil.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-ide@vger.kernel.org

On 12/28/06, Adam J. Richter <adam@yggdrasil.com> wrote:
> On Tue, 26 Dec 2006 06:36:45 +0800, Adam Richter wrote:
> >On Fri, 22 Dec 2006 14:56:20 +0100, Bartlomiej Zolnierkiewicz wrote:
> >>On 12/22/06, Adam J. Richter <adam@yggdrasil.com> wrote:
> >>>         I have a 666MHz Via Epia-ML motherboard (using a Via Eden, I
> >>> think).  I am booting it from a CompactFlash card attached by an
> >>> IDE-CF adapter.  Everything works fine under 2.6.18.  Under 2.6.19,
> >>> 2.6.19.1 and 2.6.20-rc1, the master device on ide0 is not seen.
> >[...]
>
> >>>From the quick look the only IDE subsystem change in 2.6.19
> >>which could be responsible (wild guess) for this is the commit:
> >>17c1033d331a430ce631805e15215e63b4cce764
> >>[ patch attached in case you don't have git tree at hand ]
>
> >>Could you check if reverting it fixes the problem?
> >>If not it seems that the best way to proceed is git bisect.
>
> >I'll cc this message to linux-ide in case anyone else encounters the
> >problem and wants to be informed about it.
>
> >As mentioned in my previous off-list email, the reverting attached
> >patch did not fix the problem.
>
> >I now have a few more data points to narrow where the bug was introduced:
>
> >2.6.18.4       ok
> >2.6.18.6       ok
> >2.6.19-rc1     fails
>
> >I expect I will now work on setting up a git tree fed by kernel.org
> >and using git bisect as you suggest.
>
> >Thanks for your advice.  I'll let you know when I have more news.
>
> Before pulling from the official git development tree, I tried the
> linux-2.6.18-git[n] snapshots.  It looks the problem goes back as far
> as 2.6.18-git1.  Here is a list of test results, for completeness.
>
> 2.6.18          ok
> 2.6.18.1        ok
> 2.6.18.4        ok
> 2.6.18.6        ok
> 2.6.18-git1     fails
> 2.6.18-git2     fails
> 2.6.18-git5     fails
> 2.6.18-git10    fails
> 2.6.19-rc1      fails
> 2.6.19          fails
> 2.6.20-rc1      fails
> 2.6.20-rc2      fails

Thanks for testing.

> Now I guess will pull from the official git development tree and try using
> git bisect to narrow the problem further.

Yes, 2.6.18-git1 patch is still near 3MB large, more-over

[bzolnier@trik adam]$ grep drivers/ide patch-2.6.18-git1
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c

so it looks like some non-IDE commit is affecting IDE driver. :?

Bart
