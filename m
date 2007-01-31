From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 16:12:25 +0300
Message-ID: <45C095B9.30504@ru.mvista.com>
References: <45BF5003.3000503@imc-berlin.de>	 <20070130164401.295f9913@localhost.localdomain>	 <45BF7658.1090204@imc-berlin.de>	 <20070130172629.70ad628d@localhost.localdomain>	 <45BF7E21.7010605@imc-berlin.de>	 <20070130180727.594b35d0@localhost.localdomain>	 <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com> <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com> <45C0536F.5020005@imc-berlin.de> <45C09172.1030304@ru.mvista.com> <45C094E7.7040500@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44171 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933231AbXAaNMa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 08:12:30 -0500
In-Reply-To: <45C094E7.7040500@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org

Hello.

Steven Scholz wrote:
> Sergei,

>>>The FPGA does nothing except decoding adresseses from the ARM cpu,
>>>controlling the A[2..0], CS[1..0], IOR, IOW lines of the HDD.

>>   I've not seen you quoting the code that sets ofsset for the
>>IDE_CONTROL_REG, BTW... Without this register, LBA48 is completely broken

>         for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
>                 hw.io_ports[i] = ide_virt_base + (i << 1);
>         }

>         hw.io_ports[IDE_CONTROL_OFFSET] = ide_virt_base + 0x10;

> Thus it has an offset 0x10 from the base address.

> ide0 at 0xc3856000-0xc3856007,0xc3856010 on irq 27

> But I just noticed that A[2..0] should look like "110" when accessing the
> "Device Control Register". Thus the offset should be 0x16 instead! Right?

    If your FPGA passes A[2..0] untouched to the IDE bus, it's certainly 
wrong. It must pass 110.

> --
> Steven

MBR, Sergei
