From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Sun, 16 Mar 2008 08:03:59 -0700 (PDT)
Message-ID: <20080316150359.2FAD010806A@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41452 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972AbYCPPEa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Mar 2008 11:04:30 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GF53GE019309
	for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 08:05:04 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239





------- Comment #9 from anonymous@kernel-bugs.osdl.org  2008-03-16 08:03 -------
Reply-To: dani@ngrt.de

On Sun, 16 Mar 2008 07:02:35 -0700 (PDT),
bugme-daemon@bugzilla.kernel.org wrote:

>I've rechecked with the known ATAPI errata but so far I don't see a reason for
>drive getting stuck - I wonder whether it could be controller related.
>
>Could you try using ide_pci_generic driver instead of amd74xx (you need to
>disable CONFIG_BLK_DEV_AMD74XX, enable CONFIG_BLK_DEV_GENERIC and boot kernel
>with "ide_pci_generic.all_generic_ide" option) and see if it helps?

This problem is widespread! I am experiencing it - like other users of
the Knoppix 5.3 live cd that came with a recent issue of the c't
magazine - here on a Nvidia MCP55 and a BenQ DW1655 which is master to
a Plextor PX-708A. Booting off the BenQ fails whereas booting off the
Plextor (slave) works.

Ciao,
  Dani


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
