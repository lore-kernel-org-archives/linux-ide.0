From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [Linux 2.6.27-rc2] suspend to disk, libata problem
Date: Fri, 8 Aug 2008 00:30:59 +0200
Message-ID: <8db1092f0808071530o2f41b1b9p227dbb920e0a3961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:52588 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbYHGWbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 18:31:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so388107ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 07 Aug 2008 15:31:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, jgarzik@pobox.com

I have problem with suspend to disk. On 2.6.26.* works fine.

During s2disk i have this messages (with "no_console_suspend" kernel option):
http://unixy.pl/maciek/download/kernel/2.6.27-rc2/img_0005.jpg
(hibernation fails)

Config, dmesg (normal booting):
http://unixy.pl/maciek/download/kernel/2.6.27-rc2/

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
