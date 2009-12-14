From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] au1xxx-ide.c: ioremap() returns a void __iomem *
Date: Mon, 14 Dec 2009 12:27:29 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200E9AD@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB10C2@mi8nycmail19.Mi8.com><4B241F10.7050706@ru.mvista.com> <20091213.205212.212692978.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932248AbZLNR1i@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20091213.205212.212692978.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, sshtylyov@ru.mvista.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday, December 13, 2009 9:52 PM, David Miller wrote:
>
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Sun, 13 Dec 2009 01:54:08 +0300
> 
>> H Hartley Sweeten wrote:
>> 
>>> The ioremap return value is an __iomem *, not an integer.  Update the
>>> private structure to reflect this.  While here, remove the typedef
>>> for _auide_hwif and just use struct auide_hwif instead as recommended
>>> by Documentation/CodingStyle.
>>>
>>> auide_setup_ports() still needs to cast the regbase back to an integer
>>> to correctly setup the io_ports_array.
>>>
>>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
 ...
>>>     a) 'arch/mips/include/asm/mach-au1x00/au1xxx_ide.h'
>>> -     containes : struct _auide_hwif
>>> +     containes : struct auide_hwif
>>>   
>> 
>>   Contains?
>> 
>>   Other than that,
>> 
>> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Oops... Did not notice that spelling error.  Will fix and repost the patch.

> Also, this patch doesn't apply to the current tree, the
> au_ide_remove() function has been fixed to use
> resource_size().
>
> Please respin your patch, and also incorporate the
> documentation spelling fix suggested by Sergei (and
> make sure to keep the alignment of that section of
> documentation when you do that).

Hmmm.. That patch was also mine.  I waited until it was merged before creating
this one. It should have accounted for that.  I will recheck the patch to see
what was missed.

Regards,
Hartley
