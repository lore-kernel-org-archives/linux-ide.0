From: viresh kumar <viresh.kumar@st.com>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Fri, 21 Jan 2011 15:58:56 +0530
Message-ID: <4D395FE8.8000902@st.com>
References: <4D395B74.1010705@st.com> <20110121101400.GC2832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:57352 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753255Ab1AULBB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2011 06:01:01 -0500
In-Reply-To: <20110121101400.GC2832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

Tejun,

Thanks for your prompt reply!!

On 01/21/2011 03:44 PM, Tejun Heo wrote:
> On Fri, Jan 21, 2011 at 03:39:56PM +0530, viresh kumar wrote:
>> > I am implementing mwdma interface for arasan compact flash controller.
>> > I am facing a strange problem, when i insert CF card on my board (after bootup),
>> > in mwdma mode, i get following:
>> > 
>> > ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
> That's AC_ERR_ATA_BUS.
> 
>> > Can somebody give any clue on which part i should try to look at?
> Yeah, someone is reporting CRC error.

I will check this.

But it seems unknown partition table is a different issue,
as this error is also coming in PIO mode, where i am able to get sda1 node
and able to read/write to card.

print in PIO mode:

# ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata1: soft resetting link
ata1.00: CFA: TRANSCEND, 20091215, max UDMA/66
ata1.00: 62537328 sectors, multi 0: LBA 
ata1.00: configured for PIO6
ata1.00: configured for PIO6
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2009 PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 62537328 512-byte logical blocks: (32.0 GB/29.8 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk

-- 
viresh
