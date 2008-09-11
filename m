From: Tejun Heo <tj@kernel.org>
Subject: Re: Laptop shock detection and harddisk protection
Date: Fri, 12 Sep 2008 01:35:54 +0200
Message-ID: <48C9AB5A.705@kernel.org>
References: <48C7FCEE.8060404@kernel.org>	 <41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com>	 <48C948A6.3080404@kernel.org> <41840b750809111325t30f8ffe2sa4572d401d43dc5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53076 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853AbYIKXh1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 19:37:27 -0400
In-Reply-To: <41840b750809111325t30f8ffe2sa4572d401d43dc5a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Shem Multinymous wrote:
>> That reduction comes because input device supports poll and
>> sysfs_notify_event() does about the same thing.  The uesrland daemon
>> can just poll on a node and read data nodes when poll event on the
>> node triggeres.
> 
> Agreed.
> There's another issue with the current sysfs interface, though: hdapsd
> needs to read (x,y,timestamp) tuples, whereas sysfs provides just x
> and y in separate attributes which cannot be read atomically together.
> We can add a sysfs file with "x y timestamp" readouts, though this is
> unusual for sysfs (and certainly incompatible with hwmon).

Yes, right.  Forgot about the atomicity part altogether.  Thanks for
bringing it up.

>> Unloading heads will be simple.  Just echoing timeout in ms to sysfs
>> nodes, so I don't think it's a good idea to push out actual unloading
>> to another process especially as fork doesn't inherit mlockall.
> 
> I had in mind another daemon listening for "unload now" events, so no
> forking needed.
> This second daemon might make sense if we push the logic of deciding
> *which* disks to unload into userspace, since this logic is the same
> for the ThinkPad style and the HP style.

Hmmm... I can't (yet) see the benefit of having two separate userland
daemons.

>> On a related note, is there any plan to merge tp_smapi to mainline?
>> It seems you put a lot of work into it and I don't really see why it
>> should stay out of tree.
> 
> The only issue I'm aware of is finding a reasonably-named maintainer.
> On the technical side, the reviews on my lkml submission of
> thinkpad_ec+hdaps seemed good and all technical comments are since
> addressed. The code has been stable, well-tested and packaged by major
> distros for years.

Cool, can you please post the patch to the lkml and cc Greg
Kroah-Hartman <gregkh@suse.de>, Andrew Morton
<akpm@linux-foundation.org> and me?

Thanks.

-- 
tejun
