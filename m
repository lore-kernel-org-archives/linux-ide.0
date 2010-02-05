From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Fri, 5 Feb 2010 09:17:05 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan>
References: <4B6C2635.105@buttersideup.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:54345 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932962Ab0BEORI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2010 09:17:08 -0500
In-Reply-To: <4B6C2635.105@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org



On Fri, 5 Feb 2010, Tim Small wrote:

> Hi,
>
> I have a couple of Debian Lenny ("2.6.26-2-amd64") boxes on rented
> hardware, each has a couple of SATA drives:
>
> One has 2x 1TB Seagate Barracuda 7200.11 model ST31000333AS firmware SD35
>
> The other has 2x 2TB WD Caviar Green model WDC WD20EADS-00R6B0 firmware
> 01.00A01
>
> ... the machines are currently set up to run smartd, and also log HDD
> temp via munin.  ata_piix is the driver in use.
>
> The WD machine did this sort of thing a couple of times, which got my
> attention.
>

I have seen people report similar problems with the following drives:

1 - Velociraptors (me/others) (don't work at all in raid correctly)
http://forums.storagereview.com/index.php/topic/27303-velociraptor-premature-failure-rate-bad-drives-premature-to-market/
2 - Green Drives (search this list, there are similar problems) in Linux.

I have Caviar Black and WD RE3, they work OK in Linux.

--

The WD Velociraptors do not work (at least in RAID).
The Green, again, search the list I recall seeing people have problems.

--

