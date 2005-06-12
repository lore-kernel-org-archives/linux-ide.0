From: Wes Newell <w.newell@verizon.net>
Subject: Re: Pata support for SIS180
Date: Sun, 12 Jun 2005 16:50:13 -0500
Message-ID: <42ACAE15.4030001@verizon.net>
References: <42AAE8B1.8080607@verizon.net> <42AC9BB9.2030304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:52451 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261243AbVFLVqj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Jun 2005 17:46:39 -0400
Received: from [192.168.0.2] ([70.104.23.44])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IHZ0060YR5QJO4K@vms048.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sun, 12 Jun 2005 16:46:39 -0500 (CDT)
In-reply-to: <42AC9BB9.2030304@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: "linux.ide" <linux-ide@vger.kernel.org>

Uwe Koziolek wrote:

>Wes Newell schrieb:
>
>  
>
>>Can anyone tell me if/how one could add device support for the sis180
>>chipset pata ports to the sis5513 module? I've tried adding this as
>>others have said it works for the 965 southbridge,
>>
>>if ((trueid == 0x5518) || (trueid == 0x0180)) {
>>
>>but it stll doesn't see a real sis180 on a Jetway S755MAX MB.
>>    
>>
>
>
>you must include the chip into the pci_device_id table
>
>static *struct* pci_device_id sis5513_pci_tbl[] = {
>	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>	{ 0, },
>};
>
>
>regards
>Uwe Koziolek
>
>  
>
Won't compile. I copied the sis180 line above into the code (- the + 
sign of course). I tried both 0x180 and 0x0180 as a trueid. Didn't 
matter. Keep in mind I'm not a C programmer.:-)

This is the error I get;

  CC      drivers/ide/pci/sis5513.o
drivers/ide/pci/sis5513.c:955: error: `PCI_DEVICE_ID_SI_180' undeclared 
here (not in a function)
drivers/ide/pci/sis5513.c:955: error: initializer element is not constant
drivers/ide/pci/sis5513.c:955: error: (near initialization for 
`sis5513_pci_tbl[2].device')
drivers/ide/pci/sis5513.c:955: error: initializer element is not constant
drivers/ide/pci/sis5513.c:955: error: (near initialization for 
`sis5513_pci_tbl[2]')
drivers/ide/pci/sis5513.c:956: error: initializer element is not constant
drivers/ide/pci/sis5513.c:956: error: (near initialization for 
`sis5513_pci_tbl[3]')


