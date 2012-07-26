From: Borislav Petkov <bp@amd64.org>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Thu, 26 Jul 2012 12:04:40 +0200
Message-ID: <20120726100440.GB30717@aftab.osrc.amd.com>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
 <20120724204454.GC5167@liondog.tnic>
 <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from osrc3.amd.com ([217.9.48.20]:40086 "EHLO mail.x86-64.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab2GZKL7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2012 06:11:59 -0400
Content-Disposition: inline
In-Reply-To: <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <brushkoff@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jul 25, 2012 at 09:47:16AM +0300, Rus V. Brushkoff wrote:
>  I will do the tests with another drive (from WD) today. But I've
> fogot to say that I have another S8005 m/b with SP5100 that working
> perfectly with these particular Hitachi drives (please see boot log
> for it in dmesg-good at the same URL). So the problem can be in init
> procedure for AMD south bridge or SATA controller. The differences
> between m/b is very little - working has onboard audio, not working
> hasn't. The diff in boot log is present too in file diff.txt

One other thing you could try: can you downgrade the BIOS on one of the
bad Tyan boards (the -LE ones, right?) and retry the test again?

Any results on the test with the other drive?

Thanks.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
