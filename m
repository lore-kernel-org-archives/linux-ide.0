From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 13:01:16 -0700
Message-ID: <311601c90701301201p20b99262y54e0ef651751fe50@mail.gmail.com>
References: <45BF5003.3000503@imc-berlin.de>
	 <20070130164401.295f9913@localhost.localdomain>
	 <45BF7658.1090204@imc-berlin.de>
	 <20070130172629.70ad628d@localhost.localdomain>
	 <45BF7E21.7010605@imc-berlin.de>
	 <20070130180727.594b35d0@localhost.localdomain>
	 <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com>
	 <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:2517 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbXA3UBS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 15:01:18 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1333606wra
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 12:01:17 -0800 (PST)
In-Reply-To: <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>, Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 1/30/07, Eric D. Mudama <edmudama@gmail.com> wrote:
> It's *really* unlikely the drive doesn't have a working taskfile.

One other thing is that these registers in the drive are pretty dumb,
at least on the stuff I've worked with.  However, it allows for some
neat optimizations...

For example, you don't technically need to rewrite the task file to
set the drive to max capacity.

Simply writing the command register with 0x27 for READ NATIVE MAX
ADDRESS EXT, followed immediately by a write to the command register
with 0x37, would (in theory) set the drive to the proper size, since
the contents of both regular and HOB registers would be setup already
inside the device.

Another trick is when doing sequential DMA reads, since most drives
stuff the taskfile with the next sequential block when a DMA command
completes, you could save the taskfile writes and just issue another
write to the command register for the next sequential chunk of data.
On older PATA chipsets, this can buy you a few percent performance
when using smaller block sizes.

Granted these are all benchmarking hacks, and the behavior isn't
guaranteed I don't think, but I've seen this stuff done in driver
implementations before.

--eric
