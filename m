From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] ahci: fix boot/resume COMRESET failures
Date: Mon, 20 Feb 2012 15:36:57 -0500
Message-ID: <4F42AEE9.5070800@pobox.com>
References: <1329768563-13715-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47832 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab2BTUhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2012 15:37:00 -0500
In-Reply-To: <1329768563-13715-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Lin Ming <ming.m.lin@intel.com>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Rafael J . Wysocki" <rjw@sisk.pl>

On 02/20/2012 03:09 PM, Brian Norris wrote:
> This series addresses regression problems with
>
>      commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>      ahci: start engine only during soft/hard resets
>
> Because the fix provided by the above commit caused COMRESET failures and
> 10 second boot-time/resume-time hangs for certain DVD drives, we need to
> make the fix conditional to certain devices/platforms. Add a flag for this.
>
> Brian
>
> Brian Norris (3):
>    ahci: add AHCI_HFLAG_STRICT_SPEC host flag
>    ahci: move AHCI_HFLAGS() macro to ahci.h
>    ahci_platform: add STRICT_AHCI platform type

Patch series looks good to me.  I'll throw it into the repo today 
(unless any objections arise).

	Jeff




