From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Thu, 26 Jul 2012 17:36:26 +0300
Message-ID: <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
 <20120724204454.GC5167@liondog.tnic> <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com> <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39329 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab2GZOhI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2012 10:37:08 -0400
Received: by wgbdr13 with SMTP id dr13so1872826wgb.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2012 07:37:07 -0700 (PDT)
In-Reply-To: <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: linux-ide@vger.kernel.org

>> Any results on the test with the other drive?

Sorry, pressed Send button during edit.

The test results with 2 WD drives,

1. Desktop 500GB 7200 rpm WD5000AKX drive
      [good S8005GM2NR board] read speed - 127 Mb/s
      [good S8005GM2NR board] write speed - 124 Mb/s
      [bad S8005GM2NR-LE] board read spead - 127 Mb/s
      [bad S8005GM2NR-LE] board write speed - 124 Mb/s

2. Mobile 250GB 5400 rpm WD2500BEVS
      [good S8005GM2NR board] read speed - 57 Mb/s
      [good S8005GM2NR board] write speed - 55 Mb/s
      [bad S8005GM2NR-LE] board read spead - 37 Mb/s (!)
      [bad S8005GM2NR-LE] board write speed - 30 Mb/s (!)

So at least the perfomance dropped with different drive too and the drop is
nearly 20Mb/s.

I've made another test, trying to exclude the SP52100 - I've used the
external PCI SATA controller from Silicon Image Sil3112A, so the two
drives - Hitachi and WD were connected to PCI SATA board instead of
onboard SP5100, test results below :

1. Hitachi HTS725050A7E630 500GB drive
      [good S8005GM2NR board] read speed - 88 Mb/s
      [good S8005GM2NR board] write speed - 80-91 Mb/s (!)
      [bad S8005GM2NR-LE] board read spead - 35 Mb/s
      [bad S8005GM2NR-LE] board write speed - 0.9 Mb/s (!)

2. Desktop 500GB WD5000AKX drive
      [good S8005GM2NR board] read speed - 98 Mb/s
      [good S8005GM2NR board] write speed - 85 Mb/s
      [bad S8005GM2NR-LE] board read spead - 96 Mb/s
      [bad S8005GM2NR-LE] board write speed - 87 Mb/s

So the low write perfomance do not depends even from SATA controller,
but depends from the HDD and moherboard combination. Can we see (or
debug) what is happenning on bad  S8005GM2NR-LE motherboard during
write ?

-- 
Rus
