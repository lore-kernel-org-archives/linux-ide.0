From: the4hoffmans@earthlink.net
Subject: Issue with AHCI driver
Date: Thu, 10 Jul 2008 10:17:05 -0500 (GMT-05:00)
Message-ID: <29493114.1215703025597.JavaMail.root@elwamui-lapwing.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:53752 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171AbYGJPRL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jul 2008 11:17:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, blward@micron.com

Sorry about the multiple e-mails Jeff, but our IT group has seen fit to deny me the ability to send e-mail to vger.kernel.org so I'm trying again from my own personal account.
-------------------------------------------------------------------


My name is Bob Hoffman.  I am a software engineer for Micron Technology in Minneapolis.  I have been working on AHCI drivers.  We recently installed kernel build 2.6.19.0 (unpatched) of Linux on an Intel motherboard system which includes the ICH9 SATA controller.  We have been running some benchmarks and found that the SATA harddrives looked slow.  When I attached a SATA analyzer it shows that we are only getting one command "in flight" or "outstanding" at a time, and it is always slot (or tag) zero.  The AHCI driver doesn't seem to be taking advantage of the 32 deep queue.

I checked the queue depth using the info at http://linux-ata.org/faq.html#io32 and it shows "NCQ (depth 31/32)".  I'm wondering if there is something else I need to know.

I've copied our "Linux guru", Bob Ward, who knows more about the kernel stuff than I do.

Thank you for any help you can provide.
Bob (Hoffman) ; )
