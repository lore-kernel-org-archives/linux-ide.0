From: Russell <russell.sloan@lingua-data.com>
Subject: How to tap into running libata?
Date: Mon, 02 Apr 2007 13:13:13 -0400
Message-ID: <24238041.53401175533993523.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:58488 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933884AbXDBRSQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Apr 2007 13:18:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi everyone,

I am trying to write a program to talk through the libata driver to control a SATA drive connected to a SiI 3124 PCI card.  Can anyone tell me how to query/probe the driver to find out what it knows about my device?

I know the drive is alive because I can issue the usual shell commands (fdisk, mkfs, mount, cp, ls, etc) to it and they all work.  Device comes up as /dev/sda and dev/sda1 once it's partitioned.  It is the only SATA device in the system, although ultimately there will be more drives connected to the 3124 card.

Thank you in advance!
-Russell Sloan
