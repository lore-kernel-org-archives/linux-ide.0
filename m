From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10379] New: when unloading ahci driver on ATI
 SB700 controller and Western digital cavier 160 GB Hard drive cache is not
 flushed to the media
Date: Tue, 1 Apr 2008 23:04:21 -0700
Message-ID: <20080401230421.04a4592e.akpm@linux-foundation.org>
References: <bug-10379-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56919 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000AbYDBGE3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 02:04:29 -0400
In-Reply-To: <bug-10379-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, syed.azam@hp.com

On Tue,  1 Apr 2008 22:41:06 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10379
> 
>            Summary: when unloading ahci driver on ATI SB700 controller and
>                     Western digital cavier 160 GB Hard drive cache is not
>                     flushed to the media
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.23.11
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: drivers_other@kernel-bugs.osdl.org
>         ReportedBy: syed.azam@hp.com
> 
> 
> Latest working kernel version:unknown
> Earliest failing kernel version:2.6.23.11
> Distribution:vanilla kernel
> Hardware Environment: ATI SB700 and Western digital 160 GB HD in legacy ide
> mode using ahci/atiixp
> Software Environment: AHCI
> Problem Description:
> rmmod ahci (no syncronization of sda)
> modprobe ahci (drive is reset)
> 
> the painful soloution is to rmmod and modprobe ahci driver
> 
> The need to remove the ahci module is there because some small data writes are
> not flushed to the media even after sync command is issued. if Reboot is issued
> it works but if you lose power or suddenly switch off using power button the
> writes which allegdley already returned success are not yet commited to media.
> 
> MS Windows does not have this issue.
> 
> HD experts told me that comreset is needed.
> 
> 
> 
> 
> 
> 
> Steps to reproduce:
> 

