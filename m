From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 1/3] ahci: add AHCI_HFLAG_DELAY_ENGINE host flag
Date: Tue, 13 Mar 2012 16:36:52 -0400
Message-ID: <4F5FAFE4.5090703@pobox.com>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com> <1329849524-23758-2-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46998 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2CMUg4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2012 16:36:56 -0400
In-Reply-To: <1329849524-23758-2-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Rafael J . Wysocki" <rjw@sisk.pl>

On 02/21/2012 01:38 PM, Brian Norris wrote:
> The following commit was intended to fix problems with specific AHCI
> controller(s) that would become bricks if the AHCI specification was not
> followed strictly (that is, if ahci_start_engine() was called while the
> controller was in the wrong state):
>
>      commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>      ahci: start engine only during soft/hard resets
>
> However, some devices currently have issues with that fix, so we must
> implement a flag that delays the ahci_start_engine() call only for specific
> controllers.
>
> This commit simply introduces the flag, without enabling it in any driver.
>
> Note that even when AHCI_HFLAG_DELAY_ENGINE is not enabled, this patch does
> not constitue a full revert to commit 7faa33da; there is still a change in
> behavior to the ahci_port_suspend() failure path.
>
> Signed-off-by: Brian Norris<computersforpeace@gmail.com>

applied 1-3



