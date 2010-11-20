From: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Subject: ide boot failure 2.6.36/2.6.28 - 2.6.27 works
Date: Sat, 20 Nov 2010 03:15:19 +0100
Message-ID: <20101120021515.GA3277@iq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.cwi.nl ([192.16.191.8]:50749 "EHLO hera.cwi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404Ab0KTCi7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Nov 2010 21:38:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

In case anybody is still interested in this old IDE stuff:
I wanted to boot a recent kernel on an old machine and failed.
The last kernel that worked was 2.6.27.
What goes wrong is that the disks are no longer detected on 2.6.28.
I see that 2.6.28 had a lot of changes in this area.
Maybe this just needs a new boot option I overlooked.
(Or is oldfashioned IDE considered broken these days?)

Google gives me many people with the same problem
(e.g., http://bugs.gentoo.org/253628) but no remedy.
I have not looked at the code yet.

Andries
