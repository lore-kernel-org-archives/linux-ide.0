From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9393] New: SError: { DevExch } occuring and
 causing disruption
Date: Thu, 15 Nov 2007 23:13:37 -0800
Message-ID: <20071115231337.5db592e6.akpm@linux-foundation.org>
References: <bug-9393-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58582 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504AbXKPHOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 02:14:11 -0500
In-Reply-To: <bug-9393-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, avuton@gmail.com


(switched to email - please reply via emailed reply-to-all, not via the
bugzilla web interface)

On Thu, 15 Nov 2007 22:39:41 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9393
> 
>            Summary: SError: { DevExch } occuring and causing disruption
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: v2.6.24-rc2-g6e800af2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: avuton@gmail.com
> 
> 
> Most recent kernel where this bug did not occur: v2.6.23

Rafael, one for the regression list please.

> Distribution: Gentoo
> 
> Since running in the latest kernels I have been getting the following, but not
> often. When it happens the computer grinds to a complete halt. Cursor will move
> a small small amount every 20 seconds or so, making things pretty painful until
> they complete.
> 
> v2.6.24-rc2-g6e800af2 was the first place I saw it, I didn't see it in
> v2.6.24-rc1, but I was only on it briefly due to unrelated issues.
> 
> This hasn't completely been a problem too often, it happens once every day,
> maybe two even, and I would bisect it but this occurs so infrequently I'm sure
> I wouldn't get this bug report out until v2.6.24 :).
> 
> Now that I'm looking over my dmesg I also notice:
> atl1 0000:03:00.0: tx busy
> which could also be the problem
> 
> Any way I can help please let me know.
> 

Yes, that's an ATA problem.

(there is dmesg output and a few other things at the bugzilla URL).
