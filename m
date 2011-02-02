From: viresh kumar <viresh.kumar@st.com>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Wed, 2 Feb 2011 09:13:46 +0530
Message-ID: <4D48D2F2.20907@st.com>
References: <4D395B74.1010705@st.com> <20110121101400.GC2832@htj.dyndns.org> <4D395FE8.8000902@st.com> <4D39752B.7000202@st.com> <20110121163906.GG2832@htj.dyndns.org> <AANLkTimw4NHmNcXiB1rrQMFMRvmwG5Ww9gj_K7_xw_j-@mail.gmail.com> <20110201175925.GA20794@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:42267 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799Ab1BBDod (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2011 22:44:33 -0500
In-Reply-To: <20110201175925.GA20794@bounceswoosh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@bounceswoosh.org>
Cc: Viresh Kumar <viresh.nitj@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

On 02/01/2011 11:29 PM, Eric D. Mudama wrote:
> On Tue, Feb  1 at 21:02, Viresh Kumar wrote:
>> But i am facing another issue now. I am getting following error
>> sometimes, when i
>> copy > 10 MB of data to CF card.
>>
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>> ata1.00: BMDMA stat 0x5
>> ata1.00: failed command: WRITE DMA
>> ata1.00: cmd ca/00:00:3f:7f:3c/00:00:00:00:00/e0 tag 0 dma 131072 out
>>        res d0/00:00:3f:7f:3c/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>> ata1.00: status: { Busy }
>>
>>
>> I debugged it further and found that after data is transferred,
>> altstatus register is returning status 0xd0, which means ATA_BUSY.
>>
>> I am not sure why this must be returned by card after data is transferred?
> 
> Did you wait for the interrupt?  Or is this polling alt status
> immediately after completing the data transfer?

I waited for this interrupt:

INTRQ_Int: This is the direct assignment of the CF/CF+ Interface pin 37 (INTRQ) when the
Interface is operating in TrueIDE Mode. This is the Interrupt from the Card.
The Software must read the ATA Status Register to find the source of Interrupt.

And i think that is sufficient enough.

> 
> If I remember correctly (been a long time), there's a busy phase after
> the last word is transferred, until the command actually completes.
> This may or may not generate an interrupt.  Eventually, the alt status
> register should transition to a status without the HOB set (0xD0->0x50
> most of the time) when the command has finished, and a read of the
> regular status register should clear an outstanding interrupt.
> 

Just to get over this doubt, i will try place a small udelay after data is transferred
and before framework is communicated for successful xfer.

-- 
viresh
