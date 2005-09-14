From: Lionel Bouton <lionel-subscription@bouton.name>
Subject: Re: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 14:45:18 +0200
Message-ID: <43281B5E.2090702@bouton.name>
References: <43277485.6030802@yahoo.de>	 <1126690298.4248.44.camel@localhost.localdomain>	 <4327FB2C.5000207@yahoo.de> <1126694013.4248.49.camel@localhost.localdomain> <4327FEE7.7020707@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.bouton.name ([70.85.16.101]:14093 "EHLO mail.bouton.name")
	by vger.kernel.org with ESMTP id S965150AbVINMpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2005 08:45:32 -0400
In-Reply-To: <4327FEE7.7020707@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

Stefan wrote the following on 14.09.2005 12:43 :

>Erik Slagter wrote:
>  
>
>>
>>Why would you _ever_ want to use the sync mount option on a flash
>>device?
>> 
>>
>>    
>>
>Don't ask me:-)
>
>I used to mount without sync option, but I switched to hal + dbus now
>and with gentoo it automatically sets sync option in fstab :-(
>  
>

This is purely a PBKAK :
users want to remove the device as soon as they get feedback from their 
UI telling them that their transfer is done (in fact they even screw up 
and remove the device before it is done). sync in fstab isn't 
particularly clever, but sync with automount is more useful : when 
properly configured, as soon as the transfer is done the automounter can 
cleanly umount the block device which is nearly instantaneous when sync 
is used. Without sync there can be some awfully long delays with flash 
and huge caches (on a 512M slow SD, I saw 30+ seconds after transfering 
10s or 100s of MB).

This is understandable, for all the removable devices without a clean 
"eject" and VFAT formatted, using sync is probably the best safeguard 
against badly screwed up filesystems.

Lionel.
