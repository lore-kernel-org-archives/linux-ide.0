From: John Sigler <linux.kernel@free.fr>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
Date: Fri, 31 Aug 2007 10:41:26 +0200
Message-ID: <46D7D436.8050705@free.fr>
References: <46D59ED2.4000900@free.fr>	 <20070829174657.09c7de3c@the-village.bc.nu> <46D67D09.6090101@free.fr>	 <46D69E03.9080403@vc.cvut.cz> <46D6B85C.5050509@free.fr>	 <46D6DDF6.6080400@free.fr> <311601c90708301534g47b2bca7t77debde058781572@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:43183 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbXHaIlx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 04:41:53 -0400
In-Reply-To: <311601c90708301534g47b2bca7t77debde058781572@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Eric wrote:

> John Sigler wrote:
>
>> According to my supplier, herre is the data sheet for the DOMs:
>> http://www.pqimemory.com/documents/domdata.pdf
>>
>> PIO mode 2 is mentioned. Even DMA seems to be supported.
>> Or am I mistaken?
> 
> Page 3 states max interface burst speed is 8.3MB/s in PIO2.  I
> wouldn't assume it supports DMA

The reason I suspected DMA support is because I noticed the description 
of DMACK- (DMA acknowledge) and DMARQ (DMA request).

> Based on the quoted media transfer rates (1.2MB/s write and 4.1MB/s
> read), DMA would buy you a transfer checksum but probably not much
> performance, unless your embedded application is CPU bound.

What I fear is that programmed I/O will tie up the CPU and add 
non-deterministic latency to my real-time apps.

Suppose that an app is waiting for an acknowledgement from a PCI device 
when the OS suddenly decides it is time to write 4 KB to disk. Typical 
write rate is quoted as 1.2 MB/s i.e. the write would require at least 
3.4 ms to complete.

My fear is that the entire transfer is done in a non-preemptible 
critical section. In other words, my real-time app would be delayed 
several milliseconds, which is unacceptable.

Am I mistaken?

Regards.
