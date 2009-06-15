From: Andrea Bravetti <andreabravetti@gmail.com>
Subject: Re: NCQ blacklist
Date: Mon, 15 Jun 2009 12:19:09 +0200
Message-ID: <5cf1b7b10906150319n6bf4c9f7s399613c44df45ca7@mail.gmail.com>
References: <5cf1b7b10906141540k6336730ep93bba3d97fda7680@mail.gmail.com>
	 <20090615000104.4c65548e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:23854 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZFOKTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 06:19:08 -0400
Received: by fg-out-1718.google.com with SMTP id d23so353550fga.17
        for <linux-ide@vger.kernel.org>; Mon, 15 Jun 2009 03:19:09 -0700 (PDT)
In-Reply-To: <20090615000104.4c65548e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

I have no error messages in dmesg.

When I read large files the system become painfully slow and unresponsi=
ve.

SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA
AHCI Controller (rev 02)

root@kubra:~# hdparm -i /dev/sda

/dev/sda:

 Model=3DWDC WD3200BEVT-22ZCT0  , FwRev=3D11.01A11, SerialNo=3DWD-WXE40=
8FT4047
 Config=3D{ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGa=
pReq }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D50
 BuffType=3Dunknown, BuffSize=3D8192kB, MaxMultSect=3D16, MultSect=3D?1=
6?
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D62514=
2448
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=3Dyes: unknown setting WriteCache=3Denabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7


Now that the drive is in blacklist the whole system work much better.

hdparm -I still report NCQ as enabled and I don't know if it's a proble=
m,
but now I have:

root@kubra:~# cat /sys/block/sda/device/queue_depth
1
root@kubra:~# cat /sys/block/sda/device/queue_type
none

before:

root@kubra:~# cat /sys/block/sda/device/queue_depth
31
root@kubra:~# cat /sys/block/sda/device/queue_type
simple

I can run any type of test and collect any type of data you ask for.

sincerely,
Andrea Bravetti



On Mon, Jun 15, 2009 at 1:01 AM, Alan Cox<alan@lxorguk.ukuu.org.uk> wro=
te:
> On Mon, 15 Jun 2009 00:40:23 +0200
> Andrea Bravetti <andreabravetti@gmail.com> wrote:
>
>> Please add "WDC WD3200BEVT-22ZCT0" to the NCQ blacklist.
>>
>> I had some performance problem and I added this line:
>>
>> =A0 =A0 =A0 =A0 { "WDC WD3200BEVT-22ZCT0", NULL, ATA_HORKAGE_NONCQ }=
,
>>
>> around line 4184 of drivers/ata/libata-core.c (linux 2.6.30),
>> and now it work quite well...
>
> Which controller, what firmware revision, what sort of performance pr=
oblem
>
> Before blacklisting a drive we really need a lot more data. In paticu=
lar
> any error messages in dmesg. Ideally also two or three different syst=
ems
> seeing the same problem (so we know the drive is really the root caus=
e)
>
> Alan
>
