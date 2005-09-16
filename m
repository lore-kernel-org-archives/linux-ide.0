From: Jeff Garzik <jgarzik@pobox.com>
Subject: PIO interrupt handling
Date: Thu, 15 Sep 2005 22:54:54 -0400
Message-ID: <432A33FE.4090703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28123 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030547AbVIPCzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Sep 2005 22:55:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Albert Lee <albertcc@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>


Just wanted to point out positive feedback for Albert's patch:
http://lkml.org/lkml/2005/9/15/358

The reason I mentioned Albert's patch in my reply, in that thread, is 
that sometimes SATA controllers may not emulate nIEN properly, or may 
depend on the device to set (or not) the 'I' bit in the SATA FIS.

This success is an example of why I want to move libata to use 
interrupt-driven PIO by default, long term.

We still want to keep the polling code, and perhaps even expand things a 
bit so that users with broken interrupt routing (read: no interrupt 
delivery for ATA controller) can still use their disks.

	Jeff



