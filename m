From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Mon, 12 Oct 2009 19:07:03 +0900
Message-ID: <4AD2FFC7.5010402@kernel.org>
References: <4ABBB8C2.2080901@sbg.ac.at> <200910101513.51320.elendil@planet.nl> <4AD2DFA4.9000602@kernel.org> <200910121148.16439.elendil@planet.nl> <4AD2FC60.8080705@kernel.org> <4AD2FD10.2010800@sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45157 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755793AbZJLKH7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Oct 2009 06:07:59 -0400
In-Reply-To: <4AD2FD10.2010800@sbg.ac.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Huemer <alexander.huemer@sbg.ac.at>
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Alexander Huemer wrote:
> Tejun Heo wrote:
>> Frans Pop wrote:
>>  
>>> On Monday 12 October 2009, Tejun Heo wrote:
>>>    
>>>> Alexander, can you please attach full boot log and the output of
>>>> "lspci -nn"?  Also, how reproducible is the problem?  You already
>>>> answered to Frans' question but can you be more specific?
>>>>       
>>> Full dmesg was made available earlier at:
>>> http://xx.vu/~ahuemer/dmesg_ahuemer_20090923
>>>     
>>
>> Does blacklisting i801_smbus make any difference?
>>
>>   
> lspci -nn:
> http://xx.vu/~ahuemer/lspci_nn_ahuemer_20091012
> 
> what do you mean with "blacklisting i801_smbus" ?

[    3.872387] i2c /dev entries driver
[    3.873943] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 23 (level, low) -> IRQ 23
[    3.875580] w83627hf: Found W83627HF chip at 0x290

IRQ23 is also used by i801_smbus and it would be nice to confirm
whether the problem can still be triggered with that driver not
loaded.  Adding "blacklist i2c_i801" to /etc/modprobe.d/blacklist
should probabaly do the trick.

Thanks.

-- 
tejun
