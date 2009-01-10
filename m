From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [bisected] Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 23:50:19 +0300
Message-ID: <49690A0B.6010701@ru.mvista.com>
References: <200901091334.55823.borntraeger@de.ibm.com>	<200901101009.13699.borntraeger@de.ibm.com>	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>	<200901101242.05203.borntraeger@de.ibm.com>	<49688B63.5030105@ru.mvista.com>	<20090110122130.318cf168@lxorguk.ukuu.org.uk>	<20090110130745.GA14049@elte.hu>	<49689EA8.20506@garzik.org>	<20090110132412.GB14049@elte.hu>	<20090110133617.GA22304@elte.hu>	<20090110135731.0da08c90@lxorguk.ukuu.org.uk>	<4968BA6F.8050207@ru.mvista.com> <20090110152800.44308491@lxorguk.ukuu.org.uk> <4968C5CA.6010508@ru.mvista.com> <4968FFD7.6070302@ru.mvista.com> <49690589.1070809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754559AbZAJUuh@vger.kernel.org>
In-Reply-To: <49690589.1070809@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello.

Jeff Garzik wrote:

>>   Correctly indeed? I'm not at all sure it's correct to read an extra 
>> 16-bit word off the device when it thinks it's already done with the 
>> data transfer. This is not the same as to read 16-bit word and ignore 
>> its MSB as it happened. The same concern about the writes... Note 
>> that the IDE code doesn't do this...
>
> Nod.  And that gets us back to the original point...

   Note that Alan's point is still valid: this WARN_ON_ONCE() would 
incorrectly trigger on odd length ATAPI transfers.

>     Jeff

MBR Sergei
