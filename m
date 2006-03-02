From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 1 Mar 2006 18:39:45 -0700
Message-ID: <311601c90603011739o47684f4fxa3dc3b5046638655@mail.gmail.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <4405F471.8000602@rtr.ca>
	 <1141254762.11543.10.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:26557 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbWCBBjq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Mar 2006 20:39:46 -0500
Received: by wproxy.gmail.com with SMTP id 71so291388wri
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 17:39:45 -0800 (PST)
In-Reply-To: <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/1/06, Eric D. Mudama <edmudama@gmail.com> wrote:
> I believe this core should not be part of the FUA whitelist.  If I
> remember correctly, there are other implementations out there with
> similar limitations to opcodes this "new" to ATA.

That being said, I see from

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951

that a blacklisting of some Maxtor drives for this issue has
supposedly occurred or been pushed and accepted "upstream" in git ....
 For the obvious (selfish) reasons, I'd like to minimize the number of
Maxtor drives that are blacklisted, as I don't believe this is a drive
issue at all.

If there's a drive model out there reporting support for FUA but
screwing it up, I'm all ears as that's something I need to know about.
 If basic adapter functional testing is required for some of these
low-level commands, then that might be something I can help with too
(on a very limited scale), since we have access to ~100 different
chipsets.

--eric
