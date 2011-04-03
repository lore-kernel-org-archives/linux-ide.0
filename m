From: Borislav Petkov <bp@alien8.de>
Subject: Re: sata link speed on amd hudson
Date: Sun, 3 Apr 2011 11:29:11 +0200
Message-ID: <20110403092911.GA5998@liondog.tnic>
References: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49111 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab1DCJ3Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Apr 2011 05:29:16 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gottfried Haider <gottfried.haider@gmail.com>
Cc: linux-ide@vger.kernel.org, shane.huang@amd.com, borislav.petkov@amd.com

+ Shane

On Sun, Apr 03, 2011 at 07:04:17AM +0200, Gottfried Haider wrote:
> Dear linux-ide,
> 
> i was setting up a linux install on a brand new Lenovo x120e laptop,
> which is based on AMD's E-350 "Zacate" platform, when i realized that
> the sata link speed was only reported as being 3.0 Gbps. While as far
> as i know the particular machine has not been advertised as supporting
> 6 Gbps sata, i had expected the chipset to make use of it [1].
> 
> The controller device is a 1002:4391. I am using it with kernel
> 2.6.39-rc1 on an Intel SSD that supports 6 Gbps link speeds (as
> confirmed by hdparm). In sysfs, I read sata_spd as "3.0 Gbps" and both
> "sata_spd_limit" and "hw_sata_spd_limit" as "<unknown>".
> 
> On boot, the device comes up as:
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-8: INTEL SSDSC2MH120A2, PPG2, max UDMA/133
> ata1.00: configured for UDMA/133
> 
> Any suggestions?

Hmm, interesting. We had a similar issue already, see
http://marc.info/?t=128975810200005&r=1&w=2 and it could be that BIOS
is downgrading the sata link to save power, as Shane pointed out then.
Although in that case, it should detect a 6Gbps drive on the link and at
operate at least that link at full speed. Hmmm...

Gottfried, can you send full dmesg along with 'lspci -vvxxxx' as root
please?

Thanks.

-- 
Regards/Gruss,
    Boris.
