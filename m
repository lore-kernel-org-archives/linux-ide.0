From: Wayne Sherman <Wayne@SystemDesignWorks.com>
Subject: Re: AHCI support on Intel chipsets (confusion?)
Date: Sat, 02 Dec 2006 02:48:29 -0800
Message-ID: <457159FD.4000804@SystemDesignWorks.com>
References: <45715381.80206@SystemDesignWorks.com> <c384c5ea0612020232n3d33cfady627987e98957d495@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ev1s-69-57-152-63.ev1servers.net ([69.57.152.63]:34727 "EHLO
	server.monsterhosting.org") by vger.kernel.org with ESMTP
	id S1759440AbWLBKsd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Dec 2006 05:48:33 -0500
In-Reply-To: <c384c5ea0612020232n3d33cfady627987e98957d495@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Leon,

  Thanks for the reply.  I have enabled SATA Enhanced mode, but still 
did not see any mention of AHCI in my dmesg output.  I also did not find 
a setting for AHCI in the BIOS.  My board is a Gigabyte:

http://www.gigabyte.com.tw/Products/Motherboard/Products_Spec.aspx?&ProductID=2304

   I was about to email GigaByte and ask them about AHCI, but I decided 
to do a search first.  That is when I found the Intel page that says 
ICH7 does not support AHCI.  If that is so, then I need a different 
motherboard.  Can you confirm that ICH7 does not support AHCI?

Thanks,

Wayne


Leon Woestenberg wrote:
> Wayne,
> 
> On 12/2/06, Wayne Sherman <Wayne@systemdesignworks.com> wrote:
>> Jeff Garzik,
>> ...
>> my decision on the kernel source code.  It seems to indicate the Intel
>> ICH7 is AHCI compatible:
>>
> We (yesterday) found out that our board (a Supermicro PDSMI+, ICH7 as
> well) needs the proper BIOS setting in order for it to appear as a
> AHCI capable controller.
> 
> Precisely, we found if we enabled "SATA Enhanced Mode", then enabled
> "AHCI" in the BIOS, the chipset identifies itself as a 0x27c1 device
> rather than a 0x27c0 device.
> 
> This is probably exactly the issue you ran into. Try your BIOS settings.
> 
> Regards,
> 
> Leon Woestenberg.
> 
