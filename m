From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Fri, 16 Nov 2012 04:50:43 +0000 (UTC)
Message-ID: <20121116045043.BA9A711FEDC@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33229 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab2KPEur (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2012 23:50:47 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9F7BB2020A
	for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2012 04:50:45 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id AA36D20232
	for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2012 04:50:44 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #39 from Jeff Garzik <jgarzik@pobox.com>  2012-11-16 04:50:43 ---
On 11/03/2012 12:48 PM, Alan Cox wrote:
> On Sat, 3 Nov 2012 05:26:35 +0100
> Borislav Petkov <bp@alien8.de> wrote:
>
>> On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
>>> Which is an ATA layer bug - adev->dma_mode should never be called
>>> without a DMA mode in normal use.
>>
>> Ok, it looks like this would take a while to fix.
>
> So a 30 second glance says that the problem is that you seem to have
> dma_mode uninitialised as zero which is bogus.
>
> That means either ata_acpi_gtm_xfermask broke (it should have set the
> bits to 0xFF if no mode is found), ata_dma_enabled is broken, or
> pacpi_qc_issue got called before pacpi_port_start (which seems wildly
> unlikely)
>
> Needs someone to go and dump the relevant values in the right places and
> see what is breaking in the pata_acpi setup logic.

Agreed -- though the WARN_ONCE() will at least give us trivially better 
poops.

    Jeff

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
