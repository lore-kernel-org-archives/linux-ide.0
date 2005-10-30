From: David Ronis <ronis@montroll.chem.mcgill.ca>
Subject: Serious IDE problem still present in 2.6.14
Date: Sat, 29 Oct 2005 20:48:30 -0400
Message-ID: <1130633310.6225.11.camel@montroll.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from drizzle.CC.McGill.CA ([132.206.27.48]:21738 "EHLO
	drizzle.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S932697AbVJ3AtE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Oct 2005 20:49:04 -0400
Received: from mailscan1.cc.mcgill.ca (mailscan1.CC.McGill.CA [132.216.77.248])
	by drizzle.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id j9U0muUD002227
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 20:48:57 -0400
Received: from montroll.chem.mcgill.ca (montroll.Chem.McGill.CA [132.206.205.86])
	by mailscan1.cc.mcgill.ca (8.13.0/8.13.0) with ESMTP id j9U0mVme004033
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 20:48:34 -0400 (EDT)
Received: from localhost (IDENT:11@localhost [127.0.0.1])
	by montroll.chem.mcgill.ca (8.13.5/8.13.5) with ESMTP id j9U0mUeJ006586
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 20:48:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The problem I reported on the linux-kernel list and later here.  See

   http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2

with disk access on my HP pavilion is still present.  In short,
something broke in the 2.6.13 series, and it still is broken in 2.6.14.
One thing I hadn't added explicitly to my earlier report, is that this
laptop has a P4 Hyperthreaded chip (someone mentioned that there was an
ACPI problem related to hyperthreading).

David


