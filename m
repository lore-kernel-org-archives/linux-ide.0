From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 11:23:50 -0700
Message-ID: <311601c90701301023j16b54a8oead85b43c31bdb4f@mail.gmail.com>
References: <45BF5003.3000503@imc-berlin.de>
	 <20070130164401.295f9913@localhost.localdomain>
	 <45BF7658.1090204@imc-berlin.de>
	 <20070130172629.70ad628d@localhost.localdomain>
	 <45BF7E21.7010605@imc-berlin.de>
	 <20070130180727.594b35d0@localhost.localdomain>
	 <45BF88B9.3050802@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:24488 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030195AbXA3SXw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 13:23:52 -0500
Received: by wr-out-0506.google.com with SMTP id 68so57615wri
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 10:23:52 -0800 (PST)
In-Reply-To: <45BF88B9.3050802@imc-berlin.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 1/30/07, Steven Scholz <steven.scholz@imc-berlin.de> wrote:
> I have connected HDD's A[2..0] to CPU's A[3..1] and do something like
>
>         for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
>                 hw.io_ports[i] = ide_virt_base + (i << 1);
>         }
>
> thus all HDD registers are accessed on a 16bit aligned address. Thus
> ide_inb() should return the correct value.
> And btw are things like identify driver use 8bit transfers?
>
> How could one then explain
>
> current capacity is 78140160 sectors would be           0x000004A85300
> native  capacity is 185074430006016 sectors would be    0xA852FFA85300
>
> ? First three bytes ok, then the other three bytes rubbish?
>
> Steven

Maybe I am misunderstanding the issue, but the upper 3 bytes (and in
fact all the extended registers) of a 48-bit LBA address are found by
re-reading the taskfile registers after setting the HOB bit (bit 7) in
the device control register.  If your FPGA is simulating a taskfile
for the generic driver to read, then your FPGA will need to perform
this access on the device to simulate the extended taskfile registers.
 In the above log, your upper 3 bytes appear to be garbage.

This is documented in the description of the "48-bit Address Feature
Set" in recent ATA specifications.  Recent working draft
specifications are available from www.t13.org for anyone to browse and
download.

--eric
