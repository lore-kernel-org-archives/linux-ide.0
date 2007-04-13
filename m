From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Fri, 13 Apr 2007 15:36:20 -0400
Message-ID: <461FDBB4.8070208@redhat.com>
References: <461D4E2C.6000704@redhat.com> <Pine.LNX.4.61.0704112347230.20436@yvahk01.tjqt.qr> <461D5C24.9080506@redhat.com> <200704132142.29582.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411AbXDMTg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Apr 2007 15:36:26 -0400
In-Reply-To: <200704132142.29582.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>> Now we're getting somewhere. There is some other OS on here because
>> it's required for doing BIOS updates. I booted it and shut down.
>> The power cycle count increased but the power off retract count did not.
>>
>> The counts are:
>>
>> power cycle ... 111
>> power off retract ... 92
>>
>> The difference is now 19; it was 18 before.
> 
> Is the noise present if you reboot the other OS?
> Does it result in Power-Off_Retract count increase?

There is no noise and the retract count does not increase when I boot
and then shutdown/power off the other OS.

