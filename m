From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/8] Hibernation: Introduce system_entering_hibernation
Date: Tue, 04 Nov 2008 01:14:04 -0500
Message-ID: <490FE82C.2010206@garzik.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org> <1225706469-27870-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45595 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbYKDGOI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:14:08 -0500
In-Reply-To: <1225706469-27870-2-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Tejun Heo wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
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
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/suspend.h |    2 ++
>  kernel/power/disk.c     |   10 ++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)

applied 1-6


