From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 29 Nov 2007 13:55:13 -0500
Message-ID: <474F0B11.7000205@rtr.ca>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu> <474EE561.7010207@gmail.com> <474EE5F8.1030409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4602 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762985AbXK2SzP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 13:55:15 -0500
In-Reply-To: <474EE5F8.1030409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Tejun Heo wrote:
>> Alan Cox wrote:
>>>> Private command type / transfer length filtering in sata_promise,
>>>> pata_it821x and pata_pdc2027x are removed as core layer filtering is
>>>> more conservative.
>>>>
>>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> NAK - as before
>>>
>>> This is the wrong way to do stuff. Stop penalizing the 99.99% of users
>>> with perfectly sane hardware. In addition I note that the whitelist for
>>> drives would rapidly be thousands of entries long and unmanagable.
>> Well, I guess we'll have to agree to disagree here.  I just don't think
>> that penalty is worth considering and definitely don't think whitelist
>> is necessary at all.
> 
> Also, what do other people think about the subject?  IIRC, Jeff agrees
> with Alan, right?  Albert, Mark, what do you guys think?
...

I'm split on this one.  For fast systems (typical notebook/desktop) it's
almost a non-issue either way.

But a lot of media boxes will be using this code, and they tend to have
very low-power, slow-clockrate CPUs in the 200-800Mhz range, and so the
real-time hit there (from PIO) will have a much more significant impact.

Using DMA as much as possible on those slower platforms is definitely
a plus towards avoiding non-jerky, skipped frames, or start-stoppy DVD recording.

Now the most intensive commands are still DMA under the proposed scheme,
so it's not those that one would be concerned with.  But dropping to PIO
even for a few uncommon commands will still peg a real-time hit or two
on a slower media processor.

So..  ????

