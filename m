From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8936] New: sata_promise 2.09 fails to identify
 ST3400832AS
Date: Fri, 24 Aug 2007 22:21:47 -0700
Message-ID: <20070824222147.230263de.akpm@linux-foundation.org>
References: <bug-8936-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58295 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755571AbXHYFWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Aug 2007 01:22:40 -0400
In-Reply-To: <bug-8936-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sziemba@ecn.purdue.edu, linux-ide@vger.kernel.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>
Cc: bugme-daemon@bugzilla.kernel.org

On Fri, 24 Aug 2007 21:14:49 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8936
> 
>            Summary: sata_promise 2.09 fails to identify ST3400832AS
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.23-rc1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: sziemba@ecn.purdue.edu
> 
> 
> Most recent kernel where this bug did not occur: 2.6.22 
> 
> Using git bisect I have identified the first bad commit.
> 
> linux-2.6# git bisect good
> a77720ad0a4049e4bc6355e4febf899966a48222 is first bad commit
> commit a77720ad0a4049e4bc6355e4febf899966a48222
> Author: Mikael Pettersson <mikpe@it.uu.se>
> Date:   Tue Jul 3 01:09:05 2007 +0200
> 
> Distribution: Debian etch (stable)
> 
> Hardware Environment: Sun Fire x4100
> (http://www.crocom.com.pl/ulotki/X4100.pdf)
> 8 ST3400832AS drives connected to Promise FastTrak TX4200
> 2 ST973401LSUN72G drives connected to on board Fusion SAS
> 
> Software Environment:
> Problem Description:  
> 
> I will attach dmesg output, hdparm and lspci.  I have tried acpi=noirq, noapic,
>  irqpoll and pci=routeirq.  The drives connected to promise controller fail to
> identify.  The dmesg for rc-3 with sata_promise 2.09 is truncated as the kernel
> loops indefinitely.  Replacing sata_promise.c with version 2.08 from previous
> kernels allows 2.6.23-rc3 to boot (with some warnings during compile/boot).
> 
> Steps to reproduce:  Boot the machine with the promise card connected.
> 

Thanks for doing the bisection - it really helps.

Michal, one for the regression file, please.

Mikael: tsk ;)
