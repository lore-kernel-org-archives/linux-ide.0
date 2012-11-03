From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sat,  3 Nov 2012 16:25:43 +0000 (UTC)
Message-ID: <20121103162543.8C91F11FB85@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59494 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141Ab2KCQZs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2012 12:25:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6B93F20215
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 16:25:47 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 778F120209
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 16:25:45 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #35 from Alan <alan@lxorguk.ukuu.org.uk>  2012-11-03 16:25:43 ---
On Sat, 3 Nov 2012 05:26:35 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
> > Which is an ATA layer bug - adev->dma_mode should never be called
> > without a DMA mode in normal use.
> 
> Ok, it looks like this would take a while to fix.
> 
> Alan, what is your suggestion for a proper fix, uncomment XFER_PIO_SLOW
> and drop to it with a big warning that ACPI is giving botched

No. The proper fix is to find out how it got called with no DMA mode set.
There is no reason ACPI can't return pure PIO answers. If it does however
then the DMA mode setting call should not be made by the core libata
code. Lots of our ATA driver code relies upon that so if it's actually
what is happening that is what needs fixing.

Alan

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
