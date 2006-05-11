From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] PIIX: config_drive_for_dma() cleanup
Date: Fri, 12 May 2006 00:34:43 +0400
Message-ID: <44639FE3.9050608@ru.mvista.com>
References: <44638A4F.2090502@ru.mvista.com> <1147379342.26130.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:36047 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750775AbWEKUfm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 16:35:42 -0400
In-Reply-To: <1147379342.26130.84.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, liknux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> On Iau, 2006-05-11 at 23:02 +0400, Sergei Shtylyov wrote:

>>@@ -73,8 +74,6 @@
>>  *	PIIX4	errata #15	- Must not read control registers
>>  * 				  during a PIO transfer
>>  *	440MX   errata #13	- As PIIX4 errata #15
>>- *	ICH2	errata #21	- DMA mode 0 doesn't work right
>>- *	ICH0/1  errata #55	- As ICH2 errata #21

> NAK. The errata are documented carefully so that people know what the
> problems are. They have not gone away.

    OK. The patch was bad for another reason -- PIO fallback won't work since 
piix_tune_drive() currently "forgets" to set the drive's own transfer mode. 
The same goes to SLC90E66 patch. I'll resend...

MBR, Sergei
