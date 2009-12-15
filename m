From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 15 Dec 2009 01:32:37 +0100
Message-ID: <200912150132.37671.bzolnier@gmail.com>
References: <bug-14583-11633@http.bugzilla.kernel.org/> <200912142010.nBEKA0fv005256@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41790 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZLOAeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 19:34:19 -0500
Received: by ewy19 with SMTP id 19so4034555ewy.21
        for <linux-ide@vger.kernel.org>; Mon, 14 Dec 2009 16:34:17 -0800 (PST)
In-Reply-To: <200912142010.nBEKA0fv005256@demeter.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org, mzjro@0pointer.net

On Monday 14 December 2009 09:10:00 pm bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14583
> 
> 
> David Zeuthen <zeuthen@gmail.com> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |zeuthen@gmail.com
> 
> 
> 
> 
> --- Comment #34 from David Zeuthen <zeuthen@gmail.com>  2009-12-14 20:09:58 ---
> (In reply to comment #33)
> > I've been tracking a bug we've linked to this on Ubuntu, the most recent
> > replies received from affected users do indicate that it's the
> > devkit-disks-probe-ata-smart command that triggers the HSM Violations and death
> > of their SSD.
> 
> This program is a user of libatasmart. You want to look at
> 
>  http://git.0pointer.de/?p=libatasmart.git;a=summary

Slightly off-topic but WTF is this?  NIH smartmontools implementation?

Oh, I see.. 

	http://0pointer.de/blog/projects/being-smart.html

Why, oh, why...  smartmontools were working just fine and could have
been _easily_ been ported to C from C++ or enhanced into libsmartmon..

"Please note that I certainly don't plan to replace smartmontools.
 libatasmart will always implement only a subset of S.M.A.R.T. If you
 want the full set of functionality then please refer to smartmontools."

I somehow find it suspicious given how (only some) USB/ATA bridges
support were added later to *libata*smart project...

To make things worse Ubuntu is actually shipping it.  What a mess...

First my audio, now my disks.. :(
--
Bartlomiej Zolnierkiewicz
