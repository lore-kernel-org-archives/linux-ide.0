From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Drive failure and ASUS
Date: Sat, 22 Nov 2008 19:35:39 -0600
Message-ID: <4928B36B.5030005@shaw.ca>
References: <200811220901.33596.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:34809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbYKWBfv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 20:35:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L43t6-00011n-QS
	for linux-ide@vger.kernel.org; Sun, 23 Nov 2008 01:35:48 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 01:35:48 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 01:35:48 +0000
In-Reply-To: <200811220901.33596.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> The only way I can get this box to boot is to disconnect the data cable on a 
> drive with 121 badblocks as somehow ASUS and JMicron-pata all seem to think 
> its /dev/sda when hooked up, and it is no longer bootable.  I'm presently 
> booted from a sata drive on that interface, which this ASUS board has about 8 
> of.

The bad disk is PATA?

> 
> So I've booted with the data cable off, and hooked it up once booted.  Unforch 
> there seems to be no discovery of its presence.
> 
> No /dev/sdd stuff was created when I plugged the data cable into the drive.
> 
> The install is the August 2008 F8 respin and is uptodate.
> 
> How can I make the system aware that it is now there?  It has about 40 Gb of 
> data I'd like to recover if I can.

Hotplug isn't supported with PATA, so you shouldn't really try that. 
Fedora installs usually use labels for the disk partitions, so it 
shouldn't matter what device node the disk gets detected as?

