From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] ahci: implement ata_save/restore_initial_config()
Date: Tue, 17 Apr 2007 10:35:23 -0400
Message-ID: <4624DB2B.3030003@garzik.org>
References: <20070318131533.GC6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39546 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbXDQOf0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:35:26 -0400
In-Reply-To: <20070318131533.GC6152@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> There are several registers which describe how the controller is
> configured.  These registers are sometimes implemented as r/w
> registers which are configured by firmware and get cleared on
> controller reset or after suspend/resume cycle.  ahci saved and
> restored those values inside ahci_reset_controller() which is a bit
> messy and doesn't work over suspend/resume cycle.
> 
> This patch implements ahci_save/restore_initial_config().  The save
> function is called during driver initialization and saves cap and
> port_map to hpriv.  The restore function is called after the
> controller is reset to restore the initial values.
> 
> Sometimes the initial firmware values are inconsistent and need to be
> fixed up.  This is handled by ahci_save_initial_config().  For this,
> there are two versions of saved registers.  One to write back to the
> hardware register, the other to use during driver operation.  This is
> necessary to keep ahci's behavior unchanged (write back fixed up
> port_map while keeping cap as-is).
> 
> This patch makes ahci save the register values once before the first
> controller reset, not after it's been reset.  Also, the same stored
> values are used written back after each reset, so the register values
> are properly recovered after suspend/resume cycle.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this is the save/restore separation patch as suggested.

applied 1-2


