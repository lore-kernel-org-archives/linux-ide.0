From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: 64 bit kernel won't mount /
Date: Wed, 21 Jan 2015 17:23:26 +0000
Message-ID: <20150121172326.040dd702@lxorguk.ukuu.org.uk>
References: <201501191145.41492.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:54057 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbbAURXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2015 12:23:34 -0500
In-Reply-To: <201501191145.41492.gheskett@wdtv.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gheskett@wdtv.com>
Cc: linux-ide@vger.kernel.org

On Mon, 19 Jan 2015 11:45:41 -0500
Gene Heskett <gheskett@wdtv.com> wrote:

> Greetings;
> 
> Amd Phenom, 8Gb of dram on an Asus M2N-SLI Deluxe board.  So old USB3 
> isn't.
> 
> Ubuntu 10.04.4 LTS 32 bit server install here.  A recent experiment with a 

Then you want to ask Ubuntu lists, nobody here can remember that far back
8) or did you mean 14.04 ?

> I have been reading up on man fstab, but it has not solved my problem of 
> the boot waiting, sometimes for 30 seconds, for the drive to be mounted at 
> / to appear.  There is no disk activity during this wait period, and it 
> does not always do it when booting a 32 bit PAE kernel.

30 seconds is about the timeout for the case when there appears to be a
drive but probing it gets no results.

> Fdisk complains that there are 3503 unallocated 512 byte sectors after 
> partition 1 on the disk, but its been doing that for 3 or 4 years.  

Doesn't matter.

Alan
