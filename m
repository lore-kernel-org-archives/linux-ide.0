From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ata: libahci: Use of_platform_device_create only if supported
Date: Sat, 31 Jan 2015 09:33:55 -0800
Message-ID: <54CD1203.6010400@roeck-us.net>
References: <1422721938-1542-1-git-send-email-linux@roeck-us.net> <20150131164517.GB3088@htj.dyndns.org> <54CD0890.7050800@roeck-us.net> <20150131170812.GC3088@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150131170812.GC3088@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

On 01/31/2015 09:08 AM, Tejun Heo wrote:
> On Sat, Jan 31, 2015 at 08:53:36AM -0800, Guenter Roeck wrote:
>> I agree, it is weird, as is the whole "all API functions associated
>> with OF_ADDRESS are handled differently on sparc" thing. But that
>> is neither new nor something I can fix.
>
> Out of curiousity, why isn't the header file doing the following?
>
> #ifdef CONFIG_OF_ADDRESS
>
> void of_platform_device_create(blah);
> ...
>
> #else
>
> static inline void of_platform_device_create(blah)
> {
> }
>
> #endif
>

Maybe it is to ensure that the callers realize that the code won't
always work as intended, but I don't really know. It is kind of annoying,
though, since the resulting compile errors show up on a regular basis.
Mostly they are resolved by disabling the affected code for sparc,
but obviously that won't work here.

AFAIK this only affects sparc, all other architectures support OF_ADDRESS.

There was some discussion to get rid of OF_ADDRESS at some point,
so there is hope that this will get resolved. Until then all we can do
is to put in bandages.

Guenter
