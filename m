From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Tue, 13 Oct 2009 11:17:44 +0900
Message-ID: <4AD3E348.5030508@kernel.org>
References: <4ABBB8C2.2080901@sbg.ac.at> <200910101513.51320.elendil@planet.nl> <4AD2DFA4.9000602@kernel.org> <200910121148.16439.elendil@planet.nl> <4AD2FC60.8080705@kernel.org> <4AD2FD10.2010800@sbg.ac.at> <4AD2FFC7.5010402@kernel.org> <4AD300B5.6080102@sbg.ac.at> <4AD34554.3050701@sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758767AbZJMCSh@vger.kernel.org>
In-Reply-To: <4AD34554.3050701@sbg.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Huemer <alexander.huemer@sbg.ac.at>, Jean Delvare <jdelvare@suse.de>
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

[cc'ing Jean and quoting whole body]

Hello, Jean.

It seems i2c_i801 is triggering IRQ storm on Alexander's machine.  The
original thread is

 http://thread.gmane.org/gmane.linux.kernel/894187

Any ideas?

Thanks.

Alexander Huemer wrote:
> Alexander Huemer wrote:
>> Tejun Heo wrote:
>>> Alexander Huemer wrote:
>>>  
>>>> Tejun Heo wrote:
>>>>   
>>>>> Frans Pop wrote:
>>>>>  
>>>>>     
>>>>>> On Monday 12 October 2009, Tejun Heo wrote:
>>>>>>          
>>>>>>> Alexander, can you please attach full boot log and the output of
>>>>>>> "lspci -nn"?  Also, how reproducible is the problem?  You already
>>>>>>> answered to Frans' question but can you be more specific?
>>>>>>>                 
>>>>>> Full dmesg was made available earlier at:
>>>>>> http://xx.vu/~ahuemer/dmesg_ahuemer_20090923
>>>>>>             
>>>>> Does blacklisting i801_smbus make any difference?
>>>>>
>>>>>         
>>>> lspci -nn:
>>>> http://xx.vu/~ahuemer/lspci_nn_ahuemer_20091012
>>>>
>>>> what do you mean with "blacklisting i801_smbus" ?
>>>>     
>>>
>>> [    3.872387] i2c /dev entries driver
>>> [    3.873943] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 23 (level,
>>> low) -> IRQ 23
>>> [    3.875580] w83627hf: Found W83627HF chip at 0x290
>>>
>>> IRQ23 is also used by i801_smbus and it would be nice to confirm
>>> whether the problem can still be triggered with that driver not
>>> loaded.  Adding "blacklist i2c_i801" to /etc/modprobe.d/blacklist
>>> should probabaly do the trick.
>>>
>>> Thanks.
>>>
>>>   
>> okay, i think you assume that i2c_i801 is a module.
>> it is indeed built into the kernel.
>> i'll rebuild the kernel without that component and run a test again.
>>
>> regards
>> -alex
> tejun, it seems you hit an interesting point.
> i compiled kernel-2.6.31.3 with my ususal config _without_ i2c_i801.
> my usual test (compilation of gcc-4.3.2) finished 5 times without the
> error.
> i'll let it run some more times over night.
> does anybody have an idea how i can trace what exactly causes the error
> during the compilation run so that i can create a short test program ?
> 
> regards
> -alex

-- 
tejun
