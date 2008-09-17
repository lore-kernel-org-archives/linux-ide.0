From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Laptop shock detection and harddisk protection
Date: Wed, 17 Sep 2008 15:36:36 -0400
Message-ID: <41840b750809171236s524f1a70i3e1624a2facd9d44@mail.gmail.com>
References: <48C7FCEE.8060404@kernel.org>
	 <41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com>
	 <48C948A6.3080404@kernel.org> <877i9ipi56.fsf@denkblock.local>
	 <20080817195103.GD4043@ucw.cz> <87d4j2ol2a.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:64132 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbYIQTgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 15:36:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3163834wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 12:36:36 -0700 (PDT)
In-Reply-To: <87d4j2ol2a.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Pavel Machek <pavel@suse.cz>, Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Sep 17, 2008 at 11:21 AM, Elias Oltmanns <eo@nebensachen.de> wrote:
>>> 2. Make shock protection interact nicely with suspend operations:
>>>    currently, we are out of luck if anything should happen after
>>>    processes have been frozen. This is particularly unfortunatel in the
>>>    case of s2disk.
>>
>> I'd say that s2disk is similar to early boot... no protection there.
>
> Well, this is true for resume. However, I can't help thinking that we
> may do better than that until the disk spins down, particularly while
> writing the image to disk.

Agreed.
Practically, disk protection during suspend-to-disk sounds very
useful, given the typical usage scenario: you press button to
hibernate and start shuffling around your chair/desk in preparation
for leaving the room. Dropping the laptop is more likely than ever at
this point. Resume-from-disk tends to be done after settling down into
your chair/desk, so the drop risk is lower.

  Shem
