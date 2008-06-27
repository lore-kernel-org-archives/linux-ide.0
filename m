From: Krzysztof =?iso-8859-2?q?B=B3aszkowski?= <kb@sysmikro.com.pl>
Subject: Re: ATA_16 support on mptsas
Date: Fri, 27 Jun 2008 19:14:58 +0200
Message-ID: <200806271914.58467.kb@sysmikro.com.pl>
References: <660360F4F2570145BD872F298951B17A299A769A@cosmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v007470.home.net.pl ([212.85.125.104]:61019 "HELO
	v007470.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752565AbYF0RPD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 13:15:03 -0400
In-Reply-To: <660360F4F2570145BD872F298951B17A299A769A@cosmail03.lsi.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Moore, Eric" <Eric.Moore@lsi.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "Stewart, Ken" <Ken.Stewart@lsi.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, DL-MPT Fusion Linux <DL-MPTFusionLinux@lsi.com>

On Friday 27 June 2008 17:07, Moore, Eric wrote:
> On Friday, June 27, 2008 8:24 AM,  Krzysztof B=B3aszkowski wrote:
> > The recent firmware for e.g. SAS3442 doesn't send check
> > condition with ata
> > registers file so some commands don't work properly although
> > those commands
> > don't return drive state are delivered to drive and processed
> > by the drive.
>
> I device driver supports returning sense data, so if the target retur=
ned
> sense, it would be sent up the stack.    Here is the location of the =
SATL
> spec http://www.t10.org/ftp/t10/drafts/sat2/sat2r05.pdf, please refer=
 to
> section 11.1..   So can you provide more details on which commands ar=
e you
> expecting sense data on.    Meanwhile I will send Ken the mpt fusion
> engineering design note for SATL.


okay. i didn't know this spec so thank you for reference.

Anyway:
1. I observed that ATA_16 issued to disk through ICH6 ends up with 4 by=
tes=20
longer sense data comparing to sense data from LSI.

2. according to the spec chapter 12.2.3 if the cdb has set the CK_COND =
bit=20
then the sense data should include ATA Status Descriptor described in c=
hapter=20
12.2.5.  Seems that the recent firmware violates this requirement thus =
latest=20
hdparm (rev 8.9) signals false failure or can not evaluate right status=
=2E And=20
the hdparm sets this bit in sgio.c:sg16()

you can try e.g. CHECK POWER MODE (0xe5)

>
> Eric

Krzysztof
