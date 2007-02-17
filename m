From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sat, 17 Feb 2007 17:29:46 +0100
Message-ID: <8d158e1f0702170829m6b57b0d3y51d69431983346d3@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>
	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
	 <45D56FE4.3090900@tw.ibm.com>
	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
	 <45D574B1.8080109@tw.ibm.com>
	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
	 <45D58270.4080909@tw.ibm.com>
	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:34409 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965313AbXBQQ3r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Feb 2007 11:29:47 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1205765nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Feb 2007 08:29:47 -0800 (PST)
In-Reply-To: <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 2/17/07, Patrick Ale <patrick.ale@gmail.com> wrote:

Something is very off here... i know I have fever and all but this is
a "wt*" moment.

So, libata doesnt detect any drive, and the old IDE drivers give me

PDC20276: chipset revision 1
PDC20276: PLL input clock is 33527 kHz
PDC20276: 100% native mode on irq 20
    ide4: BM-DMA at 0xcc00-0xcc07, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide4...
hde: Host Protected Area detected.
        current capacity is 234441648 sectors (120034 MB)
        native  capacity is 274103470214064 sectors (140340976749 MB)

I can't even calculate how many terrabyte that'd be on just hde but I
can only wish I had that amount of diskspace.

So, probably, controller broken? I don't have another promise card to
check, I can buy one tho.

This still doesn't explain why libata doesn't detect the drives at
least, even with invalid drive specifications. Or why it doesnt give
me any sort of error at all.

Ah well, I probably shouldnt be messing around right now anyway.... :)

Tejun, Albert, thanks for the help so far, and to all people in Asia,
happy new year :)


Patrick
