From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Read Prefetch, Post Write on IDE chipsets
Date: Sun, 02 Sep 2007 18:07:47 +0400
Message-ID: <46DAC3B3.9040806@ru.mvista.com>
References: <46DAB1DF.5050109@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53127 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932253AbXIBOE7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 10:04:59 -0400
In-Reply-To: <46DAB1DF.5050109@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

Hello.

Matt Sealey wrote:

> Does anyone have any decent information on the purpose,

    Prefetch allows the controller to keep reading data until it fills it's 
(usually 512 byte sector but may be programmable size on some devices to 
accomodate ATAPI) not waiting for PCI I/O read cycles -- which are than 
satisfied from that buffer (if it's not empty). So, this effectively decoples 
PCI and IDE transactions.

> performance potential
> or perhaps quirks of the "read prefetch" and "post write" buffer 
> features on some IDE chipsets?

    The quirks are quite well known: non-data reads get into the prefetch 
buffer, sometimes even reads from the mate channel which causes the wrong 
sector data to be read and buffer left in non-empty state, thus causing wrong 
reads afterwards, if the measures are not taken (like the buffer reset).

> It doesn't look like any standard but at least is included in quite a few
> of the libata drivers,

   It may be considered a "de facto" standard.

> and a lot of x86 BIOS control has toggles to try and turn it on or off.

   Yeah, for ATAPI devices it's usually turned off (unless meybe for the 
commands known to return a power of 2 bytes of data, like 2KiB).

> But, what is it? I've never seen any documentation but which register to 
> use
> to toggle it..

    I can advice reading Intel's manual, 29860004.pdf, or the datasheets for 
the concrete chipset...

> no vendor recommendations to turn it on, it seems like a rather
> secret feature..?

    Just misdocoumeted and/or buggy sometimes.  It's generally a good idea to 
turn it off for ATAPI devices, and on for normal disks (unless there's a known 
bug in its implementation).

MBR, Sergei
