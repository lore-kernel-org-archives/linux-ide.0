From: Asdo <asdo@shiftmail.org>
Subject: Re: How to reread disk size?
Date: Tue, 23 Feb 2010 19:05:43 +0100
Message-ID: <4B8418F7.2070800@shiftmail.org>
References: <4B7F234F.9000107@shiftmail.org> <4B802BDF.9020509@gmail.com>
 <4B805487.2010900@shiftmail.org> <1266736938.4414.9.camel@mulgrave.site>
 <4B814B26.5020501@shiftmail.org>
 <51f3faa71002210910s484c8e4i975ebf2314287d66@mail.gmail.com>
 <4B81D699.704@shiftmail.org> <1266843472.4414.23.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blade3.isti.cnr.it ([194.119.192.19]:50157 "EHLO
	BLADE3.ISTI.CNR.IT" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0BWSGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 13:06:48 -0500
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5-b2 #31825) id <01NK0GWI2GN4BF6VBQ@mx.isti.cnr.it> for
 linux-ide@vger.kernel.org; Tue, 23 Feb 2010 19:05:43 +0100
In-reply-to: <1266843472.4414.23.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

James Bottomley wrote:
> On Mon, 2010-02-22 at 01:58 +0100, Asdo wrote:
>   
>> Robert Hancock wrote:
>>     
>>> ata_piix doesn't have a way to get automatically notified that the
>>> disk has been hotplugged since the chipset doesn't support it in this
>>> mode. (The ideal solution would be to switch the controller into AHCI
>>> mode, but I don't know if that's possible on that chipset and BIOS.)
>>>
>>> I think there are some ways to get the code to recheck the disk
>>> however.. you can try echoing something into the "rescan" sysfs file
>>> under /sys that matches your device (do a "find /sys/ -name
>>> scsi_level" to see what directories they're in, the rescan file is in
>>> the same directory).
>>>   
>>>       
>> Thanks for the hint
>> It doesn't work unfortunately.
>> Echoing something into rescan makes it output (in dmesg) basically the 
>> same message that comes out with blockdev --rereadpt /dev/sdr. The size 
>> is still detected wrong. Catting "model" also turns out that the old 
>> brand of disk still being detected. smartctl -a does show the new disk :-)
>> I tried to write "1" in evt_media_change but it's permission denied :-)
>>     
>
> Right.  libata caches the value from the moment it scans the device.
> You might be able to alter it by having the device destroyed and
> recreated ... that would be echoing 1 to the delete under the scsi
> device sysfs node and then echoing '- - -' to the host rescan parameter.
> If that doesn't work, libata will need to be fixed somehow because that
> would mean it isn't slaving it's device lifetimes to the SCSI model.
>   

Great, it works! Thank you

root@mynode:/sys# echo 1 > 
/sys/devices/pci0000:00/0000:00:1f.2/host3/target3:0:1/3:0:1:0/delete

and then

echo "- - -" > /sys/class/scsi_host/host3/scan

recreated the device with 1TB size!

Acually then I tried to swap disks again and just give the
  echo "- - -" > /sys/class/scsi_host/host3/scan
and it worked already. So deleting the device was not needed.
However the "rescan" in the same directory of scsi_level you suggested 
in previous post did not work. This "scan" in scsi_host is more powerful :-D

Thank you

