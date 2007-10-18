From: Soeren Sonnenburg <kernel@nn7.de>
Subject: seagate disks on sil3114 - slow?
Date: Thu, 18 Oct 2007 06:54:50 +0200
Message-ID: <1192683290.5720.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:35185 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbXJRFBg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 01:01:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear all,

I just now realize that all disk i.o. on my machine is quite slow
compared with the pata disks I had before. Furthermore I recognized that
I only have seagates (ST3400832AS,ST3400620AS,ST3750640AS,ST3750640AS)
connected to a sil3114 controller.

Being on kernel 2.6.23.1 and stumbling across
http://home-tj.org/wiki/index.php/Sil_m15w I am now wondering if this
patch made it already in kernel (or when it will make it if it is not
yet in/why never).

Best,
Soeren
