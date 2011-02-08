From: Phillip Susi <psusi@cfl.rr.com>
Subject: libata: implement on-demand HPA unlocking
Date: Tue, 08 Feb 2011 15:23:36 -0500
Message-ID: <4D51A648.20707@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:53739 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab1BHUWH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 15:22:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Commit d8d9129ea28e2177749627c82962feb26e8d11e9 appears to be an attempt
to fix long standing problems with the Host Protected Area defaulting to
locked/unlocked and the problems that each guess has when it is wrong.

It still causes problems with fakeraid striped arrays however, because
it detects the partition table on the primary disk, sees partitions
beyond the end, and chooses to unlock the HPA to attempt to access those
partitions.  This breaks the fakeraid array since the raid metadata left
by the bios uses the HPA geometry, which becomes incorrect when the HPA
is unlocked.

I propose a slight refinement of the method introduced in this patch.
Rather than unlock the HPA if a partition goes beyond the end of the
current disk, it should check to make sure that doing so will actually
make that partition fully accessible, and don't bother unlocking if it
won't.

Thoughts?
