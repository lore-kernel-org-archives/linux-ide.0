From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET #upstream] libata: improve timeout handling for EH
 commands
Date: Tue, 03 Jun 2008 14:06:01 -0400
Message-ID: <48458809.1030207@garzik.org>
References: <12112174741373-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47676 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbYFCSGE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jun 2008 14:06:04 -0400
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> Hello,
> 
> [S]ATA has lots of legacy and not in a too healthy way.  The desparate
> efforts to keep everything compatible made mundane things quite
> challenging.  Probing definitely is one of them.  We now span from
> ancient CF devices to port multipliers and quirky ones are easy to
> find all along the spectrum.
> 
> For example, according to the spec reset protocol and the actual
> implementations, there's no defined way to wait for the initial D2H
> Reg FIS after hardresetting a fan-out port.  The problem is that the
> D2H Reg FIS can arrive during later steps of probing is in progress
> and a rogue FIS at the right time can easily make the controller fail
> or time out pending operations.
> 
> Another problem of the long spectrum is that we can't choose the one
> correct value as timeout for operations.  A timeout value which can
> cover all the devices is too long and makes EH painfully slow when
> something goes wrong.  Choosing shorter timeout means the ancient and
> weirdos won't work.
> 
> So, we have to resort to smart self adjusting timeouts.  Early
> quickies to detect transient failures quickly and later long ones to
> cover odd devices.  Deadline driven ata_eh_reset() was a step in that
> direction and this patchset, in addition to other timeout related
> improvements, applies it to the rest of EH commands.
> 
> This patchset contains the following patches.
> 
>  01-libata-kill-unused-constants.patch
>  02-libata-consistently-use-msecs-for-time-durations.patch
>  03-libata-improve-EH-retry-delay-handling.patch
>  04-libata-use-ULONG_MAX-to-terminate-reset-timeout-tab.patch
>  05-libata-improve-EH-internal-command-timeout-handling.patch
> 
> #01, #02 and #04 are preparations.  #02 makes liata use msecs
> consistently for time durations.  #03 makes inter-try or inter-reset
> delays smarter and allows libata EH to delay less between tries
> without sacrificing robustness.  #05 implements per command class
> stepped timeouts for EH commands, so that the first IDENTIFY try fails
> quickly but later on the device can take full 30secs to think about it
> while restricting maximum timeout for SET_FEATURES to 10secs.
> 
> This patchset makes whole EH behave much more swiftly and timeout
> cases bearable.  :-)

ACK

for .27?  Seems useful to .26, but also we are late in .26-rc and this 
is a lot of changes for -rc$LATE :)


