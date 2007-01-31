From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 15:54:10 +0300
Message-ID: <45C09172.1030304@ru.mvista.com>
References: <45BF5003.3000503@imc-berlin.de>	 <20070130164401.295f9913@localhost.localdomain>	 <45BF7658.1090204@imc-berlin.de>	 <20070130172629.70ad628d@localhost.localdomain>	 <45BF7E21.7010605@imc-berlin.de>	 <20070130180727.594b35d0@localhost.localdomain>	 <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com> <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com> <45C0536F.5020005@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:43971 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933208AbXAaMyS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 07:54:18 -0500
In-Reply-To: <45C0536F.5020005@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org

Hello.

Steven Scholz wrote:

>>Maybe the FPGA is discarding the taskfile writes once the HOB bit is
>>set?  It wouldn't affect the READ NATIVE MAX ADDRESS EXT command being
>>issued since the only the command register matters for that, but it
>>would affect SET MAX ADDRESS EXT working properly.

>>Without a device > 137GB to test with, and without errors on the
>>device, you might not see any odd behavior in normal usage.

>>It's *really* unlikely the drive doesn't have a working taskfile.

> I am sorry. But I don't understand what a "working taskfile" means.
> I don't have CONFIG_IDE_TASK_IOCTL enabled if that means anything.

> The FPGA does nothing except decoding adresseses from the ARM cpu,
> controlling the A[2..0], CS[1..0], IOR, IOW lines of the HDD.

    I've not seen you quoting the code that sets ofsset for the 
IDE_CONTROL_REG, BTW... Without this register, LBA48 is completely broken

> In linux all I do is setting up some hw_regs_t struct (with hw.io_ports[])
> according to my memory map and call ide_register_hw() ...

> So looks like I need to find out more about that taskfile stuff.

    Taskfile is another (and probably an older one) anme for the IDE command 
block registers.

> Steven

MBR, Sergei
