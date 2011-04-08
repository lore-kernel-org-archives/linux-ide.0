From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Fri, 08 Apr 2011 00:58:45 -0400
Message-ID: <4D9E9605.7030304@garzik.org>
References: <201104071854.10911.morpheus.ibis@gmail.com> <201104071908.10852.morpheus.ibis@gmail.com> <20110407190300.GA8841@mtj.dyndns.org> <201104072140.59548.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48112 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1DHE6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 00:58:48 -0400
Received: by qyk7 with SMTP id 7so3730530qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 07 Apr 2011 21:58:47 -0700 (PDT)
In-Reply-To: <201104072140.59548.morpheus.ibis@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Herrmann <morpheus.ibis@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 04/07/2011 03:40 PM, Pavel Herrmann wrote:
> On Thursday 07 of April 2011 21:03:00 Tejun Heo wrote:
>> I'm confused.  Against which version is the patch generated?  Upstream
>> already has quirks for 4726.
>>
>> Thakns.
>
> this is what you get from running and editing a different tree (and being
> lazy), sorry for messing it up.
>
> the correct (tested) code, without beautifications/comments:
>
>          } else if (vendor == 0x197b&&  devid == 0x2352) {
>                  ata_for_each_link(link, ap, EDGE) {
>                          link->flags |= ATA_LFLAG_NO_LPM |
>                                         ATA_LFLAG_NO_SRST |
>                                         ATA_LFLAG_ASSUME_ATA;
>                  }
>          }
>
> third time's the charm
>
> Thanks
> Pavel Herrmann
>
> PS: just to be on the safe side, this is the device detection from dmesg
> ata8.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0

So you're gonna resend this as a real patch, right?  :)


