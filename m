From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 11:02:33 +0000 (UTC)
Message-ID: <20121023110233.AE08411FB02@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37093 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924Ab2JWLCg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 07:02:36 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E992D20390
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 11:02:34 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id B8BD12037D
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 11:02:33 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #15 from Anton Boyarshinov <boyarsh@altlinux.org>  2012-10-23 11:02:33 ---
> can you try blacklisting pata_acpi and booting the box then (provided
> this is a distro kernel and it has all sata drivers as modules and in
> the initrd - basically what Phillip did).
In this configuration it works (and using pata_amd on second box), but it is
not a good solution for distro kernel. And especially for distro installer
kernel wich should support as more hardware as it possible.

> From the looks of it, yours should be supported by sata_nv so that you
> don't need to use pata_acpi at all.
It seems that more special modules should be loaded before pata_acpi, but it
loads first.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
