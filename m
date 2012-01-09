From: "Show lu" <showlu@jmicron.com>
Subject: RE: JMicron Technology JMB362 JMB363 SError: { DevExch } ExpressCard, sometimes fails to boot
Date: Mon, 9 Jan 2012 14:37:04 +0800
Message-ID: <201201090637.q096b4Mr014253@jmr105.jmicron.com>
References: <4F081CC3.90506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spamfilter.jmicron.com ([220.130.51.235]:43652 "EHLO
	jmsspam.jmicron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751282Ab2AIGhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2012 01:37:40 -0500
In-Reply-To: <4F081CC3.90506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Orson' <orson.wellies@gmail.com>
Cc: 'Steven Chen' <stevenchen@jmicron.com>, 'Jonathan Nieder' <jrnieder@gmail.com>, linux-ide@vger.kernel.org, 'Tejun Heo' <tj@kernel.org>, 'Aries Lee' <arieslee@jmicron.com>, 'ZZ Hong' <zzhong@jmicron.com>, 'KK Chen' <kkchen@jmicron.com>

Dear Sir,
Thanks for your information.


If have any question please kindly let me know.

Thanks
Sincerely
Show


-----Original Message-----
From: Orson [mailto:orson.wellies@gmail.com] 
Sent: Saturday, January 07, 2012 6:22 PM
To: Show lu
Cc: 'Steven Chen'; 'Jonathan Nieder'; linux-ide@vger.kernel.org; 'Tejun
Heo'; 'Aries Lee'
Subject: Re: JMicron Technology JMB362 JMB363 SError: { DevExch }
ExpressCard, sometimes fails to boot

Hi,

Having received the replacement express card (197b:2363) I can confirm 
that the card in question appears to have been faulty.

The new express card performs flawlessly, I can cold boot / warm boot to 
Linux or windows without receiving any error message, and after several 
days of testing external disks I can honestly say that everything went 
without a hitch.

So, I would be happy if the bug report was closed with reason being due 
to faulty hardware.

regards

Orson

On 16/12/11 04:55, Show lu wrote:
> Dear Sirs,
> Good day,
> I am JMicron/Show and take over JMB36X FAE activity
> Please help to shows the PCIE CFG registers(of JMB36X) at first.
>
>
> Thanks
> Sincerely
> Show
>
>
>
> -----Original Message-----
> From: Steven Chen [mailto:stevenchen@jmicron.com]
> Sent: Friday, December 16, 2011 10:52 AM
> To: 'Jonathan Nieder'; linux-ide@vger.kernel.org; 'Show lu'
> Cc: 'Tejun Heo'; 'Orson'; 'Aries Lee'
> Subject: RE: JMicron Technology JMB362 JMB363 SError: { DevExch }
> ExpressCard, sometimes fails to boot
>
> Add Show in this mail loop.
>
> -----Original Message-----
> From: Jonathan Nieder [mailto:jrnieder@gmail.com]
> Sent: Wednesday, December 14, 2011 6:45 AM
> To: linux-ide@vger.kernel.org
> Cc: 'Tejun Heo'; 'Orson'; Aries Lee
> Subject: Re: JMicron Technology JMB362 JMB363 SError: { DevExch }
> ExpressCard, sometimes fails to boot
>
> (Aries: sorry for the duplicate message)
> Hi,
>
> Aries Lee wrote:
>
>> Is it possible to install windows OS on the same hardware,
>> If it still get the same error, that we can conclude it as a hardware
> issue.
>
> Orson wrote:
>
>> I installed WinXP SP3 as a dual boot option onto my HP NX6325.
>> I booted into windows and my dual port express card was found
immediately,
> I
>> installed the latest driver from J Micron and everything seemed to be OK.
>> I looked through the winxp system messages and all was OK, I looked
> through
>> device manager and it said everything was OK, all resources were OK.
>> I attached an external esata drive and it was detected instantly and was
>> available in my list of drives, I copied some files over, all went OK, I
> ran
>> scandisk to check the drive and all went OK, the drive did not seem to
>> re-attach itself or give any errors.  So it seems to work fine in
windows.
> All right; looks like the hardware works.
>
>> I then shut down my laptop and removed the esata drive and booted into
> Debian
>> wheezy, same error appeared during boot (without any drive attached)
>> irq_stat 0x00000040, connection status changed
>> ata1: SError: { PHYInt CommWake DevExch }
>> ata1: hard resetting link
>> ata1: COMRESET failed (errno=-32)
>> ata1: reset failed (errno=-32), retrying in 8 secs
>> ata1: limiting SATA link speed to 1.5 Gbps
>> ata1: hard resetting link
>> ata1: SATA link down (SStatus 0 SControl 310)
>> ata1: EH complete
>>
>> etc, etc.
> Right.
>
>> I booted back to windows and all was OK, but, here is what I have found,
> if I
>> boot into Linux from windows without shutting down (warm boot) then the
>> express card is initialised in Debian without problems and works as
> normal, if
>> I shut down and cold boot straight to Debian, the error appears again.
> Interesting.  So it sounds like Windows is doing some initialization
> that Linux does not.
>
>> Perhaps the card is faulty or (I suspect) there is a problem with the
bios
> on
>> the NX6325, the latest bios is dated 2007 and HP seem to have stopped
>> supporting this model, even though mine was purchased new in 2007.
> Please send "acpidump" output as an attachment for reference.
>
>> Anyway, because the express card is so cheap I have just ordered a
> replacement
>> of the same type, so this will tell me if it's the card that is at fault.
> Ok.  Thanks for your work.
>
> linux-ide folks: any ideas for debugging this further?  For example,
> is there a way to find the difference between the state after a cold
> boot and a warm boot from windows?
>
> Ciao,
> Jonathan
>

