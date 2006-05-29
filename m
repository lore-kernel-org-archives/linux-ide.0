From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] HPT3xx: switch to using pci_get_slot()
Date: Mon, 29 May 2006 18:26:50 +0400
Message-ID: <447B04AA.5050804@ru.mvista.com>
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478E104.7040200@ru.mvista.com> <4479AAB8.9010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:5076 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750904AbWE2O1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 10:27:52 -0400
In-Reply-To: <4479AAB8.9010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Jiri Slaby wrote:

>>   Switch to using pci_get_slot() to get to the function 1 of HPT36x/374
>>chips -- there's no need for the driver itself to walk the list of the
>>PCI devices, and it also forgets to check the bus number of the device
>>found.

> It's better, but you missed to call pci_dev_put() in some __exit function.

    If you knew the PCI IDE drivers better, you'd know there's simply no 
__exit functions in them. ;-)

WBR, Sergei
