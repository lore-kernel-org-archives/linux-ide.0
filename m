From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Wed, 20 Jan 2010 14:33:24 -0500
Message-ID: <4B575A84.3030005@garzik.org>
References: <4B550EF8.1000009@kernel.org> <4B550F9F.80503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:57265 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0ATTd1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 14:33:27 -0500
Received: by gxk9 with SMTP id 9so6490337gxk.8
        for <linux-ide@vger.kernel.org>; Wed, 20 Jan 2010 11:33:26 -0800 (PST)
In-Reply-To: <4B550F9F.80503@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 01/18/2010 08:49 PM, Tejun Heo wrote:
> Traditional IDE interface sucks in that it doesn't have a reliable IRQ
> pending bit, so if the controller raises IRQ while the driver is
> expecting it not to, the IRQ won't be cleared and eventually the IRQ
> line will be killed by interrupt subsystem.  Some controllers have
> non-standard mechanism to indicate IRQ pending so that this condition
> can be detected and worked around.
>
> This patch adds an optional operation ->sff_irq_check() which will be
> called for each port from the ata_sff_interrupt() if an unexpected
> interrupt is received.  If the operation returns %true,
> ->sff_check_status() and ->sff_irq_clear() will be cleared for the
> port.  Note that this doesn't mark the interrupt as handled so it
> won't prevent IRQ subsystem from killing the IRQ if this mechanism
> fails to clear the spurious IRQ.
>
> This patch also implements ->sff_irq_check() for ata_piix.  Note that
> this adds slight overhead to shared IRQ operation as IRQs which are
> destined for other controllers will trigger extra register accesses to
> check whether IDE interrupt is pending but this solves rare screaming
> IRQ cases and for some curious reason also helps weird BIOS related
> glitch on Samsung n130 as reported in bko#14314.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=14314
>
> * piix_base_ops dropped as suggested by Sergei.
>
> * Spurious IRQ detection doesn't kick in anymore if polling qc is in
>    progress.  This provides less protection but some controllers have
>    possible data corruption issues if the wrong register is accessed
>    while a command is in progress.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Johannes Stezenbach<js@sig21.net>
> Reported-by: Hans Werner<hwerner4@gmx.de>
> Cc: Alan Cox<alan@lxorguk.ukuu.org.uk>
> Cc: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> ---
> Jeff, these two are for #upstream but generated on top of
> #upstream-fixes because the piix sata 32bit bmdma patch is currently
> only in #upstream-fixes.  Please pull -fixes into #upstream before
> applying these two.  Thanks.
>
>   drivers/ata/ata_piix.c   |   20 +++++++++++++++-----
>   drivers/ata/libata-sff.c |   35 ++++++++++++++++++++++++++++++++---
>   include/linux/libata.h   |    1 +
>   3 files changed, 48 insertions(+), 8 deletions(-)

applied, with comment:

Overall, as long as the drive is in Bus-Idle mode, it should be safe to 
go ahead and read Status, for pretty much every controller and drive.

I would make exception only for the new SATA FIS-based controllers, 
where we know that hitting Status is likely both pointless and wasteful, 
as well as being superfluous because the newer FIS-based controllers all 
have irq status registers.

Additionally, I think we should have a "fast-timeout" and 
"slow-timeout", whereby we check Status after a short period (5 
seconds?) to make sure we did not lose an interrupt.  If Status is !BSY, 
then we can proceed with handling qc success/failure immediately.

	Jeff



