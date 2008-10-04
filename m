From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sat, 04 Oct 2008 16:02:44 +0900
Message-ID: <48E71514.90505@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <200810031703.32114.rjw@sisk.pl> <200810032348.59709.rjw@sisk.pl> <200810032351.46869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:26695 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbYJDHEM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 03:04:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so902773tic.23
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2008 00:04:10 -0700 (PDT)
In-Reply-To: <200810032351.46869.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Hibernation: Introduce system_entering_hibernation
> 
> Introduce boolean function system_entering_hibernation() returning
> 'true' during the last phase of hibernation, in which devices are
> being put into low power states and the sleep state (for example,
> ACPI S4) is finally entered.
> 
> Some device drivers need such a function to check if the system is
> in the final phase of hibernation.  In particular, some SATA drivers
> are going to use it for blacklisting systems in which the disks
> should not be spun down during the last phase of hibernation (the
> BIOS will do that anyway).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

applied 1-6 to tj-upstream

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git tj-upstream
  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=tj-upstream

Thanks.

-- 
tejun
