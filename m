From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] Hibernation: Introduce new system state for the
 last phase of hibernation
Date: Fri, 3 Oct 2008 01:35:57 -0700
Message-ID: <20081003013557.42ce685d.akpm@linux-foundation.org>
References: <200808290002.55026.rjw@sisk.pl>
	<48D17BBE.5020807@garzik.org>
	<200809300006.24919.rjw@sisk.pl>
	<200809300010.39000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36620 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477AbYJCIgP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Oct 2008 04:36:15 -0400
In-Reply-To: <200809300010.39000.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

On Tue, 30 Sep 2008 00:10:37 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hibernation: Introduce new system state for the last phase of hibernation
> 
> Replace unused SYSTEM_SUSPEND_DISK with a new system_state value
> SYSTEM_HIBERNATE_ENTER that can be used by device drivers to check if
> the system is in the last phase of hibernation.

Violent objections.

We just don't know what this change will do.  It potentially affects
every code site in the kernel which looks at system_state.  We've had
problems in the past with this thing and the more complex we make it,
the worse any future problems will be.  It's Just Bad.

Can we just create a new global?

	extern bool system_entering_hibernation_or_whatever;

?

It'll add four bytes of bss, it'll save *more* than four bytes of
text and it is plainly obviously non-injurious to present and future
code.

hmm?
