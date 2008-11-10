From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve timeout handling for EH commands
Date: Mon, 10 Nov 2008 18:32:35 +0200
Message-ID: <c70ff3ad0811100832g39b838fepd214cdc16ee129f4@mail.gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
	 <48458809.1030207@garzik.org> <484621D7.1040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.224]:63230 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbYKJQci (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 11:32:38 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1458306qba.17
        for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2008 08:32:35 -0800 (PST)
In-Reply-To: <484621D7.1040607@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca

Hi,
       This patch is guilty for big delay when I boot my system with
marvell soc sata with 4140 pmp (without disks). I added print for the
deadline and now variables in the ata_eh_reset.
here is the output:
ata2: SATA max UDMA/133 irq 29
 sleep deadline -35455  now -29955
 sleep done
ata1: SATA link down (SStatus 0 SControl 300)
 sleep deadline -35419  now -29919
 sleep done
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: Port Multiplier 1.1, 0x11ab:0x4140 r193, 5 ports, feat 0x1/0x1f
 sleep deadline 500  now -29867

it seems that in may case the ehc->last_reset was not initialized.

saeed


On Wed, Jun 4, 2008 at 7:02 AM, Tejun Heo <htejun@gmail.com> wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Hello,
>>>
>>> [S]ATA has lots of legacy and not in a too healthy way.  The desparate
>>> efforts to keep everything compatible made mundane things quite
>>> challenging.  Probing definitely is one of them.  We now span from
>>> ancient CF devices to port multipliers and quirky ones are easy to
>>> find all along the spectrum.
>>>
>>> For example, according to the spec reset protocol and the actual
>>> implementations, there's no defined way to wait for the initial D2H
>>> Reg FIS after hardresetting a fan-out port.  The problem is that the
>>> D2H Reg FIS can arrive during later steps of probing is in progress
>>> and a rogue FIS at the right time can easily make the controller fail
>>> or time out pending operations.
>>>
>>> Another problem of the long spectrum is that we can't choose the one
>>> correct value as timeout for operations.  A timeout value which can
>>> cover all the devices is too long and makes EH painfully slow when
>>> something goes wrong.  Choosing shorter timeout means the ancient and
>>> weirdos won't work.
>>>
>>> So, we have to resort to smart self adjusting timeouts.  Early
>>> quickies to detect transient failures quickly and later long ones to
>>> cover odd devices.  Deadline driven ata_eh_reset() was a step in that
>>> direction and this patchset, in addition to other timeout related
>>> improvements, applies it to the rest of EH commands.
>>>
>>> This patchset contains the following patches.
>>>
>>>  01-libata-kill-unused-constants.patch
>>>  02-libata-consistently-use-msecs-for-time-durations.patch
>>>  03-libata-improve-EH-retry-delay-handling.patch
>>>  04-libata-use-ULONG_MAX-to-terminate-reset-timeout-tab.patch
>>>  05-libata-improve-EH-internal-command-timeout-handling.patch
>>>
>>> #01, #02 and #04 are preparations.  #02 makes liata use msecs
>>> consistently for time durations.  #03 makes inter-try or inter-reset
>>> delays smarter and allows libata EH to delay less between tries
>>> without sacrificing robustness.  #05 implements per command class
>>> stepped timeouts for EH commands, so that the first IDENTIFY try fails
>>> quickly but later on the device can take full 30secs to think about it
>>> while restricting maximum timeout for SET_FEATURES to 10secs.
>>>
>>> This patchset makes whole EH behave much more swiftly and timeout
>>> cases bearable.  :-)
>>
>> ACK
>>
>> for .27?  Seems useful to .26, but also we are late in .26-rc and this
>> is a lot of changes for -rc$LATE :)
>
> Yes, for .27.  It's too big a change for 26.
>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
