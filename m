From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
	Cougar Point DeviceIDs
Date: Wed, 13 Jan 2010 18:11:43 -0600
Message-ID: <51f3faa71001131611y343ad225n1acc73900fd49894@mail.gmail.com>
References: <201001121700.18234.seth.heasley@intel.com>
	 <4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.223.194]:60217 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab0ANALo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2010 19:11:44 -0500
In-Reply-To: <4B4DAA68.60608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 13, 2010 at 5:11 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
>> Likely a lot of the existing specific PCI IDs could be removed from =
the
>> driver because of this (many likely predate the addition of the
>> class-based catch-all). The only reason to need a specific entry if =
the
>> device uses AHCI class is if it needs special handling or workaround=
s,
>> which isn't the case here.
>
> Well, two lines of thinking here:
>
> * some of lines of Intel chips do not separate AHCI into a separate P=
CI ID
> rather legacy IDE interface. =A0When an AHCI interface exists and AHC=
I/IDE
> share the same PCI ID, we default to using AHCI. =A0Thus, some of tho=
se PCI ID
> matches in ahci.c's PCI table may not get caught by the generic PCI c=
lass
> match at the end of the table.

Well, ata_piix does have a couple of entries that are listed in ahci
as well, for ICH6 device IDs 0x2652 and 0x2653. For 0x2653 ata_piix
checks the class code to make sure it's IDE, but for the 0x2652 entry,
and in both cases in ahci, the class code isn't checked. Deleting the
specific entries from ahci for those controllers would seemingly
actually improve the situation, since then ahci wouldn't try and
attach to those devices when they indicate IDE class. ata_piix should
also should be checking for IDE class on 0x2652 as well.
