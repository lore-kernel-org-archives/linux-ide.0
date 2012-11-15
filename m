From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Thu, 15 Nov 2012 18:05:11 +0000 (UTC)
Message-ID: <20121115180511.1123F11FEDB@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44987 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768603Ab2KOSFR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2012 13:05:17 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C09002033F
	for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2012 18:05:15 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C62034B
	for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2012 18:05:14 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #37 from Szymon Janc <szymon@janc.net.pl>  2012-11-15 18:05:10 ---
Hi,

I did some bisecting (10 successful boots == good) and got this:

30dcf76acc695cbd2fa919e294670fe9552e16e7 is the first bad commit
commit 30dcf76acc695cbd2fa919e294670fe9552e16e7
Author: Matthew Garrett <mjg@redhat.com>
Date:   Mon Jun 25 16:13:04 2012 +0800

    libata: migrate ACPI code over to new bindings

    Now that we have the ability to directly glue the ACPI namespace to the
    driver model in libata, we don't need the custom code to handle the same
    thing. Remove it and migrate the functions over to the new code.

    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Holger Macht <holger@homac.de>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>


I've also added some prints:
pacpi_port_start is called before pacpi_qc_issue but ata_do_set_mode is called
after pacpi_qc_issue..  that seems not right, right?

Hope this will help someone familiar with that code..

I'll upload full dmesg as well.

-- 
BR
Szymon Janc

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.