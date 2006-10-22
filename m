From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under kernel 2.6.18
Date: Sun, 22 Oct 2006 16:33:58 +0100
Message-ID: <op.thtxiw0axci36i@akima>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com> <452A0BA6.8030401@gmail.com> <op.tg5ssogyxci36i@akima> <op.tg93opjoxci36i@akima> <4530D474.6000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:9089 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750943AbWJVPd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Oct 2006 11:33:57 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1061486ugd
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 08:33:55 -0700 (PDT)
In-Reply-To: <4530D474.6000609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, 14 Oct 2006 13:13:40 +0100, Tejun Heo <htejun@gmail.com> wrote:

> [cc'ing Carlos again.  please don't drop cc list]
>
> Jonathan Bell wrote:
>> On Mon, 09 Oct 2006 15:49:26 +0100, Jonathan Bell  
>> <doggs.lay.eggs@googlemail.com> wrote:
>>
>>> On Mon, 09 Oct 2006 09:43:18 +0100, Tejun Heo <htejun@gmail.com> wrote:
>>>
>>>> Tejun Heo wrote:
>>>>> I cannot reproduce your problem here.  Can you retest after running  
>>>>> the following commands?
>>>>>  # setpci -s 01:07.0 0c.b=04
>>>>> # setpci -s 01:08.0 0c.b=04
>>>>
>>>> I forgot something.
>>>>
>>>> * You need to make sata_sil a module.  Boot, unload sata_sil if  
>>>> loaded, run above commands, load sata_sil and test.
>>>>
>>>> * If above commands don't work, try =00 instead of =04.
>>>>
>>>> Thanks.
>>>
>>> setpci -s 01:07/8.0 0c.b=04 performed, sata_sil inserted...
>>>
>>> md5sum crapped out again, similar errors in dmesg as before.
>>>
>>> setpci -s 01:07/8.0 0c.b=00 performed, sata_sil inserted...
>>>
>>> It worked...
>>> cp ~/hugefile /mnt/sda1 && cp /mnt/sda1/hugefile /mnt/sdb1
>>> && md5sum /mnt/sda1/hugefile /mnt/sdb1/hugefile
>>>
>>> ccf5f9052aa1fac3062c3f1920abb1fc  /mnt/sda1/hugefile
>>> ccf5f9052aa1fac3062c3f1920abb1fc  /mnt/sdb1/hugefile
>>>
>>> What does this register do, out of interest? With 00 it took ages and  
>>> made my load average shoot up to about 6.50!
>>  Apologies for bumping this a mere 2 days later but I felt that  
>> progress was being made...
>>  Ok, so it's the PCI cache line size register... 08 means a value of 64  
>> bits which corresponds to the line size of my L1/L2 cache, am I correct?
>
> Yes, you're right.
>
>> The fact that even with a value of 01 set (for fun) still corrupts the  
>> file seems to indicate that the fault is somewhere there, but why?  
>> Should I just give up and buy a decent mainboard? :P (currently running  
>> A7N8X-Deluxe v2.0, latest 1008 BIOS)
>
> I'm not sure whether the cache line size is the actual problem or the  
> slowdown caused by 0 cacheline size (r/w optimizations based on  
> cacheline size are turned off) hides the problem.  I was hoping BIOS  
> messed up while setting cachline size and adjusting it to 4 makes things  
> work.
>
>> I would like to know more about this since the only topics on PCI cache  
>> line sizes I can find are ones where people are having problems.
>
> I don't know.  I think this can be best diagnosed by SIMG.  Carlos, does  
> anything ring a bell?
>
> Thanks.
>

This is where it gets wierd... I may have uncovered a BIOS bug.

I changed the mainboard out as a last-ditch attempt to get this working  
and BEHOLD! The drives work perfectly. I swapped the A7N8X-D out for an  
Abit NF7-M (same nForce2 chipset, with the exception of onboard graphics)  
and used the same hardware as before.

This NF7-M is on loan to me so I cannot use it indefinitely. Any ideas,  
Tejun?

Worst comes to worst I can buy an old nForce2 board for a minor sum off  
eBay.

Jonathan



