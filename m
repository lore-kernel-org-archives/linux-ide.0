From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10091] New: GGW-H10N SATA DVD drive write
 errors using AHCI driver with nForce 630a chipset
Date: Sun, 24 Feb 2008 23:14:40 -0800
Message-ID: <20080224231440.99f6faa0.akpm@linux-foundation.org>
References: <bug-10091-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:40739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102AbYBYHPN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 02:15:13 -0500
In-Reply-To: <bug-10091-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, luke@lukeross.name

On Sun, 24 Feb 2008 15:23:24 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10091
> 
>            Summary: GGW-H10N SATA DVD drive write errors using AHCI driver
>                     with nForce 630a chipset
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.24.2
>           Platform: All
>         OS/Version: Linux
>               Tree: Fedora
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: luke@lukeross.name
> 
> 
> Latest working kernel version:
> Earliest failing kernel version:
> Distribution:
> Hardware Environment:
> Software Environment:
> Problem Description:
> 
> Steps to reproduce:
> 

There's more info in bugzilla.  afaict it isn't a regression - it's never worked.
