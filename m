From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: Faulty drive data recovery
Date: Wed, 24 Nov 2010 22:03:54 +0600
Message-ID: <4CED376A.40502@ngs.ru>
References: <4CED1B5F.8000700@dpf.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout10.ngs.ru ([195.93.186.216]:56764 "EHLO smtpout.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab0KXQEI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Nov 2010 11:04:08 -0500
In-Reply-To: <4CED1B5F.8000700@dpf.gov.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atila <atila.alr@dpf.gov.br>
Cc: linux-ide@vger.kernel.org

  find /sys/devices -name timeout

/sys/devices/pci0000:00/0000:00:1f.1/host0/target0:0:0/0:0:0:0/timeout
/sys/devices/pci0000:00/0000:00:1f.2/host2/target2:0:0/2:0:0:0/timeout
/sys/devices/pci0000:00/0000:00:1f.2/host3/target3:0:0/3:0:0:0/timeout

As I remember, some time ago somewhere in the sources was hardcoded 3 r=
etries.

24.11.2010 20:04, Atila =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> HI, I'm trying to recover data from a damaged hard disk, which has
> plenty of bad sectors, but also has many good ones. The problem is th=
at
> when a bad sector is found, the drive keeps trying to read it, instea=
d
> of giving up and just move on, so the average data read rate is aroun=
d
> 5Kb/s. With such rates, it will take more than an year to finish. Sin=
ce
> I'm using gnu ddrescue (which logs bad sectors, so one can try then
> again later), my goal is not waste time with errors, leaving the retr=
ies
> to a second round.
> So, my first attempt was to drastically lower the timeouts in
> libata-eh.c. It seems to have improved a little, but I'm not having m=
ore
> than 12Kb/s.
> Is there any way to minimize retries and make errors finish faster?
>
> Atila Romero
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

