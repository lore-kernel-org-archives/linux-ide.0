From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Wanted: small number of crazy highpoint IDE  (HPT366-372N/374)
	controller owners
Date: Wed, 10 Nov 2004 18:30:36 +0000
Message-ID: <1100111436.20556.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:64209 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262110AbUKJTdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Nov 2004 14:33:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

I've been debugging and chasing down various HPT IDE problems. I've done
some cleanups, fixed the PLL tune and little bits like that. These are
the kind of changes that turn your disk into a random number generator
if they go wrong but OTOH the HPT372N crashes should be fixed.

Now it needs some testers...

Alan

