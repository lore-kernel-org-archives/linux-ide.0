From: Reartes Guillermo <rtguille@gmail.com>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Tue, 1 Oct 2013 13:08:33 -0300
Message-ID: <CAPVzhpxNezZq5JOCFzRCkyL_zxa+gKD1bT27Nqck4Di3XxrEvA@mail.gmail.com>
References: <20130927231346.GA5662@animx.eu.org>
	<CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
	<20130928122013.GA26951@animx.eu.org>
	<CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
	<20130929031101.GD11789@animx.eu.org>
	<20130930192731.GA2703@htj.dyndns.org>
	<20131001015559.GC18206@animx.eu.org>
	<20131001143924.GC2736@htj.dyndns.org>
	<CAPVzhpwbrRg4A65hD3=-7JL3X0d18F-Way_BTKUhsHR2LmzkZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43555 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3JAQId (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2013 12:08:33 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so7354353pbc.15
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2013 09:08:33 -0700 (PDT)
In-Reply-To: <CAPVzhpwbrRg4A65hD3=-7JL3X0d18F-Way_BTKUhsHR2LmzkZQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-ide@vger.kernel.org, Kay Sievers <kay@vrfy.org>

Additional Info:

On System #1 (the affected one), when using the workaround
'libata.atapi_passthru16=0'  the system dos NOT freeze or hang
(already known) but i am getting this:

Oct 01 12:58:51 ulquiorra.espada udisksd[2132]: Error probing device:
Error sending ATA command IDENTIFY PACKET DEVICE to /dev/sr0:
Unexpected sense data returned:

udisks output during the test:

# udisksctl monitor
Monitoring the udisks daemon. Press Ctrl+C to exit.
12:58:33.417: The udisks-daemon is running (name-owner :1.47).

12:58:51.765: /org/freedesktop/UDisks2/drives/ATAPI___iHBS112___2_2512014_216134501013:
org.freedesktop.UDisks2.Drive: Properties Changed
  TimeMediaDetected:            1380643131761935
  OpticalNumTracks:             1
  OpticalNumSessions:           1
  OpticalBlank:                 true
  Optical:                      true
  Media:                        optical_bd_r
  MediaAvailable:               true
  Size:                         2048
12:58:51.766: /org/freedesktop/UDisks2/block_devices/sr0:
org.freedesktop.UDisks2.Block: Properties Changed
  Size:                 2048

If i were to believe the clock (should i?) then the error in the
messages logfile happens after the udisks output...

Cheers.
