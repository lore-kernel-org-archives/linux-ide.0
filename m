From: Ben Dooks <ben@fluff.org>
Subject: Update on HAVE_PATA_PLATFORM patches
Date: Tue, 6 May 2008 21:53:00 +0100
Message-ID: <20080506205300.GD14157@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:37144 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbYEFVgr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 17:36:47 -0400
Received: from ben by trinity.fluff.org with local (Exim 4.50)
	id 1JtU9k-0006Vt-Dl
	for linux-ide@vger.kernel.org; Tue, 06 May 2008 21:53:00 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I posted a series of patches a while ago[1,2] to change
the platform-pata driver's Kconfig entry enabling. These
patches seem to have been passed by for 2.6.25, and I
would like to get a definitive answer on whether these
can be entered for 2.6.26?

Is the best thing to do to CC: at least one of the maintainers
such as jgarzik to ensure that these aren't missed?


[1] http://marc.info/?l=linux-ide&m=120827342431100&w=2
[2] http://marc.info/?l=linux-arm-kernel&m=120827342431096&w=2

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

