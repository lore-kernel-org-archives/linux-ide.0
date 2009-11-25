From: Gorgone <gorgone@gmx.de>
Subject: Re: not full working ata_piix
Date: Wed, 25 Nov 2009 13:46:46 +0100
Message-ID: <1166921694.20091125134646@gmx.de>
References: <931603659.20091125091656@gmx.de> <20091125104312.76d1b986@lxorguk.ukuu.org.uk> <4B0D2013.8030901@pobox.com>
Reply-To: Gorgone <gorgone@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934483AbZKYMqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 07:46:49 -0500
In-Reply-To: <4B0D2013.8030901@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Guten Tag Jeff Garzik,

am Mittwoch, 25. November 2009 um 13:16 schrieben Sie:

> On 11/25/2009 05:43 AM, Alan Cox wrote:
>>>      00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Fa=
mily) SATA AHCI Controller (rev 01)
>>>      00:1f.2 0106: 8086:27c1 (rev 01)
>>
>> This should be handled by the AHCI driver under the SATA configurati=
on
>> options.

> Agreed/correct.  Also, CONFIG_IDE needs to be disabled.

>         Jeff

the sata ahci intel driver dont work for the 2 ide ports

if i disable CONFIG_IDE

root file system .... can not be found

http://pastebin.com/f4c78a7ad

--=20
Mit freundlichen Gr=FC=DFen
Gorgone
mailto:gorgone@gmx.de

