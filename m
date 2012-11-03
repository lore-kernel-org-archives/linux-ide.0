From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sat,  3 Nov 2012 16:43:15 +0000 (UTC)
Message-ID: <20121103164315.6894911FB85@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756713Ab2KCQnS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2012 12:43:18 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 08B7320208
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 16:43:17 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id EDBE020229
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 16:43:15 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #36 from Alan <alan@lxorguk.ukuu.org.uk>  2012-11-03 16:43:14 ---
On Sat, 3 Nov 2012 05:26:35 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
> > Which is an ATA layer bug - adev->dma_mode should never be called
> > without a DMA mode in normal use.
> 
> Ok, it looks like this would take a while to fix.

So a 30 second glance says that the problem is that you seem to have
dma_mode uninitialised as zero which is bogus.

That means either ata_acpi_gtm_xfermask broke (it should have set the
bits to 0xFF if no mode is found), ata_dma_enabled is broken, or
pacpi_qc_issue got called before pacpi_port_start (which seems wildly
unlikely)

Needs someone to go and dump the relevant values in the right places and
see what is breaking in the pata_acpi setup logic.

Alan

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
