From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Register for dock events when the drive is	inside
 a dock station
Date: Thu, 28 Feb 2008 22:05:53 +0900
Message-ID: <47C6B1B1.2040602@gmail.com>
References: <20080214124048.GB9708@homac.suse.de> <20080214125615.GD9708@homac.suse.de> <47BC5F44.605@garzik.org> <20080221115305.GB5032@homac.suse.de> <47BE26A0.2040708@gmail.com> <20080226101551.GB10721@homac.suse.de> <47C6804A.50705@gmail.com> <20080228110927.GA5745@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:49623 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbYB1NGD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 08:06:03 -0500
Received: by wr-out-0506.google.com with SMTP id c48so5060770wra.23
        for <linux-ide@vger.kernel.org>; Thu, 28 Feb 2008 05:06:02 -0800 (PST)
In-Reply-To: <20080228110927.GA5745@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Holger Macht wrote:
> On Thu 28. Feb - 18:35:06, Tejun Heo wrote:
>> Holger Macht wrote:
>>> The hotplug handler is only called if the device is actually inside the
>>> dock station. If it is not, nothing will happen. I hope that I got your
>>> question right?
>> Yes, right.
>>
>>> However, if this would be helpful, it would be easy to add something like
>>> a am_I_on_dock_station?(...) function to the dock driver.
>> Hmm.. as long as the event is only delivered when the device is actually
>> connected behind dock, I think it's okay.
> 
> The dock driver also export a is_dock_device(acpi_handle) function, which
> could be used to make more fine-grained decisions, but it shouldn't be
> needed here.
> 
>> Does the attached patch fix the previous undock problem?  It now
>> explicitly tells libata EH to detach the notified devices on
>> EJECT_REQUEST and wait for EH to complete such that control is returned
>> to ACPI after all notified devices are actually detached.
> 
> No it does not. Apparently, it freezes faster (from 1 second down to
> immediately). Before, it just froze when someone (in this case HAL) tried
> to access the device. The "echo 1 > undock" call does not even return, so
> it might have introduced another problem.

The code should be in generally right direction.  Can you be persuaded
into tracking down what's going on?

Thanks.

-- 
tejun
