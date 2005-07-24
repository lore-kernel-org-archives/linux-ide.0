From: Simon Raffeiner <sturmflut@lieberbiber.de>
Subject: Support for the PATA port in sata_promise
Date: Sun, 24 Jul 2005 10:29:48 +0200
Message-ID: <1122193788.42e3517c7f059@www.hosting-agency.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hosting-agency.de ([194.145.226.10]:23247 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S261936AbVGXI3x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jul 2005 04:29:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I've got an Asus A8V Deluxe Mainboard with an onboard Promise SATA 378
(PDC20378) controller. Because four PATA ports are never enough one of my hard
disks is connected to the PATA port of the Promise chip. I use Ubuntu Linux
5.04 (Hoary) and after upgrading to kernel 2.6.11 the port stopped working. It
seems that Ubuntu kernel 2.6.10 contains a version of the sata_promise driver
that features PATA support, but later that patch was dropped and also vanilla
kernels up to 2.6.12.3 don't feature it.

Some other distributions seem to include a PATA-enabled version, but when will
support for the PATA port be included in vanilla kernels? The version Ubuntu
kernel 2.6.10 uses works fine. Unfortunately it is not compatible with newer
vanilla kernels.

Regards,

Simon Raffeiner
