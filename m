From: Marci <voloterreno@tin.it>
Subject: VT8235 and IDE problems
Date: Thu, 12 Dec 2002 22:31:32 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3DF90034.2040209@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tin.it (62.211.128.168) by smtp4.cp.tin.it (6.5.029) (authenticated as voloterreno@tin.it)
        id 3DE232B40075A470 for linux-ide@vger.kernel.org; Thu, 12 Dec 2002 22:29:42 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I have a MSI KT4 Ultra MoBo with KT400 and VT8235 , before of this I 
had an Apollo PRO 133 and all worked fine, with this mobo there isn't 
DMA support for my southbridge in kernel 2.4.19 , so I've upgraded it to 
2.4.20 , but I have a problem.

In the boot I see that he recognize my chip and turn on DMA on hda and 
hdb (My HD) , but when it try to start DMA on my hdc (first DVD Reader) 
It locks up with "hdc: DMA disabled" message, then it said about the 
device that is BUSY , then it said "ide1: resetting!" and return to the 
message above ("hdc:DMA...:") in an infinite loop.I don't know what to 
do.I've tried to install ac2 patch for linux-2.4.20 tree, and it don't 
lock up to hdc: DMA disabled (this appears again , but don't freeze 
here) but when I try to enable ide-scsi module it freeze with messages 
about SCSI problems, then it tries to resetting all the SCSI emulated 
devices and this create an infinite loop of these messages!

What is the problem?

Thanks a lot


Bye

Marcello

