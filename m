From: Eric Mudama <edmudama@gmail.com>
Subject: Re: DriveReady SeekComplete Error - thinkpad T41p
Date: Tue, 25 Jan 2005 13:26:44 -0700
Message-ID: <311601c905012512261520357f@mail.gmail.com>
References: <200501250829.49755.ruben@hotheads.de>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.196]:22337 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262113AbVAYU0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2005 15:26:47 -0500
Received: by rproxy.gmail.com with SMTP id z35so649991rne
        for <linux-ide@vger.kernel.org>; Tue, 25 Jan 2005 12:26:44 -0800 (PST)
In-Reply-To: <200501250829.49755.ruben@hotheads.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ruben Jenster <ruben@hotheads.de>
Cc: linux-ide@vger.kernel.org

On Tue, 25 Jan 2005 08:29:49 +0100, Ruben Jenster <ruben@hotheads.de> wrote:
> Hi,
> 
> I get the following error on a thinkpad T41p from kernel 2.6.10 to 2.6.11-rc2.
> It doesn't matter whether multimode is enabled or not.
> 
> > hda: max request size: 128KiB
> > hda: Host Protected Area detected.
> >         current capacity is 109170031 sectors (55895 MB)
> >         native  capacity is 117210240 sectors (60011 MB)
> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> > ide: failed opcode was: 0xf9
> > hda: 109170031 sectors (55895 MB) w/7877KiB Cache, CHS=65535/16/63,
> UDMA(100)
> > hda: cache flushes supported
> >  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >

It refused a "set max address" command.  Here's a snippet of text from
a relatively modern ATA draft spec:

--------

After successful command completion, all read and write access
attempts to addresses greater than specified by the successful SET MAX
ADDRESS command shall be rejected with an ID Not Found error (see
clause 6.3.4). IDENTIFY DEVICE data words (61:60) shall reflect the
maximum address set with this command.

If the 48-bit Address feature set is supported, the value placed in
IDENTIFY DEVICE data words (103:100) shall be the same as the value
placed in words (61:60).

Hosts shall not issue more than one non-volatile SET MAX ADDRESS or
SET MAX ADDRESS EXT command after a power-on or hardware reset.
Devices should report an IDNF error upon receiving a second
non-volatile SET MAX ADDRESS command after a power-on or hardware
reset.

The contents of IDENTIFY DEVICE data words and the max address shall
not be changed if a SET MAX ADDRESS command fails.

After a successful SET MAX ADDRESS command using a new maximum LBA the
content of all IDENTIFY DEVICE data words shall comply with 4.2.1 and
the content of words (61:60) shall be equal to the new Maximum LBA +
1.

A successful READ NATIVE MAX ADDRESS command shall immediately precede
a SET MAX ADDRESS  command.

This command is mandatory for devices that implement the Host
Protected Area feature set. This command shall not be implemented if
the Removable feature set is implemented.

--------

My first guess is that the drive is refusing an attempt to set it to
use its full capacity.  Can you send the identify block? 
(/proc/ide/hda/identify or something like that)

--eric
