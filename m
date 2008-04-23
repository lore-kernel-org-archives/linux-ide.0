From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10507] New: Kernel fails to properly identify
 SATA drives
Date: Tue, 22 Apr 2008 20:46:37 -0700
Message-ID: <20080422204637.b45f5074.akpm@linux-foundation.org>
References: <bug-10507-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49231 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756114AbYDWDrP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 23:47:15 -0400
In-Reply-To: <bug-10507-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chiwihouse@aol.com
Cc: bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

> On Tue, 22 Apr 2008 18:38:07 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=10507
> 
>            Summary: Kernel fails to properly identify SATA drives
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: kernels from 2.6.24 to 2.6.25
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: x86-64
>         AssignedTo: platform_x86_64@kernel-bugs.osdl.org
>         ReportedBy: chiwihouse@aol.com
> 
> 
> Latest working kernel version: 2.6.22.9 and 2.6.23.17
> 
> Earliest failing kernel version: 2.6.24
> 
> Distribution: Ubuntu x86_64
> 
> Hardware Environment: Asus M2R32-MVP 580X SB600 (AM2)
>                       AMD X2 4000+
>                       4GB DDR2
>                       SATAII HDD
>                       SATA DVD R/W
> 
> Software Environment: Ubuntu Gutsy w/ distribution kernel (2.6.22-14)
> 
> Problem Description: All 2.6.24 and 2.6.25 kernels fail to boot properly, with
> the following error looping indefinitely:
> 
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> The above correspond to my two SATA physical drives.  All 2.6.22 and 2.6.23
> kernels work perfectly on this same machine.  Was there some type of change
> starting with the 2.6.24 kernels that is rendering my PC inoperable?  
> I have tried looking for similar reports on this, and so far I have only found
> one entry on the mailing list that deals with the same issue.  The problem was
> apparently solved by a BIOS flash to the latest revision, which I'm reluctant
> to do since the newest BIOS from ASUS has several bugs that renders my
> particular system unusable.
> 
> 
> Steps to reproduce:
> Using the 0906 BIOS revision for the M2R32-MVP motherboard and SATA drives.
> 

I expect this regression is due to ata, rater than being caused by changes
to the underlying platform support.

