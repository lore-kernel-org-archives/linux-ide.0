From: fcp <fcp@pop.co.za>
Subject: Re: PDC202XX_OLD regression between 2.6 and 2.4
Date: Fri, 12 Mar 2004 08:26:05 -0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1079087165.2767.40.camel@server>
References: <20040311190100.GV19928@iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ctb-mesg3.saix.net ([196.25.240.75]:65482 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261979AbUCLGUa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Mar 2004 01:20:30 -0500
Received: from ckb-ip-nas-1-p247.telkom-ipnet.co.za (ckb-ip-nas-1-p247.telkom-ipnet.co.za [155.239.94.247])
	by ctb-mesg3.saix.net (Postfix) with ESMTP id 47720E053
	for <linux-ide@vger.kernel.org>; Fri, 12 Mar 2004 08:20:26 +0200 (SAST)
In-Reply-To: <20040311190100.GV19928@iwoars.net>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have several 20262 cards and the dma doesn't appear to work in 2.6 as
well. 

The system in question has an IBM EIDE drive and three Sony 48x cd
writers. With the hard drive + cdr on the first mainboard controller and
the other two cdrs on the second mainboard controller, I can use all
three cdrs at the same time but barely. One would expect performance
problems due to the configuration. This is with kernel 2.6.1.  2.6.2+
doesn't work in this configuration. Something must have changed that
affects performance.

With the cdrs each on its own 20262 controller channel it simply doesn't
work. It looks like the dma features are hardwired disabled to me as
setting the dma on doesn't do it.

L. Baker

On Thu, 2004-03-11 at 17:01, Thomas Themel wrote:
> Hi,
> 
> I'm currently trying to set up a system that contains a Promise 20267
> controller, and it seems that DMA on that controller causes problems in
> 2.6. 
> 
> My test case consists of simply creating an empty ext3 file system and
> running bonnie++ on it. In 2.4.25, this works as expected. In 2.6.3-rc4,
> however, it breaks after a few seconds:
> 
> Mar 11 17:27:19 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
> Mar 11 17:27:19 sophokles kernel: hdg: DMA timeout retry
> Mar 11 17:27:19 sophokles kernel: PDC202XX: Secondary channel reset.
> Mar 11 17:27:19 sophokles kernel: PDC202XX: Primary channel reset.
> Mar 11 17:27:19 sophokles kernel: hdg: timeout waiting for DMA
> Mar 11 17:27:40 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
> Mar 11 17:27:40 sophokles kernel: hdg: DMA timeout retry
> Mar 11 17:27:40 sophokles kernel: PDC202XX: Secondary channel reset.
> Mar 11 17:27:40 sophokles kernel: PDC202XX: Primary channel reset.
> Mar 11 17:27:40 sophokles kernel: hdg: timeout waiting for DMA
> Mar 11 17:28:02 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
> Mar 11 17:28:02 sophokles kernel: hdg: DMA timeout retry
> Mar 11 17:28:02 sophokles kernel: PDC202XX: Secondary channel reset.
> Mar 11 17:28:02 sophokles kernel: PDC202XX: Primary channel reset.
> Mar 11 17:28:02 sophokles kernel: hdg: timeout waiting for DMA
> Mar 11 17:28:22 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
> Mar 11 17:28:22 sophokles kernel: hdg: DMA timeout retry
> Mar 11 17:28:22 sophokles kernel: PDC202XX: Secondary channel reset.
> Mar 11 17:28:22 sophokles kernel: PDC202XX: Primary channel reset.
> Mar 11 17:28:22 sophokles kernel: hdg: timeout waiting for DMA
> 
> Other information:
> 
> hdparm output is slightly different between 2.4 and 2.6 (hda is an
> identical drive on a vt8233a controller on the motherboard) - 
> 
> sophokles:~# diff -Nrua 2.4.25/ 2.6.4-rc3/
> diff -Nrua 2.4.25/hda 2.6.4-rc3/hda
> --- 2.4.25/hda  2004-03-11 19:48:29.000000000 +0100
> +++ 2.6.4-rc3/hda       2004-03-11 19:52:28.000000000 +0100
> @@ -6,5 +6,5 @@
>   using_dma    =  1 (on)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
> - readahead    =  8 (on)
> - geometry     = 14593/255/63, sectors = 234441648, start = 0
> + readahead    = 256 (on)
> + geometry     = 16383/255/63, sectors = 234441648, start = 0
> diff -Nrua 2.4.25/hdg 2.6.4-rc3/hdg
> --- 2.4.25/hdg  2004-03-11 19:48:32.000000000 +0100
> +++ 2.6.4-rc3/hdg       2004-03-11 19:52:31.000000000 +0100
> @@ -6,5 +6,5 @@
>   using_dma    =  1 (on)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
> - readahead    =  8 (on)
> - geometry     = 14593/255/63, sectors = 234441648, start = 0
> + readahead    = 256 (on)
> + geometry     = 16383/255/63, sectors = 234441648, start = 0
> 
> I am a bit confused by the geometry changes, but they can hardly
> cause the problem since hda works nicely under 2.6.
> 
> Can I do anything to narrow this down, is there a way to get more
> debugging output? 
> 
> PS: Is there an archive of this mailing list somewhere?
> 
> ciao,

