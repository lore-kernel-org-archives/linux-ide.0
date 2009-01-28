From: Dmitry Gryazin <gdu@mns.spb.ru>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 3)
Date: Wed, 28 Jan 2009 10:51:34 +0300
Message-ID: <200901281051.35030.gdu@mns.spb.ru>
References: <200901271619.53025.sshtylyov@ru.mvista.com> <497F2EAD.4080705@rtr.ca> <497F3366.5020608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mnsspb.ru ([84.204.75.2]:47036 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbZA1H5T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jan 2009 02:57:19 -0500
In-Reply-To: <497F3366.5020608@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, navy-patches@mns.spb.ru

On Tuesday 27 January 2009 07:16:38 pm Sergei Shtylyov wrote:
> Mark Lord wrote:
> >>> When checking for the CFA feature set support, ata_id_is_cfa() tests
> >>> bit 2 in
> >>> word 82 of the identify data instead the word 83;  it also checks the
> >>> ATA/PI
> >>> version support in the word 80 (which the CompactFlash specifications
> >>> have as
> >>> reserved), this having no slightest chance to work on the modern CF
> >>> cards that
> >>> don't have 0x848A in the word 0...
> >>>
> >>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>
> >> Acked-by: Alan Cox <number6@the-village.bc.nu>
> >
> > ..
> >
> > Any chance you two could figure out this one below?
> > It *is* a CF card, but doesn't show up as such.
> >
> > /dev/sda:
> >
> > 044a 3fff 0000 000f 0000 0240 003f 03bc
> > 0000 0000 5052 4554 4543 2020 2020 2020
> > 3031 3233 3541 4545 0002 0002 0004 3230
> > 3038 3038 3035 4346 2020 2020 2020 2020
> > 2020 2020 2020 2020 2020 2020 2020 2020
> > 2020 2020 2020 2020 2020 2020 2020 8001
> > 0000 0300 0000 0200 0000 0007 3fff 000f
> > 003f 3c4f 00ec 0100 0000 03bc 0000 0007
> > 0003 0078 0078 0078 0078 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0010 0000 700b 400c 4003 0001 0000 0003
>
> ATA device, with non-removable media
>          Model Number:       CF
>          Serial Number:      PRETEC      01235AEE
>          Firmware Revision:  20080805
> Standards:
>          Supported: 4
>          Likely used: 6

My Kingston CF reports:
	Model Number:		CF CARD 1GB
	Serial Number:		CF1GB 00004DCA
	Firmware Revision:	20070709

>     Here's what I was afraid of: it does report the ATA revision in word
> 80. Otherwise, it seems pretty standard modern CF. What are we to do now,
> Alan?
>
> > 207f 0001 0000 0000 fffe 600f 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0009 0000 0000 0000 0000 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 0000 0000 0000 0000 0000 0000 0000 0000
> > 81f4 0000 0000 0092 001b 0000 0000 0000
>
>     Here are the words 160-167.; word 163 reports PIO6 and MWDMA3 max, PIO6
> selected...
>
> MBR, Sergei

Here is my Kingston CF Card:

044a 078e 0000 0010 0000 0240 003f 001d
bf20 0000 4643 4731 2042 3030 3030 4434
4143 0000 0000 0000 0002 0002 0004 3032
3730 3730 3930 4643 4320 5241 2044 4731
0042 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 8001
0000 0300 0000 0200 0000 0003 078e 0010
003f bf20 001d 0100 bf20 001d 0000 0407
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0001 0000 0002 0001 0000 0002
0000 0000 0000 0000 0000 400f 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
81f4 0000 0000 0492 001b 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

May be we should rely on "CF" in "Model number". This would not cover 
all CF cards, but could catch some modern. But anyway we have to collect more 
different CF cards statistic first.

Regards, Dmitry Gryazin.
