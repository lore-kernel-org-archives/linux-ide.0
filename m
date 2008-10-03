From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sat, 4 Oct 2008 00:27:24 +0100
Message-ID: <20081004002724.47fab174@lxorguk.ukuu.org.uk>
References: <200808290002.55026.rjw@sisk.pl>
	<200810031703.32114.rjw@sisk.pl>
	<200810032348.59709.rjw@sisk.pl>
	<200810032351.46869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45280 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753878AbYJCX2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Oct 2008 19:28:14 -0400
In-Reply-To: <200810032351.46869.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

> in the final phase of hibernation.  In particular, some SATA drivers
> are going to use it for blacklisting systems in which the disks
> should not be spun down during the last phase of hibernation (the
> BIOS will do that anyway).

If you added the PCI ids for the controller to your tables you could
implement this series once instead of in multiple drivers

