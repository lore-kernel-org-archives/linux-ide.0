From: Todd and Margo Chester <ToddAndMargo@verizon.net>
Subject: Re: no hotplugging support (FIXME)
Date: Tue, 24 Feb 2009 13:52:57 -0800
Message-ID: <49A46C39.60202@verizon.net>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
 <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com>
 <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com>
 <49A0CFFF.3050806@verizon.net> <49A0D167.9060707@gmail.com>
 <49A0D74F.1010009@verizon.net> <49A0D7F6.902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:20442 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbZBXVxN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2009 16:53:13 -0500
Received: from rn1.rent-a-nerd.local ([71.125.118.126])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFL0079XBGAB5QA@vms173001.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 24 Feb 2009 15:52:59 -0600 (CST)
In-reply-to: <49A0D7F6.902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> Todd and Margo Chester wrote:
>> Robert Hancock wrote:
>>>> p.s., just of curiosity, what would the ACHI module look
>>>> like in my modprobe.conf?
>>>
>>> You would change:
>>>
>>> alias scsi_hostadapter2 ata_piix
>>>
>>> to
>>>
>>> alias scsi_hostadapter2 ahci
>>>
>> Thank you!
>>
>> Question: would that be in addition to or a substitute
>> for?  (I am concerned that my SATA DVD/CD burner would
>> stop working.)
> 
> Normally all the ports are AHCI if it's switched into that mode, so it 
> shouldn't be an issue. However, you could leave in ata_piix as the third 
> entry, so that the system will still boot if it's not in AHCI mode 
> properly. There's no real harm in having unnecessary drivers in there..

Once I get the achi module all loaded up correctly, would
I be able to get away with

alias scsi_hostadapter2 ahci
alias scsi_hostadapter3 ata_piix

in my /etc/modprobe.conf?
