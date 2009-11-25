From: Gorgone <gorgone@gmx.de>
Subject: Re: not full working ata_piix
Date: Wed, 25 Nov 2009 15:31:31 +0100
Message-ID: <07174312.20091125153131@gmx.de>
Reply-To: Gorgone <gorgone@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57453 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934708AbZKYObd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 09:31:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

YEA

but i dont use /dev/hdX i use uuid

menuentry "Debian GNU/Linux, linux 2.6.32-rc8-ss4200" {
        set root=3D(hd0,1)
        search --fs-uuid --set 48d61d8c-d1c2-4623-95a3-424a4002f732
        linux   /vmlinuz-2.6.32-rc8-ss4200 root=3DUUID=3Db1926063-c878-=
4713-aefc-61017c405354 ro console=3DttyS0,115200n8
        initrd  /initrd.img-2.6.32-rc8-ss4200
}

sorry if im to stupid to understand ...


> On 11/25/2009 07:46 AM, Gorgone wrote:
>> Guten Tag Jeff Garzik,

>>
>> am Mittwoch, 25. November 2009 um 13:16 schrieben Sie:
>>
>>> On 11/25/2009 05:43 AM, Alan Cox wrote:
>>>>>       00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7=
 Family) SATA AHCI Controller (rev 01)
>>>>>       00:1f.2 0106: 8086:27c1 (rev 01)
>>>>
>>>> This should be handled by the AHCI driver under the SATA configura=
tion
>>>> options.
>>
>>> Agreed/correct.  Also, CONFIG_IDE needs to be disabled.
>>
>>>          Jeff
>>
>> the sata ahci intel driver dont work for the 2 ide ports
>>
>> if i disable CONFIG_IDE
>>
>> root file system .... can not be found
>>
>> http://pastebin.com/f4c78a7ad

> The IDE driver puts devices on /dev/hdX, the newer libata driver expo=
rts
> disks at /dev/sdX

>         Jeff




--=20
Mit freundlichen Gr=FC=DFen
Gorgone
mailto:gorgone@gmx.de

