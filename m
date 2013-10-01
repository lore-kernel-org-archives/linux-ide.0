From: Reartes Guillermo <rtguille@gmail.com>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Tue, 1 Oct 2013 15:56:49 -0300
Message-ID: <CAPVzhpxxxgzCaXpNNHAzq7oE+D=ci6S2CpjE6RJNp3nwL6iBrA@mail.gmail.com>
References: <20130927231346.GA5662@animx.eu.org>
	<CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
	<20130928122013.GA26951@animx.eu.org>
	<CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
	<20130929031101.GD11789@animx.eu.org>
	<20130930192731.GA2703@htj.dyndns.org>
	<20131001015559.GC18206@animx.eu.org>
	<20131001143924.GC2736@htj.dyndns.org>
	<CAPVzhpwbrRg4A65hD3=-7JL3X0d18F-Way_BTKUhsHR2LmzkZQ@mail.gmail.com>
	<CAPVzhpxNezZq5JOCFzRCkyL_zxa+gKD1bT27Nqck4Di3XxrEvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:54759 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3JAS4t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2013 14:56:49 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so7617928pdj.30
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2013 11:56:49 -0700 (PDT)
In-Reply-To: <CAPVzhpxNezZq5JOCFzRCkyL_zxa+gKD1bT27Nqck4Di3XxrEvA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-ide@vger.kernel.org, Kay Sievers <kay@vrfy.org>

Hi, i uploaded a blkparse to my bugreport.

I don't get it, in addition to not knowing why the freeze happens, now
i even don't know why it does NOT freeze.
:-(

>From the uploaded blkparse:

 11,0    2       55    22.584124433  3501  G   N [ata_id]
 11,0    2       56    22.584128046  3501  I   R 512 (85 08 2e 00 00
00 01 00 00 00 00 00 00 00 a1 00 ..) [ata_id]
 11,0    2       57    22.584128772  3501  D   R 512 (85 08 2e 00 00
00 01 00 00 00 00 00 00 00 a1 00 ..) [ata_id]
 11,0    2       58    22.584140609    18  C   R (85 08 2e 00 00 00 01
00 00 00 00 00 00 00 a1 00 ..) [0]

  #0:   85h, COMMAND >>>>> ATA PASS-THROUGH(16) but Why ???
        (libata.atapi_passthru16=0 was set, shout it have been '1Ah'
ATA_PASS-THROUGH(12) instead? and why no freeze??)

  #1:   08, MULTIPLE_COUNT | PROTOCOL | EXTEND
  #2:   2e, OFF_LINE | CK_COND | RESERVED | T_DIR | BYT_BLOK | T_LENGHT
  #3:   00, FEATURES (8:15)
  #4:   00, FEATURES (0:7)
  #5:   00, RESERVED / SECTOR_COUNT (8:15)
  #6:   01, SECTOR_COUNT (0:7)
  #7:   00, RESERVED /LBA_LOW (8:15)
  #8:   00, LBA_LOW (0:7)
  #9:   00, RESERVED /LBA_MID (8:15)
  #10:  00, LBA_MID (0:7)
  #11:  00, RESERVED /LBA_HIGH (8:15)
  #12:  00, LBA_HIGH (0:7)
  #13:  00, DEVICE

  #14:  a1, COMMAND >>>>> A1h is IDENTIFY_PACKET_DEVICE
        (i hope... should i?, ?? A1h is both IDENTIFY_PACKET_DEVICE
and ATA PASS-THROUGH(12) ?? )

  #15:  00, CONTROL


I also performed the test on System #2 (without
'libata.atapi_passthru16=0' tand the blkparse output looks similar:

 11,0    1       86    27.195169571 10620  I   R 512 (85 08 2e 00 00
00 01 00 00 00 00 00 00 00 a1 00 ..) [ata_id]
 11,0    1       87    27.195170554 10620  D   R 512 (85 08 2e 00 00
00 01 00 00 00 00 00 00 00 a1 00 ..) [ata_id]
 [...TRUNCATED...]
 11,0    1       88    27.196006926 10613  C   R (85 08 2e 00 00 00 01
00 00 00 00 00 00 00 a1 00 ..) [2]

With the execption of the "[2]" instedd of "[0]". And there was no
logged error on System #2.

Cheers.

On Tue, Oct 1, 2013 at 1:08 PM, Reartes Guillermo <rtguille@gmail.com> wrote:
> Additional Info:
>
> On System #1 (the affected one), when using the workaround
> 'libata.atapi_passthru16=0'  the system dos NOT freeze or hang
> (already known) but i am getting this:
>
> Oct 01 12:58:51 ulquiorra.espada udisksd[2132]: Error probing device:
> Error sending ATA command IDENTIFY PACKET DEVICE to /dev/sr0:
> Unexpected sense data returned:
>
> udisks output during the test:
>
> # udisksctl monitor
> Monitoring the udisks daemon. Press Ctrl+C to exit.
> 12:58:33.417: The udisks-daemon is running (name-owner :1.47).
>
> 12:58:51.765: /org/freedesktop/UDisks2/drives/ATAPI___iHBS112___2_2512014_216134501013:
> org.freedesktop.UDisks2.Drive: Properties Changed
>   TimeMediaDetected:            1380643131761935
>   OpticalNumTracks:             1
>   OpticalNumSessions:           1
>   OpticalBlank:                 true
>   Optical:                      true
>   Media:                        optical_bd_r
>   MediaAvailable:               true
>   Size:                         2048
> 12:58:51.766: /org/freedesktop/UDisks2/block_devices/sr0:
> org.freedesktop.UDisks2.Block: Properties Changed
>   Size:                 2048
>
> If i were to believe the clock (should i?) then the error in the
> messages logfile happens after the udisks output...
>
> Cheers.
