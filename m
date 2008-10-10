From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA resets via SMART selftest
Date: Fri, 10 Oct 2008 22:08:20 +0100
Message-ID: <20081010220820.4ad97574@lxorguk.ukuu.org.uk>
References: <48EFBD37.8040604@cse.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37039 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750754AbYJJVI1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 17:08:27 -0400
In-Reply-To: <48EFBD37.8040604@cse.ucdavis.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott Beardsley <scott@cse.ucdavis.edu>
Cc: linux-ide@vger.kernel.org

On Fri, 10 Oct 2008 13:38:15 -0700
Scott Beardsley <scott@cse.ucdavis.edu> wrote:

> I originally posted this to smartmontools but was redirected here.
> 
> I am running into a problem with short or long smartctl selftests 
> causing a disk reset. I'm using kernel.org v2.6.27 (I've also tried a 
> few CentOS kernels) and smartmontools v5.38 (the latest of each). When I 
> initiate a short selftest it'll run fine for a couple seconds then the 
> iowait jumps up while the disk resets. I don't think this is a disk 
> issue since I have 36 identical machines (and they all have this same 
> reproducible behavior). I also don't think it is a power problem because 
> the disks have seated correctly and the machine stays online when the 
> cpus are at 100%. The disks seem to be functioning normally because I 
> can read and write the whole disk. After I request a short selftest I 
> get this in dmesg:

The timeout set on the command expired so the kernel aborted the command
and recovered the link.

Dump the actual SG_IO command block issued and see what timeout and other
options are set.
