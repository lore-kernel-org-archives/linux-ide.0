From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC 3/3] libata: don't perform HW activity in devres
Date: Thu, 25 Oct 2012 10:25:42 -0700
Message-ID: <20121025172542.GG11442@htj.dyndns.org>
References: <1351184161-31433-1-git-send-email-computersforpeace@gmail.com>
 <1351184161-31433-4-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58996 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935953Ab2JYRZq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2012 13:25:46 -0400
Content-Disposition: inline
In-Reply-To: <1351184161-31433-4-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linux Kernel <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>

On Thu, Oct 25, 2012 at 09:56:01AM -0700, Brian Norris wrote:
> devres functions are intended for simplified cleanup of memory and other
> software resources on device exit, not for hardware shutdown sequences.
> In addition, inducing hardware activity at device removal hamstrings
> some drivers (particularly ahci_platform) so that they cannot totally
> power off their hardware before removal, as devres cleanup occurs after
> the driver's exit() sequence.
> 
> More concretely, I experience the following bus error when using rmmod
> to remove (and power off) the SATA block on my SoC:

Shouldn't poweroff happen from ->port/host_stop()?

Thanks.

-- 
tejun
