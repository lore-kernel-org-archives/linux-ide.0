From: Patric Karlsson <patric@ce.chalmers.se>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22,
   kernel panic in 2.6.23
Date: Mon, 12 Nov 2007 09:45:21 +0100
Message-ID: <fh93nq$uif$1@ger.gmane.org>
References: <6f048fc10711100443y6e9982b9jc00b3740f0a44d79@mail.gmail.com> <4737D2A3.6010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:32793 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886AbXKLIuK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Nov 2007 03:50:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IrUza-0005sn-U6
	for linux-ide@vger.kernel.org; Mon, 12 Nov 2007 08:50:02 +0000
Received: from lx32.ce.chalmers.se ([129.16.20.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 08:50:02 +0000
Received: from patric by lx32.ce.chalmers.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 08:50:02 +0000
In-Reply-To: <4737D2A3.6010103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> I Stratford wrote:
>> The purpose of the mail is to document and share my experience in the
>> hope that someone might find it useful, either for debugging their own
>> TX4 300-centric system issues or figuring out what is up with
>> sata_promise and the TX4 300 in 3Gbps mode. I also wish to offer my
>> somewhat unique promise-based system as a test environment for either
>> the timeout or kernel panic issues. I obviously have some basic need
>> for data integrity of the RAID5, but this system is not in production
>> and is therefore more available for testing purposes than the average
>> machine with 22 Promise SATA ports..  :)
> 
> [cc'ing Mikael Pettersson]
> 
> It seems those 3Gbps promise controllers have hard time getting out of
> transmission errors.  Is it because hardreset doesn't work?  Can we fix it?
> 
> Also, if 3Gbps can't be made reliable on those controllers, how about
> limiting it to 1.5Gbps by default with appropriate warning messages?
> Without PMP, it's not like we're gonna earn anything by driving the
> thing at 3Gbps.
> 
> Thanks.
> 

I thought this was supposed to be fixed in 2.6.24-RC2 ?

Although I'm currently running a TX4 myself in 3Gbit mode with 2.6.23.1, 
  I'm waiting for 2.6.24 to reach stable until I try it out myself.
2.6.23.1 seemed to fix the hard-lock when it tried to reset the card 
tho, so now I just get a few errors about "soft resetting" in the logs. 
No data loss.

/Patric

