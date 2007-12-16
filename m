From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: How to Switch DMA off for only one Harddisk at Kernelboot
Date: Sun, 16 Dec 2007 20:45:39 +0100
Message-ID: <47658063.5010707@googlemail.com>
References: <4765690C.6010605@j-o-a.de> <47657BA8.3020004@googlemail.com> <47657D79.7090100@j-o-a.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758671AbXLPTp5@vger.kernel.org>
In-Reply-To: <47657D79.7090100@j-o-a.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Joa <oliver@j-o-a.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Oliver Joa wrote:
> Hi,
> 
> Gabriel C wrote:
>> Oliver Joa wrote:
>>> Hi,
>> Hi Oliver ,
>>
>>> how can I tell the kernel not to probe DMA for a specific harddisk (e.g. 
>>> hda). My first Drive (hda) is a Compact-Flash Card which can not do DMA. 
>>> The kernel tries at boot to switch to DMA but fails. If I use ide=nodma, 
>>> the kernel boots about 2 minutes faster, but then I can not switch on 
>>> DMA for the second Drive (hdc) which is a normal Harddisk. Do I have to 
>>> live with this 2 minutes waiting time or is there another solution? I 
>>> did not find any kernel-parameter for this purpose.
>>>
>>> Sorry if I ask here, but I can not find any solution, and I asked 
>>> already in other groups.
>>>
>>> Thank you very much
>> Should work with hda=nodma or ideX=nodma ( where X is your HDD nr , in your case is 0 )
> 
> I tried this already, it does not work.
> 
>> Also have a look at Documentation/ide.txt.
> 
> I read this already. Searching for "nodma" in this document gives only 
> one line:
> 
>   "ide=nodma"            : disable DMA globally for the IDE subsystem.
> 
> If the documentation is correct hda=nodma and ideX=nodma should not 
> work. I use kernel 2.6.23.1 at the moment.

grep nodma Documentation/ide.txt
 "hdx=nodma"            : disallow DMA

ide=foo_option is for the whole ide sub-system where ideX|hdX=foo_option is just for that HDD.

Anyway I've CC'ed linux-ide.

> 
> Thanks
> 
> Olli
> 


Gabriel
