From: Oliver Joa <oliver@j-o-a.de>
Subject: Re: How to Switch DMA off for only one Harddisk at Kernelboot
Date: Sun, 16 Dec 2007 20:53:25 +0100
Message-ID: <47658235.7050409@j-o-a.de>
References: <4765690C.6010605@j-o-a.de> <47657BA8.3020004@googlemail.com> <47657D79.7090100@j-o-a.de> <47658063.5010707@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758357AbXLPTxi@vger.kernel.org>
In-Reply-To: <47658063.5010707@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel C <nix.or.die@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

Gabriel C wrote:

[...]

>>> Also have a look at Documentation/ide.txt.
>> I read this already. Searching for "nodma" in this document gives only 
>> one line:
>>
>>   "ide=nodma"            : disable DMA globally for the IDE subsystem.
>>
>> If the documentation is correct hda=nodma and ideX=nodma should not 
>> work. I use kernel 2.6.23.1 at the moment.
> 
> grep nodma Documentation/ide.txt
>  "hdx=nodma"            : disallow DMA
> 
> ide=foo_option is for the whole ide sub-system where ideX|hdX=foo_option is just for that HDD.


/usr/src/linux-2.6.23.1$ grep nodma Documentation/ide.txt
  "ide=nodma"            : disable DMA globally for the IDE subsystem.

/usr/src/linux-2.6.21.5$ grep nodma Documentation/ide.txt
  "ide=nodma"            : disable DMA globally for the IDE subsystem.

/usr/src/linux-2.6.12# grep nodma Documentation/ide.txt
  "ide=nodma"            : disable DMA globally for the IDE subsystem.

Sorry, but I can not find this option, and it does not work. Which 
kernel do you use?

Thanks

Olli
