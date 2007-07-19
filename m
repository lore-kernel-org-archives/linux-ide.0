From: Mingming Caoc <cmm@us.ibm.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
Date: Thu, 19 Jul 2007 10:21:22 -0700
Message-ID: <469F9D92.9000708@us.ibm.com>
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com> <a781481a0707191007q241f5f5bh6c029da56090d8b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42261 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S940526AbXGSRVl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jul 2007 13:21:41 -0400
In-Reply-To: <a781481a0707191007q241f5f5bh6c029da56090d8b3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Satyam Sharma <satyam.sharma@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, Doug Chapman <doug.chapman@hp.com>, Vasily Tarasov <vtaras@openvz.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>, Tejun Heo <htejun@gmail.com>

Satyam Sharma wrote:
>> Subject         : ext4 build warnings
>> References      : http://lkml.org/lkml/2007/7/18/420
>> Last known good : ?
>> Submitter       : Jeff Garzik <jeff@garzik.org>
>> Caused-By       : ?
>> Handled-By      : Mingming Cao <cmm@us.ibm.com>
>> Status          : unknown
> 
> Mingming Cao fixed this:
> 
> http://lkml.org/lkml/2007/7/18/564
> 
> Dunno if it's in latest git

Andrew pushed the patch to Linus last night.

Thanks,

Mingming
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


