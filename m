From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14044] WARNING: at kernel/irq/manage.c:259
Date: Mon, 31 Aug 2009 06:46:58 GMT
Message-ID: <200908310646.n7V6kwSE019644@demeter.kernel.org>
References: <bug-14044-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56255 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbZHaGq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Aug 2009 02:46:56 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n7V6kwMO019645
	for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2009 06:46:58 GMT
In-Reply-To: <bug-14044-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14044


Zhang Rui <rui.zhang@intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rui.zhang@intel.com
          Component|BIOS                        |IDE
         AssignedTo|acpi_bios@kernel-bugs.osdl. |io_ide@kernel-bugs.osdl.org
                   |org                         |
            Product|ACPI                        |IO/Storage




--- Comment #3 from Zhang Rui <rui.zhang@intel.com>  2009-08-31 06:46:56 ---
will you please try the libata driver instead and see if the problem still
exists?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
