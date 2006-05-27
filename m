From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] HPT3xx: switch to using pci_find_slot()
Date: Sun, 28 May 2006 03:01:10 +0400
Message-ID: <4478DA36.90408@ru.mvista.com>
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478D889.506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:34794 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S965002AbWE0XCG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 May 2006 19:02:06 -0400
In-Reply-To: <4478D889.506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Jiri Slaby wrote:
> Sergei Shtylyov napsal(a):

>>   Switch to using pci_find_slot() to get to the function 1 of HPT36x/374

> Better to use pci_get_slot()+pci_dev_put(), i. e. refcounting.

    Indeed. I'll recast.

WBR, Sergei
