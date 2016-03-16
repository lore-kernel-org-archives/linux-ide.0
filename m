From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Wed, 16 Mar 2016 14:07:13 -0700
Message-ID: <20160316210713.GI21104@mtj.duckdns.org>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <3904852.c3HykPsQQ2@wuerfel>
 <56AFAA46.6090403@amd.com>
 <5709817.yQT8N3CaLj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34724 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbcCPVHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2016 17:07:16 -0400
Content-Disposition: inline
In-Reply-To: <5709817.yQT8N3CaLj@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

Hello, Arnd.

On Mon, Feb 01, 2016 at 09:14:17PM +0100, Arnd Bergmann wrote:
>> I am not debating on your AML call recommendation, it sounds like
>> a good idea however BIOS is already released hence its bit late to
>> add AML methods for this. I am seeking guidance on what can be
>> done in the given situation. I thought platform driver is one
>> option to get this feature enabled in kernel.

> This is where we really need the ACPI maintainers to explain the
> general policy for dealing with firmware updates.
> 
> I would assume that adding the feature in a later firmware version
> is a compatible change, and the feature is non-essential (the
> device will work fine with the generic SATA driver, except
> the LEDs don't blink), so it's not a big deal, it's just what
> you get for having the firmware shipped before the driver is
> reviewed (don't do that).

So, if it were x86, I'd commit the custom driver without thinking too
much as ata drivers have always been working around bios issues (there
often wasn't any other recourse).  If the hardware is already out
there and it's not too easy to roll out bios updates, from libata
side, I'm okay with having a custom driver to work around that.  What
do you think?

Thanks.

-- 
tejun
