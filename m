From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] au1xxx-ide.c: ioremap() returns a void __iomem *
Date: Sun, 13 Dec 2009 20:52:12 -0800 (PST)
Message-ID: <20091213.205212.212692978.davem@davemloft.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB10C2@mi8nycmail19.Mi8.com>
	<4B241F10.7050706@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42491
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756702AbZLNEwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Dec 2009 23:52:12 -0500
In-Reply-To: <4B241F10.7050706@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: hartleys@visionengravers.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Sun, 13 Dec 2009 01:54:08 +0300

> H Hartley Sweeten wrote:
> 
>> The ioremap return value is an __iomem *, not an integer.  Update the
>> private structure to reflect this.  While here, remove the typedef
>> for _auide_hwif and just use struct auide_hwif instead as recommended
>> by Documentation/CodingStyle.
>>
>> auide_setup_ports() still needs to cast the regbase back to an integer
>> to correctly setup the io_ports_array.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
 ...
>>     a) 'arch/mips/include/asm/mach-au1x00/au1xxx_ide.h'
>> -     containes : struct _auide_hwif
>> +     containes : struct auide_hwif
>>   
> 
>   Contains?
> 
>   Other than that,
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Also, this patch doesn't apply to the current tree, the
au_ide_remove() function has been fixed to use
resource_size().

Please respin your patch, and also incorporate the
documentation spelling fix suggested by Sergei (and
make sure to keep the alignment of that section of
documentation when you do that).

Thanks.
