From: amruth pattanada <amruth.vamadev@gmail.com>
Subject: Setting up Silicon image 3114 in DMA mode
Date: Fri, 25 Jun 2010 13:55:32 +0530
Message-ID: <AANLkTinYuxwsLQKGRd6joRSCcbnns930DDienlhfEB8i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57687 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0FYIZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 04:25:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi
Can anybody please guide me what minimal steps to follow for setting
up 3114 for operating in DMA mode and looked into linux 2.6.32.7 code.
I am porting 3114 driver to RTOS but have problems in using BAR5 PCI
config space because of Memory mapped region issues. I can access BAR4
and plan to set up DMA mode.
How do we access entire BAR5 memory space without using BAR5, is there
any indirect way to access BAR5 using BAR4. Please let me know.
Thanks
Amruth p.v
Sr.Embedded Engineer
