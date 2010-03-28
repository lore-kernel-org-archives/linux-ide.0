From: Jeff Garzik <jeff@garzik.org>
Subject: [RFT] ahci rebase in libata #upstream
Date: Sun, 28 Mar 2010 00:46:35 -0400
Message-ID: <4BAEDF2B.3020808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:48493 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0C1Eqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2010 00:46:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, harry.zhang@amd.com, Shane Huang <Shane.Huang@amd.com>, turmlos@comcast.net, Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>


The 'upstream' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

was just rebased.  This is the branch normally exported to linux-next, 
and is intended for merging into 2.6.35, when the merge window for 
2.6.35 opens.

This rebase merges in ahci changes from torvalds/linux-2.6.git into the 
major AHCI driver reorganization authored by Anton Vorontsov, which 
creates a new kernel module libahci.

Please test and make sure your ahci driver continues working as expected!

People who have authored patches for ahci, and have not received an 
"applied" email acknowledgment need to rebase and resend their changes 
on top of the new 'upstream' branch of libata-dev.git.

	Jeff




