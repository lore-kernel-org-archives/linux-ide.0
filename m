From: David Wuertele <dave-gnus@bfnet.com>
Subject: Compact Flash PIO 4 tuning
Date: Mon, 05 May 2003 17:53:35 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3llxkyjxs.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:41943 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262235AbTEFAlH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2003 20:41:07 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 19Cqgp-0005iI-00
	for <linux-ide@vger.kernel.org>; Tue, 06 May 2003 02:52:15 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Howdy,

I'm working on an embedded system that has a CF card on the IDE bus.
The CF spec only allows PIO mode, and my card can do PIO 4.  However,
when I try to stream data from this card into memory at 2 MBytes per
second, it pegs the CPU at 100%.  This is ruining the performance of
my application, which has to process this data in real time.

I realize that PIO 4 requires CPU involvement, but are there ways I
can tune the kernel for copying large files to memory, so that my
application doesn't get starved of CPU?

Thanks,
Dave

