From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [2.6.30-rc2] CD-R: wodim intermittent failures: [sr0] Add.  
 Sense: Logical block address out of range, sector 0
Date: Thu, 23 Apr 2009 00:46:19 -0600
Message-ID: <49F00EBB.7040504@gmail.com>
References: <20090421015234.GA7014@hexapodia.org> <20090422144904.407df635.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:46666 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbZDWGq2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2009 02:46:28 -0400
In-Reply-To: <20090422144904.407df635.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Mon, 20 Apr 2009 18:52:34 -0700
> Andy Isaacson <adi@hexapodia.org> wrote:
> 
>> I'm running 2.6.30-rc2-00446-ga939b96 on a Dell E4300 with a
>> upgraded-to-Jaunty-mostly Ubuntu install.  Using 2.6.28 and 2.6.29.1,
>> I've successfully burned a dozen CDRs, but since updating to .30-rc1
>> I've noticed intermittent failures to burn CDRs using wodim at the Gnome
>> desktop.  (Switching back to .29.1 makes wodim reliable again.)  There
>> have been a few different failure modes, but all of them seem to be
>> associated with these messages in dmesg, which I haven't seen before:
>>
>> [  360.740810] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>> [  360.740816] sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current] 
>> [  360.740820] sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
>> [  360.740826] end_request: I/O error, dev sr0, sector 0
>> [  360.740830] Buffer I/O error on device sr0, logical block 0

...

> Oh well, let's tentatively assume that we have a post-2.6.29 regression
> in the libata ahci driver.

I tend to doubt it's a problem in ahci itself, I would guess it's higher 
up the stack. Or could be that it's not a kernel bug, just some change 
in timing that triggers the problem.

What's supposed to stop udev/hal from poking at the drive while wodim is 
writing to the disc, anyway?
