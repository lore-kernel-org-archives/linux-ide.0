From: Marc Howard Zuckman <marc@fallon.classyad.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 00:59:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801130042200.6579@classyad.com>
References: <200801051734.18088.marc@fallon.classyad.com> <478434C4.5000209@gmail.com>
 <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com>
 <Pine.LNX.4.64.0801102143150.11200@classyad.com> <4786DE62.6090604@gmail.com>
 <Pine.LNX.4.64.0801121338140.8409@classyad.com> <4789A375.9000302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c-71-205-247-245.hsd1.mi.comcast.net ([71.205.247.245]:60026
	"EHLO fallon.classyad.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbYAMF55 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 00:57:57 -0500
In-Reply-To: <4789A375.9000302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sun, 13 Jan 2008, Tejun Heo wrote:

>
> Does this change anything?  And, yeah, I really wanna see the hdparm
> --Istdout too.
>
I will apply the patch and test it as you have requested.

To be clear, the output of the hpdarm -Istdout /dev/hde command that I reported
a few minutes ago was performed with a vanilla 2.6.23.12 kernel that, as
you pointed out, was utilizing the it821x driver rather than the
pata_it821x driver.  That may be obvious to you, but I thought I should
be explicit about it.

Now, with reference to the 2.6.23.12 kernel with the unpatched version 
of the libata code, I don't
think I can do much with hdparm since the raid array does not seem to be
recognized as a device.  If my understanding is correct based on the
kernel boot messages, it seems to me that pata_it821x is going to treat
the array as a scsi block device, which on my system will configure as
/dev/sdb if the array is recognized.

Marc H. Zuckman
