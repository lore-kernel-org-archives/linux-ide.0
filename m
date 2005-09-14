From: Stefan <gentoopower@yahoo.de>
Subject: Re: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 12:43:51 +0200
Message-ID: <4327FEE7.7020707@yahoo.de>
References: <43277485.6030802@yahoo.de>	 <1126690298.4248.44.camel@localhost.localdomain>	 <4327FB2C.5000207@yahoo.de> <1126694013.4248.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:65419 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932712AbVINKpg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 06:45:36 -0400
In-Reply-To: <1126694013.4248.49.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

Erik Slagter wrote:

>On Wed, 2005-09-14 at 12:27 +0200, Stefan wrote:
>  
>
>>>>When I copy files to my USB 2.0 Stick , my transferspeed are horrible in
>>>>case I mount the device with sync option, the rates are around 50KB/s,
>>>>doesn't really matter how big the files are.
>>>>If I don't mount with option sync, then the speeds are as expected a
>>>>couple of MB/s
>>>>        
>>>>
>>>Now do a complete benchmark and type "sync" after the cp command.
>>>      
>>>
>
>  
>
>>I already did that:-)
>>
>>With sync option, a test directory takes about 15min to copy.
>>Without sync option about 20s and running command sync afterwards takes
>>about 5-10s.
>>
>>So roughly 15min compared to 30s
>>    
>>
>
>The problem is that with the "sync" option the metadata on the stick has
>be written on every block write. That is not only terribly slow
>(especially on a flash device), it also wears out certain sectors.
>Compare it to using floppy's on a MS/DOS computer.
>
>Why would you _ever_ want to use the sync mount option on a flash
>device?
>  
>
Don't ask me:-)

I used to mount without sync option, but I switched to hal + dbus now
and with gentoo it automatically sets sync option in fstab :-(

Your explanation makes sense and I kind of had the same thought at
first, but also was unsure since somebody must have put it there,
therefore I'm going to check how to remove sync from those scripts that
set the mountpoint in fstab and discuss with the gentoo dev who set this up.


Thanks for your help Erik


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

