From: kenneth johansson <ken@kenjo.org>
Subject: Re: ahci problems with sata disk.
Date: Tue, 16 Jan 2007 02:43:47 +0100
Message-ID: <1168911827.7718.4.camel@duo>
References: <1168785128.7865.13.camel@duo>  <45AB45B2.2080602@gmail.com>
	 <1168859112.6980.8.camel@duo>  <45AB86C0.2020507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:2811 "EHLO
	garbo.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbXAPBnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 20:43:53 -0500
In-Reply-To: <45AB86C0.2020507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2007-01-15 at 22:50 +0900, Tejun Heo wrote:
> kenneth johansson wrote:
> > On Mon, 2007-01-15 at 18:13 +0900, Tejun Heo wrote:
> >> kenneth johansson wrote:
> >>> I changed my bios setting for SATA from IDE to AHCI.
> >>>
> >>> This resulted in some "interesting" read throughput. 
> >>>
> >>> plots can be found at http://kenjo.org/~ken/sata/
> >>> The plots was done on a live disk so some noise is expected but in the
> >>> ahci mode the throughput get stuck at 17 MB way to much.
> >> It's probably not an ahci problem but more of NCQ implementation problem
> >> in the drive firmware.  Please report the result of 'hdparm -I /dev/sdX'
> >> and try adjust queue depth and see what happens.
> >>
> >> http://linux-ata.org/faq.html
> >>
> > 
> > It was, when I turn of NCQ with "echo 1
> >> /sys/block/sda/device/queue_depth" I get the same performance as when
> > the BIOS is set to IDE.
> 
> Can you play with queue depth a bit?  e.g. Benchmark queue depth of 4, 8
> and 16.

I did some more test "http://kenjo.org/~ken/sata/" and queue 1 and maybe
2 works  but everything larger than that has problems. 



