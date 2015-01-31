From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: libahci: Use of_platform_device_create only if
 supported
Date: Sat, 31 Jan 2015 12:08:12 -0500
Message-ID: <20150131170812.GC3088@htj.dyndns.org>
References: <1422721938-1542-1-git-send-email-linux@roeck-us.net>
 <20150131164517.GB3088@htj.dyndns.org>
 <54CD0890.7050800@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:59291 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbbAaRIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2015 12:08:15 -0500
Content-Disposition: inline
In-Reply-To: <54CD0890.7050800@roeck-us.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>

On Sat, Jan 31, 2015 at 08:53:36AM -0800, Guenter Roeck wrote:
> I agree, it is weird, as is the whole "all API functions associated
> with OF_ADDRESS are handled differently on sparc" thing. But that
> is neither new nor something I can fix.

Out of curiousity, why isn't the header file doing the following?

#ifdef CONFIG_OF_ADDRESS

void of_platform_device_create(blah);
...

#else

static inline void of_platform_device_create(blah)
{
}

#endif

-- 
tejun
