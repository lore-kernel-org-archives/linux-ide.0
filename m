From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Thu, 22 Dec 2005 12:11:26 -0800
Message-ID: <43AB086E.9050206@physics.ucsd.edu>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu> <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu> <Pine.LNX.4.63.0512211451500.7522@dingo.iwr.uni-heidelberg.de> <43A9BA8D.9040200@physics.ucsd.edu> <Pine.LNX.4.63.0512221550060.10585@dingo.iwr.uni-heidelberg.de> <43AAFE93.70502@physics.ucsd.edu> <Pine.LNX.4.58.0512221135500.3425@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl093-032-179.snd1.dsl.speakeasy.net ([66.93.32.179]:59352
	"EHLO partlyharmless.local") by vger.kernel.org with ESMTP
	id S1030297AbVLVULc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Dec 2005 15:11:32 -0500
In-Reply-To: <Pine.LNX.4.58.0512221135500.3425@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, Sebastian Kuzminsky <seb@highlab.com>, linux-ide@vger.kernel.org

Randy.Dunlap wrote:

>On Thu, 22 Dec 2005, Terrence Martin wrote:
>
>  
>
>>Bogdan Costescu wrote:
>>
>>    
>>
>>>On Wed, 21 Dec 2005, Terrence Martin wrote:
>>>
>>>      
>>>
>>>>So I compiled 2.6.15-r5 without MSI enabled.
>>>>        
>>>>
>>>Hmm, so far all reports indicated that MSI had to be disabled... so
>>>maybe the Marvell controller is at fault.
>>>
>>>      
>>>
>>>>Looking at MSI though it seems to indicate that without it I cannot
>>>>get PCI-Express to work?
>>>>        
>>>>
>>>I think that INTx emulation should be present by default if MSI is not
>>>enabled, but I'm not sure...
>>>
>>>      
>>>
>>Well I can see the PCI-E port on lspci. I can test them out with a PCI-E
>>ethernet card on tuesday just ot make sure.
>>
>>As for the card being a problem, possibly. I know I got one of my
>>opterons to work with the marvell controller with the Marvell written
>>driver and as far as I can tell RedHat enables MSI according to the
>>kernel config in /boot. That was a binary driver though and on an
>>Opteron, although the controller is claimed to be the same as what I
>>have in the Xeons according to lspci.  I have not done the same steps
>>for these Xeons. I have had little or no luck getting the marvell code
>>to work with Redhat stock kernels in Centos 4.2 and was only able to use
>>the Marvell driver as a binary compiled by supermicro with a 4.0 system.
>>
>>I also do not see any mention of MSI in the instructions on how to
>>install with the Marvell driver in RH FC.
>>http://www.keffective.com/mvsata/ . At a glance it does not seem that
>>MSI comes into play with the Marvell written driver, unfortunately that
>>driver does not seem to like newer kernels, and I have not been able to
>>get it to work myself when compiled from source. I am trying to track
>>that problem down with Supermicro and my vendor.
>>    
>>
>
>/proc/interrupts would show/tell whether MSI interrupts are
>being used, in case you are not sure or wondering about that.
>
>  
>
>>Perhaps this might mean something to someone. With the Marvell source
>>code I can get one of the versions to build with 2.6.15-rc5, however I
>>get an error "insmod: error inserting 'mv_sata.ko': -1 Unknown symbol in
>>module". Any ideas why that error?
>>    
>>
>
>Kernel message log (dmesg) should have more info, like
>the missing symbol's name.
>
>  
>
It does

mv_sata: Unknown symbol scsi_set_device

As for /proc/interupts, even if you do not have a PCI-E device would it 
report some numbers or? Both my Centos 4.2 default kernel as well as my 
kernel.org systems have MIS in the file but both are 0.

Terrence

