From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9837] New: I can't boot with a PLEXTOR PX-740A
Date: Mon, 28 Jan 2008 13:53:41 -0800
Message-ID: <20080128135341.38d03550.akpm@linux-foundation.org>
References: <bug-9837-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53811 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751452AbYA1Vxr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 16:53:47 -0500
In-Reply-To: <bug-9837-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, ubuntu@kagou.fr

On Mon, 28 Jan 2008 09:46:29 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9837
> 
>            Summary: I can't boot with a PLEXTOR PX-740A
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.24-4.7
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: i386
>         AssignedTo: platform_i386@kernel-bugs.osdl.org
>         ReportedBy: ubuntu@kagou.fr
> 
> 
> Kernel : https://edge.launchpad.net/ubuntu/+source/linux/2.6.24-4.7
> Distribution: Hardy Alpha3 http://www.ubuntu.com/testing/hardy/alpha3
> Hardware Environment: i386
> 
> Problem Description:
> Using my PLEXTOR PX-740A or my Matsushita SR-8584-B (instead of) result in
> error during boot process.
> If i use a Traxdata CDD4911/45 the kernel boot.
> 
> Steps to reproduce:
> Please see my Bug report (attachements ...)
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/181561
> 

Seems to be old-IDE related.  There are lots of links to follow ;)

It is unclear whether this is a regression.  Was this bug also present in
all earlier kernel versions?

