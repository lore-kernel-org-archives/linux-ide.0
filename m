From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Sun, 18 Jan 2009 15:39:13 -0500
Message-ID: <49739371.5030107@garzik.org>
References: <20081104062734.GA4420@havoc.gtf.org> <200901111343.49901.rjw@sisk.pl> <200901181120.08992.elendil@planet.nl> <200901182125.04060.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50502 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbZARUjg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jan 2009 15:39:36 -0500
In-Reply-To: <200901182125.04060.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Frans Pop <elendil@planet.nl>, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Sunday 18 January 2009, Frans Pop wrote:
>> Rafael J. Wysocki wrote:
>>> There is a name conflict with a change applied after this patchset had
>>> been created.  The appended patch fixes it for me.
>> [...]
>>> @@ -483,7 +483,7 @@ const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
>>>         const struct dmi_system_id *d; 
>>>
>>>         for (d = list; d->ident; d++)
>>> -               if (dmi_match(d))
>>> +               if (dmi_matches(d))
>>>                         return d;
>> I get two warnings when compiling your patch with this correction on top:
> 
> Hm, there were more patches than one, so I'm not sure.  When I apply all of
> them, I don't see these error, but perhaps I should resend the entire series.
> Will do tomorrow.

That would be useful...  I was planning to regenerate the series, but 
this would save time.

Thanks!

	Jeff




