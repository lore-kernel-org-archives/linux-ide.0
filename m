From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Subject: Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 15:24:32 +0200
Message-ID: <444F7490.3030800@labri.fr>
References: <444E5620.50404@atipa.com> <444F72C8.4060401@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:26551 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932419AbWDZN2H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Apr 2006 09:28:07 -0400
In-Reply-To: <444F72C8.4060401@atipa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: linux-ide@vger.kernel.org

Hi,

Roger Heflin wrote:
>>
>> ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
>> ata1: status=3D0x50 { DriveReady SeekComplete }
>> sda: Current: sense key: No Sense
>>     Additional sense: No additional sense information
>> Info fld=3D0x3481ff
>> ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
>> ata2: status=3D0x50 { DriveReady SeekComplete }
>> sdb: Current: sense key: No Sense
>>     Additional sense: No additional sense information
>> Info fld=3D0x166ff
>> ata1: command 0xc8 timeout, stat 0x50 host_stat 0x24
>> ata1: status=3D0x50 { DriveReady SeekComplete }
>> sda: Current: sense key: No Sense
>>     Additional sense: No additional sense information
>> Info fld=3D0x3482ff
>> ata2: command 0xc8 timeout, stat 0x50 host_stat 0x24
>> ata2: status=3D0x50 { DriveReady SeekComplete }
>> sdb: Current: sense key: No Sense
>>     Additional sense: No additional sense information
>> Info fld=3D0x167ff
>> ata1: command 0xca timeout, stat 0x50 host_stat 0x24
>> ata1: status=3D0x50 { DriveReady SeekComplete }

Can you try to set the following config options as module:

Device Drivers  --->
  SCSI device support  --->
    SCSI low-level drivers  --->
      AHCI SATA support

And

Device Drivers  --->
  SCSI device support  --->
    SCSI low-level drivers  --->
      NVIDIA SATA support

Regards
--=20
Emmanuel Fleury              | Office: 211
Associate Professor,         | Phone: +33 (0)5 40 00 35 24
LaBRI, Domaine Universitaire | Fax:   +33 (0)5 40 00 66 69
351, Cours de la Lib=E9ration  | email: emmanuel.fleury@labri.fr
33405 Talence Cedex, France  | URL: http://www.labri.fr/~fleury
