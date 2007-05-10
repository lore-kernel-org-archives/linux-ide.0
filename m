From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Wed, 09 May 2007 20:18:06 -0400
Message-ID: <464264BE.2090301@garzik.org>
References: <20070429161542.GA12501@havoc.gtf.org> <200705011434.40440.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50650 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758830AbXEJASJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 20:18:09 -0400
In-Reply-To: <200705011434.40440.jesse.barnes@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jesse Barnes wrote:
> On Sunday, April 29, 2007 9:15 am Jeff Garzik wrote:
>> Noteworthy changes:
>> * remove combined mode PCI quirk.  IDE driver selection (libata or
>>   old-IDE) is now determined purely by module load order.
>> * new driver API, that is far more like other kernel APIs:
>>   alloc...register...unregister...free.
>> * More Alan PATA work
>> * Lots of other little bits.
> 
>>  drivers/pci/quirks.c                |  113 ----
> 
> Looks like you removed the combined_mode quirk (yay!) but didn't update
> kernel-parameters.txt...  might confuse people.  Here's a patch to remove
> mention of it from the documentation.
> 
> Signed-off-by:  Jesse Barnes <jesse.barnes@intel.com>
> 
> Thanks,
> Jesse
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 84c3bd0..49b1ea3 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -722,14 +722,6 @@ and is between 256 and 4096 characters. It is defined in the file
>  	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
>  			Format: <irq>
>  
> -	combined_mode=	[HW] control which driver uses IDE ports in combined
> -			mode: legacy IDE driver, libata, or both
> -			(in the libata case, libata.atapi_enabled=1 may be
> -			useful as well).  Note that using the ide or libata
> -			options may affect your device naming (e.g. by
> -			changing hdc to sdb).
> -			Format: combined (default), ide, or libata
> -

applied


