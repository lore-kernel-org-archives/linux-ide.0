From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 12:56:07 -0700
Message-ID: <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com>
References: <45BF5003.3000503@imc-berlin.de>
	 <20070130164401.295f9913@localhost.localdomain>
	 <45BF7658.1090204@imc-berlin.de>
	 <20070130172629.70ad628d@localhost.localdomain>
	 <45BF7E21.7010605@imc-berlin.de>
	 <20070130180727.594b35d0@localhost.localdomain>
	 <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:64793 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXA3T4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 14:56:09 -0500
Received: by wr-out-0506.google.com with SMTP id 68so83621wri
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 11:56:09 -0800 (PST)
In-Reply-To: <45BF8F33.3070008@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>, Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 1/30/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Steven Scholz wrote:
> > How could one then explain
>
> > current capacity is 78140160 sectors would be           0x000004A85300
> > native  capacity is 185074430006016 sectors would be    0xA852FFA85300
> >
> > ? First three bytes ok, then the other three bytes rubbish?
>
>     Note that they're not complete garbage but equal the value of the lower 3
> bytes minus 1. What is clear is that Read Native Max Address Ext command must
> be mistreating the HOB bit... :-)

These commands all just use ide_raw_taskfile(), there's nothing
special about READ NATIVE MAX ADDRESS EXT or SET MAX ADDRESS EXT.  I
still suspect the FPGA is misusing the HOB bit.

The driver (for example) does a READ MAX ADDRESS EXT and stored that
value (0x000004A852FF is what is returned), then somehow only wrote to
the lower 3 bytes of the LBA for the SET MAX command, the "previous
contents" would shift into those upper bytes as shown.

Maybe the FPGA is discarding the taskfile writes once the HOB bit is
set?  It wouldn't affect the READ NATIVE MAX ADDRESS EXT command being
issued since the only the command register matters for that, but it
would affect SET MAX ADDRESS EXT working properly.

Without a device > 137GB to test with, and without errors on the
device, you might not see any odd behavior in normal usage.

It's *really* unlikely the drive doesn't have a working taskfile.
--eric
