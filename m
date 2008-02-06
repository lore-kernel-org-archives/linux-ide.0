From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9898] New: libata fails for ALi Corporation
 M5229 IDE
Date: Wed, 6 Feb 2008 03:31:37 -0800
Message-ID: <20080206033137.82f85fd1.akpm@linux-foundation.org>
References: <bug-9898-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43606 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754393AbYBFLb6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 06:31:58 -0500
In-Reply-To: <bug-9898-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hathe@sidux.com
Cc: bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

On Wed,  6 Feb 2008 03:09:36 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9898
> 
>            Summary: libata fails for ALi Corporation M5229 IDE
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.24
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IDE
>         AssignedTo: io_ide@kernel-bugs.osdl.org
>         ReportedBy: hathe@sidux.com
> 
> 
> Latest working kernel version: 2.6.23.14 (with blkdev)
> Earliest failing kernel version: 2.6.24 (with libata)
> Distribution: sidux
> Hardware Environment: Acer Travelmate 632XV 
> Software Environment:
> Problem Description: System boots fine, but after some minutes complete system
> freeze. Nothing is mentioned in the logfiles. 
> 
> System informations:
> lspci -nn | grep IDE
> 00:10.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c4)
> 
> Steps to reproduce: reboot and wait some minutes (<10)
> 

A regression.

What makes you think it's due to IDE?
