From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 04 Mar 2008 12:28:06 +0900
Message-ID: <47CCC1C6.5010600@gmail.com>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh> <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org> <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com> <20080304002215.GA13317@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.235]:11325 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757952AbYCDD2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 22:28:14 -0500
Received: by qb-out-0506.google.com with SMTP id o24so2962412qba.1
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2008 19:28:13 -0800 (PST)
In-Reply-To: <20080304002215.GA13317@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

Hello, Denys.

Denys Dmytriyenko wrote:
>>> I tried replacing the PSU and also run the system with two 650W PSU-s,
>>> also failed. I also think that PSU shouldn't be the problem as I see they
>>> eat much less in operation than at spinup.
>> It's not that simple tho.  Some PSUs which happily spin up all the
>> drives simultaneously have problems maintaining stable operation
>> afterwards.  Anyways, if you used two separate PSUs, and didn't see any
>> change in failure pattern (ie. drives connected to certain PSU fails or
>> swapping to which PSU the board is connected alleviates the problem),
>> it's probably safe to say it's not PSU problem.
> 
> Gabor,
> 
> I am pretty much convinced at this point that my exceptions/resetting
> problem is due to the PSU. I've been testing different configurations
> lately and was able to get stable system powering 14 (!) drives by both
> PSUs together. The limiting factor is Amps on a single +12V rail:
> Coolermaster 750 limits single rail to 19A (6 drives @ 2.8A/drive) and
> my old Enermax 550 has 24A limit (8 drives @ 2.8A/drive). Even though
> Coolermaster 750 has 4 rails, the wiring is not optimal and only 1 rail
> is available for the hard drives...
> 
> See item #8 here:
> http://www.pcpower.com/technology/myths/

Ah... yeah, that's what I've been saying all along.  Fancy powers w/
multiple 12v rails suck for storage array.  My 15$ no name single lane
PSU works much better than 40$ dual lane one.

Another interesting test to perform is to test drive hotplugging while
all other drives are running.  Good PSU should be able to hold the
voltage and all other drives won't be affected but many PSUs fail to
hold the 12v voltage and other drives sharing lane looses power briefly
causing PHY events and brief spin downs (clicking sound) which usually
result in loss of data in write buffer.  Again, on my test setup, the
$15 no name single lane one is most stable.

If anyone has some contacts to sites which perform PSU benchmarking, I
would love to see PSUs tested for disk hotplugging which is a common
operation nowadays and can cause serious file system failure if PSU
isn't adequate.

> I am going to try their single-rail Silencer 750, rated at 60A.
> 
> That said, I'm still puzzled with the low write performance issue.
> 
> Tejun,
> 
> As one of the Gurus on this list, can you suggest any tweaks/settings
> to try out to improve/resolve my 17 MB/s write speed limit?
> 
> I played with different PCI latencies, read FAQ topic on 32-bit
> I/O support in libata and ran out of ideas... Please help :)

How did you test?  W/ dd?  hdparm?

-- 
tejun
