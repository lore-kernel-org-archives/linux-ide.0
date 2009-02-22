From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: no hotplugging support (FIXME)
Date: Sat, 21 Feb 2009 22:43:34 -0600
Message-ID: <49A0D7F6.902@gmail.com>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org> <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com> <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com> <49A0CFFF.3050806@verizon.net> <49A0D167.9060707@gmail.com> <49A0D74F.1010009@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:4899 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZBVEni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Feb 2009 23:43:38 -0500
Received: by yw-out-2324.google.com with SMTP id 5so611886ywh.1
        for <linux-ide@vger.kernel.org>; Sat, 21 Feb 2009 20:43:36 -0800 (PST)
In-Reply-To: <49A0D74F.1010009@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd and Margo Chester <ToddAndMargo@verizon.net>
Cc: linux-ide@vger.kernel.org

Todd and Margo Chester wrote:
> Robert Hancock wrote:
>>> p.s., just of curiosity, what would the ACHI module look
>>> like in my modprobe.conf?
>>
>> You would change:
>>
>> alias scsi_hostadapter2 ata_piix
>>
>> to
>>
>> alias scsi_hostadapter2 ahci
>>
> Thank you!
> 
> Question: would that be in addition to or a substitute
> for?  (I am concerned that my SATA DVD/CD burner would
> stop working.)

Normally all the ports are AHCI if it's switched into that mode, so it 
shouldn't be an issue. However, you could leave in ata_piix as the third 
entry, so that the system will still boot if it's not in AHCI mode 
properly. There's no real harm in having unnecessary drivers in there..

> 
> Also, I downloaded the recent manual for my motherboard.
> The section has a new option not on my BIOS (1.2a)
> called "SATA ACHI Mode: on|off".  The current BIOS is
> 2.1a -- I think it is time I ordered a new BIOS chip
> (I don't flash.  I remove and replace the chip.  That way
> I can go back if things go wrong, which has happened to
> me before.)
> 
> Many thanks,
> -T

