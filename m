From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: 2.6.22-rc regression: smartctl does not work with SATA disk
Date: Sun, 10 Jun 2007 18:38:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706101837300.1302@p34.internal.lan>
References: <Pine.LNX.4.64.0706101049130.6348@kai.makisara.local>
 <466C7C35.7020105@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763676AbXFJWi1@vger.kernel.org>
In-Reply-To: <466C7C35.7020105@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Sun, 10 Jun 2007, Mark Lord wrote:

> Kai Makisara wrote:
>> The command 'smartctl -a /dev/sdb' fails with 2.6.22-rc4 kernel. The disk 
>> /dev/sdb is a SATA disk. The command does work still with a real SCSI disk.
>
> Last time I checked, one must supply the "-d ata" parameter to smartctl
> for it to work with libata drives.  Has this changed?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Wow, apparently it has, I just tried it here:

p34:~# smartctl -a /dev/sda | head -n 5
smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Raptor family
.. [snip] ..

p34:~# echo $?
0
p34:~#

Normally you always had to use the -d ata parameter.

Justin.
