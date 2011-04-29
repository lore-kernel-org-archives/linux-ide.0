From: Maciej Grela <maciej.grela@gmail.com>
Subject: Re: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Fri, 29 Apr 2011 22:57:28 +0200
Message-ID: <BANLkTimFg_=KmCRVL=QoO9s-4+T3DmbNQw@mail.gmail.com>
References: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>
	<4DBAC18A.20407@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47999 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1D2U53 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Apr 2011 16:57:29 -0400
Received: by vxi39 with SMTP id 39so3072366vxi.19
        for <linux-ide@vger.kernel.org>; Fri, 29 Apr 2011 13:57:28 -0700 (PDT)
In-Reply-To: <4DBAC18A.20407@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

2011/4/29 Mark Lord <kernel@teksavvy.com>:
> On 11-04-27 04:15 PM, Maciej Grela wrote:
>> Hi ata gurus,
>>
>> I have a 2.5'' PATA drive with security enabled and unknown password.
>> I'd like to erase that disk and use it. I've been trying to apply the
>> instructions at the libata wiki:
>> https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase but they cover
>> only the scenario in which the drive doesn't have security enabled
>> before we start the procedure. In my case this approach doesn't work
>> because I cannot set the password (step 3a):
>
> First, update your hdparm to hdparm-9.37 from sourceforge.
> Distros seem to continue to ship old versions for some weird reason,
> and there have been lots of improvements since the 2008 copy they use.
>
> Then, try this:
>
>
> hdparm --security-set-pass NULL /dev/sdx
> hdparm --security-erase NULL /dev/sdx
>

Hi,

I downloaded the newest hdparm but the result is the same - the first
command fails with "Input/output error", verbose shows:

8< --------------------------------------------------
enki@hikari:~/hdparm-9.37$ sudo ./hdparm --verbose --security-set-pass
NULL /dev
/sdb

security_password=""


/dev/sdb:
 Issuing SECURITY_SET_PASS command, password="", user=user, mode=high
oflags.lob_all=0x82, flags={ feat command }
oflags.hob_all=0x00, flags={ }
outgoing cdb:  85 0a 06 00 00 00 00 00 00 00 00 00 00 40 f1 00
outgoing_data:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 00 04 00 00 00 00 00 00 00
00 e0 51 00 00 00 00 00 00 00 00 00 00
SG_IO: desc[]:  09 0c 00 04 00 00 00 00 00 00 00 00 e0 51
      ATA_16 stat=51 err=04 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0
I/O error, ata_op=0xf1 ata_status=0x51 ata_error=0x04
SECURITY_SET_PASS: Input/output error
enki@hikari:~/hdparm-9.37$
8< --------------------------------------------------

The second command fails in a similar way:

8< --------------------------------------------------
Script started on Fri 29 Apr 2011 10:54:44 PM CEST
enki@hikari:~/hdparm-9.37$ sudo ./hdparm --verbose --security-erase
NULL /dev/sdb
security_password=""



/dev/sdb:

 Issuing SECURITY_ERASE command, password="", user=user

outgoing cdb:  85 08 0e 00 00 00 01 00 00 00 00 00 00 40 ec 00

SG_IO: ATA_16 status=0x0, host_status=0x0, driver_status=0x0

SG_IO: sb[]:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00

incoming_data:  5a 04 ff 3f 37 c8 10 00 00 00 00 00 3f 00 00 00 00 00
00 00 20 20 20 20 20 20 42 53 32 30 43 34 47 47 4d 4a 42 35 44 47 03
00 b0 3a 04 00 42 53 4f 32 37 41 48 35 69 48 61 74 68 63 20 69 54 48
35 45 31 34 38 36 4a 30 41 39 30 54 20 30 20 20 20 20 20 20 20 20 20
20 20 20 20 20 20 20 10 80 00 00 00 0f 00 40 00 02 00 02 07 00 ff 3f
10 00 3f 00 10 fc fb 00 00 01 b0 f8 50 09 00 00 07 00 03 00 78 00 78
00 f0 00 78 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 fc 00 1a 00 6b 74 e9 7f 63 41 6b 74 49 3e 63 41 3f 04 15
00 00 00 fe 40 fe ff 0b 60 fe 80 00 00 00 00 00 00 00 00 00 00 b0 f8
50 09 00 00 00 00 00 00 00 00 00 00 48 88 00 50 a5 cc e4 50 37 e6 00
00 00 00 00 00 00 00 00 00 00 00 00 00 02 40 00 40 00 00 00 00 00 00
00 00 00 00 00 00 00 00 07 00 0b 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 80 00 00 58 32 00 00 00 00 33 33 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 a5 c5

SG_IO: desc[]:  00 00

      ATA_16 stat=00 err=00 nsect=00 lbal=00 lbam=00 lbah=00 dev=00

outgoing cdb:  85 06 20 00 00 00 00 00 00 00 00 00 00 40 f3 00

SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8

SG_IO: sb[]:  72 00 00 00 00 00 00 0e 09 0c 00 00 00 00 00 00 00 00 00
00 e0 50 00 00 00 00 00 00 00 00 00 00

SG_IO: desc[]:  09 0c 00 00 00 00 00 00 00 00 00 00 e0 50

      ATA_16 stat=50 err=00 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0

oflags.lob_all=0x82, flags={ feat command }

oflags.hob_all=0x00, flags={ }

outgoing cdb:  85 0a 06 00 00 00 00 00 00 00 00 00 00 40 f4 00

outgoing_data:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00

SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8

SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 00 04 00 00 00 00 00 00 00
00 e0 51 00 00 00 00 00 00 00 00 00 00

SG_IO: desc[]:  09 0c 00 04 00 00 00 00 00 00 00 00 e0 51

      ATA_16 stat=51 err=04 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0

I/O error, ata_op=0xf4 ata_status=0x51 ata_error=0x04

SECURITY_ERASE: Input/output error

enki@hikari:~/hdparm-9.37$
8< --------------------------------------------------

Br,
Maciej Grela
