From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ahci: Fix build breakage
Date: Wed, 28 Jan 2009 00:09:06 -0600
Message-ID: <D3B8B6AC-F608-4D80-A4B9-0E83CF8F2134@kernel.crashing.org>
References: <1233118922-15350-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43347 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbZA1GnA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jan 2009 01:43:00 -0500
In-Reply-To: <1233118922-15350-1-git-send-email-galak@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: jeff@garzik.org, Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rjw@sisk.pl


On Jan 27, 2009, at 11:02 PM, Kumar Gala wrote:

> The following commit introduces:
>
> commit 1fd684346d41f6be2487c161f60d03a7feb68911
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Mon Jan 19 20:57:36 2009 +0100
>
>    SATA AHCI: Blacklist system that spins off disks during ACPI  
> power off
>
> the following errors on non-x86 systems:
>
> drivers/ata/ahci.c: In function 'ahci_broken_system_poweroff':
> drivers/ata/ahci.c:2566: error: implicit declaration of function  
> 'dmi_first_match'
> drivers/ata/ahci.c:2566: warning: initialization makes pointer from  
> integer without a cast
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> drivers/ata/ahci.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)


it was pointed out that fixing include/linux/dmi.h was the better way  
to fix this.  I've posted a patch for fixing dmi.h that supersedes  
this patch.

- k
