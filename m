From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: very slow write to AHCI device
Date: Mon, 07 May 2012 20:10:17 +0200
Message-ID: <4FA81009.1030308@fold.natur.cuni.cz>
References: <4FA7F563.4040708@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:46047 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754540Ab2EGSHR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2012 14:07:17 -0400
In-Reply-To: <4FA7F563.4040708@pocock.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
Cc: linux-ide@vger.kernel.org

Hi Daniel,

Daniel Pocock wrote:
> 
> 
> Hi,
> 
> I'm testing a problem with the following combination:
> - SB700/SB800 type controller in AHCI mode (in a HP Microserver N36L)
> - Seagate Barracuda 1TB 7k2 drive with NCQ

Is that a disk with 4k hardware sectors (Advanced Format)? Where does
you partition start? At sector 63 or 2048? ;-)

> 
> I've got a fresh 256MB partition, formatted ext4, mounted
> barrier=1,data=ordered, write-cache enabled (hdparm -W 1 /dev/sdb) and
> shared over NFS.
> 
> When the NFS client writes,
> - unpacking a source tarball, many small files, iostat reports speeds
> under 500kBytes/sec
> - dd conv=fsync, iostat reports about 50MB/sec
> 
> If I set up a USB disk on the same box, with a partition formatted
> exactly the same way, the iostat reports the write speed (unpacking the
> same tarball) is over 5MBytes/sec - not so fast, but 10 times faster
> than the AHCI device.

So USB is at speed 10 times less, right?

Martin
