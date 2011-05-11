From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Wed, 11 May 2011 20:20:13 +0100
Message-ID: <20110511202013.075b07cc@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44995 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754314Ab1EKTSx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2011 15:18:53 -0400
In-Reply-To: <22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: linux-ide@vger.kernel.org

d core processor @3.20GHz) 
> OS:
> 	RHEL (Enterprise) ver5.5 x64 (2.6.18-194.el5)

Linux 2.6.18 was released in July 2006

> Test Software:
> 	Vdbench ver 5.02
> 
> These experiments were done by changing the queue depth in
> vdbench(Q=xxx).
> 
>                         |------------------------------------|
>                         | ahci   |  ahci | mtipx2xx| mtipx2xx|
>                         | Q=256  |  Q=32 |  Q=32   |  Q=256  |
> |------------------------------------------------------------|
> |4k random read (IOPS)  | 15,831 |15,763 | 244,795 | 783,778 |
> |4k random write (IOPS) |  4,058 | 4,072 |  46,696 | 135,864 |
> |128k seq. read (MBps)  |  2,284 | 2,258 |   3,295 |   3,060 |
> |128k seq. write (MBps) |  1,049 | 1,053 |   2,092 |   2,078 |
> |------------------------------------------------------------|

So a bigger queue helped (at least in 2006). The AHCI driver can be
taught your bigger queue easily enough. The question is where with a
*current* kernel are any remaining bottlenecks if you do that and how do
we fix them.

I was expecting at the very least numbers versus a modern kernel (Would
you do Windows 7 submission benchmarks against XP SP 2 ??) and profile
data to show where the bottlenecks appear to be.

Alan
