From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Subject: Re: HPT374 IDE problem with 2.6.21.* kernels
Date: Fri, 1 Jun 2007 23:13:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0706012311320.16639@petra.hos.u-szeged.hu>
References: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu>
 <20070601134607.ce4a37bd.akpm@linux-foundation.org> <46608764.5060807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764393AbXFAVOW@vger.kernel.org>
In-Reply-To: <46608764.5060807@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, 2 Jun 2007, Sergei Shtylyov wrote:

> Hello.
>
> Andrew Morton wrote:
>
>>> I saw a similar report yesterday with '2.6.21.1 - 97% wait time on IDE 
>>> operations' subject.
>
>>> After upgrading from 2.6.20.7 kernel to 2.6.21.1 my system started to 
>>> reset infrequenly the IDE bus. In the syslog DMA timeout, resetting IDE 
>>> bus messages appeared. I've changed the two disks attached to the HPT374 
>>> controller, and always the first disk had problems. I've replaced cables, 
>>> plugged the disks into other IDE ports, but it was only a matter of time 
>>> to experience an IDE reset. When I upgraded to 2.6.21.3 the resets became 
>>> much more frequent, this time even DMA was disabled too on the first disk. 
>>> I turned DMA back Manually with hdparm, and a few seconds of intense IO 
>>> activity resulted in another IDE reset.
>
>>> Reverting back to 2.6.20.12 the problem seems to be gone. BTW I'm using 
>>> the PATA driver for the HTP374, not the libata one.
>
>>> Is this a known problem/ is there a way I can help locating the cause of 
>>> the problem?
>
>   Yes, please post the boot log and the IDE reset log too for starters...
>
>> (cc's added)
>
> WBR, Sergei

Hi,

The log of a typical IDE reset is available here:

http://petra.hos.u-szeged.hu/~wildy/syslog.gz

This was the worst case: the IDE bus was resetted during the system boot.

   Geller Sandor <wildy@petra.hos.u-szeged.hu>
