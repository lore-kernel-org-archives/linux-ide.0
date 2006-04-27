From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC: 2.6 patch] drivers/ide/: possible cleanups
Date: Fri, 28 Apr 2006 01:03:33 +0400
Message-ID: <445131A5.5000206@ru.mvista.com>
References: <20060427203344.GO3570@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:56808 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751667AbWD0VEq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Apr 2006 17:04:46 -0400
In-Reply-To: <20060427203344.GO3570@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Adrian Bunk wrote:

> - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)

    I'm not sure it's unused seeing the modular driver that call it in 
drivers/ide/arm/, for example (I also know of an unaccepted modular MIPS driver).

MBR, Sergei
