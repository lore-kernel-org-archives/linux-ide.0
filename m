From: Viresh Kumar <viresh.nitj@gmail.com>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Sat, 22 Jan 2011 09:38:46 +0530
Message-ID: <AANLkTimD0oDCx=UTYsenTNPgO4RgHGCKxrNyQ2u7atmE@mail.gmail.com>
References: <4D395B74.1010705@st.com>
	<20110121101400.GC2832@htj.dyndns.org>
	<4D395FE8.8000902@st.com>
	<4D39752B.7000202@st.com>
	<20110121163906.GG2832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48105 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab1AVEIs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2011 23:08:48 -0500
Received: by bwz15 with SMTP id 15so2206929bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2011 20:08:46 -0800 (PST)
In-Reply-To: <20110121163906.GG2832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: viresh kumar <viresh.kumar@st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

On 1/21/11, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Jan 21, 2011 at 05:29:39PM +0530, viresh kumar wrote:
>> I tried again, but couldn't find why i am getting these two issues:
>> 	ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
>
> Yeah, it should be possible to avoid the above if it's coming from
> hotplug.  Identify where and why AC_ERR_ATA_BUS is being set and work
> around it.  There's no reason for it to be set after a hotplug anyway.
>

Ok. Will debug this.

>> 	sda: unknown partition table
>
> and then this probably is unrelated.  So, no IO error is being
> reported but the above still fails?

Yes

> How did you verify the read data
> are actually the same?  Maybe there's a cache alias issue?
>

I printed buffer data at two places
: ata_sff_data_xfer (in PIO mode)
: my drivers dma read routine after all data is read (In MWDMA Mode).

As soon as handshaking is done, a read request of 4096 bytes is given:
Here in both cases (PIO and MWDMA) first block of 512 bytes contained
non-zero data but the other 7 blocks contained 0.

Also Arasan Controller, as far i have understood, doesn't transfer data directly
to a memory location. Instead we need to read data from Controllers FIFO.
So, probably it wouldn't be cache issue, as ARM is reading data directly from
FIFO to our buffer (using its virtual address).

Note: I am working on linux-2.6.37 and Card was formatted before
testing and so is empty.

--
viresh
