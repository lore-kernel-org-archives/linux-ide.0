From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Wed, 07 Jan 2009 20:04:33 +0900
Message-ID: <49648C41.6030002@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis>	<494EDDBE.3010306@shaw.ca>	<494F65C1.80602@kernel.org>	<1229947998.6045.10.camel@Thutmosis>	<49505500.8080409@kernel.org>	<1230126055.6430.17.camel@Thutmosis>	<495886E7.7050204@kernel.org>	<1230586376.11130.46.camel@Thutmosis>	<1231282276.6376.13.camel@Thutmosis>	<49640CE1.6070808@kernel.org>	<20090107094043.580f5bf7@lxorguk.ukuu.org.uk>	<496483A5.6020105@kernel.org> <20090107105339.289f47a4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59062 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbZAGLEy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2009 06:04:54 -0500
In-Reply-To: <20090107105339.289f47a4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Sorry you can't just blindly do this because some of the controllers snoop
>>> the SETXFER command to set their timings and whether they expect DMA. Also
>>> we've no idea if this is a bug in a specific firmware revision, a quirky
>>> pata/sata bridge or a timing problem of some sort.
>> I think it'll generally be okay for SATA unless it's bridged over to
>> PATA controller.  Any other ideas?
> 
> We seem to have one report, from one user, with one configuration, on one
> controller, using one firmware set.

There are two more reports linked from the thread.

  http://ubuntuforums.org/showthread.php?t=986871
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/299865

And all of them are showing the same problem.  This being a slim SATA
drive for a laptop, I don't really expect to see the drive in varied
configurations.  The problem might as well be limited to certain OEM
drive(s).

> That to me isn't meaningful evidence of anything that needs a workaround,
> beyond maybe doing what old IDE does and if a setxfer times out
> continuing in hope.

So, as far as the validity of the report goes, I think it's at
reasonable level.  Add to that my general trigger happiness toward
quirks and the machine is a VAIO and to me quirking it doesn't seem
too careless.

> (We should of course then re-read the identify pages and check the mode
> in use)

Of course, whether the workaround is proper is a completely separate
issue but unless other devices with the same problem creep up and the
device is happy with the quirk, I don't really think we should modify
the default configuration sequence for devices like this.

That said, Moritz, can you please post the output of "hdparm -I" with
and without the quirk applied?  And can you please use a preoper mail
address?

Thanks.

-- 
tejun
