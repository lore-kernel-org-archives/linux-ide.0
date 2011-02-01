From: Viresh Kumar <viresh.nitj@gmail.com>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Tue, 1 Feb 2011 21:02:13 +0530
Message-ID: <AANLkTimw4NHmNcXiB1rrQMFMRvmwG5Ww9gj_K7_xw_j-@mail.gmail.com>
References: <4D395B74.1010705@st.com>
	<20110121101400.GC2832@htj.dyndns.org>
	<4D395FE8.8000902@st.com>
	<4D39752B.7000202@st.com>
	<20110121163906.GG2832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48763 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab1BAPcQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2011 10:32:16 -0500
Received: by bwz15 with SMTP id 15so6434267bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 01 Feb 2011 07:32:14 -0800 (PST)
In-Reply-To: <20110121163906.GG2832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: viresh kumar <viresh.kumar@st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

Tejun,

On 1/21/11, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Jan 21, 2011 at 05:29:39PM +0530, viresh kumar wrote:
>> 	sda: unknown partition table
>
> and then this probably is unrelated.  So, no IO error is being
> reported but the above still fails?  How did you verify the read data
> are actually the same?  Maybe there's a cache alias issue?
>

This issue is solved now and was related to cache only. As i mentioned earlier
Arasan CF controller doesn't xfer data from/to RAM. And so i was using CPU
to copy data. After data is passed to libata, in page_unmap, cache was
getting invalidated.
And so data written by CPU is lost.

Now i am using external DMA controller to copy data to CF FIFO, and am able to
read/write data to CF card.

But i am facing another issue now. I am getting following error
sometimes, when i
copy > 10 MB of data to CF card.

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: BMDMA stat 0x5
ata1.00: failed command: WRITE DMA
ata1.00: cmd ca/00:00:3f:7f:3c/00:00:00:00:00/e0 tag 0 dma 131072 out
        res d0/00:00:3f:7f:3c/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
ata1.00: status: { Busy }


I debugged it further and found that after data is transferred,
altstatus register is
returning status 0xd0, which means ATA_BUSY.

I am not sure why this must be returned by card after data is transferred?

--
viresh
