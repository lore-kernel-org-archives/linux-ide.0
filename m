From: Michael Schierl <schierlm@gmx.de>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G -- SATA
Date: Tue, 21 Mar 2006 16:37:03 +0100
Message-ID: <44201D9F.7090701@gmx.de>
References: <44076762.404@gmx.de> <1141349791.19013.1.camel@sli10-desk.sh.intel.com> <441EF7B8.4040901@gmx.de> <441F04D6.4070404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <441F04D6.4070404@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:

>> I copy all stuff need into tmpfs to ensure that it can restore the video
>> without hard disk access.
>
> OOhh.. clever, wish I'd thought of that,

One should not forget to disable swap first :)

> as all of my (now solved) suspend/resume issues
> were *all* libata related.

So I guess it is a good idea to get SATA working first, isn't it?

>> What to do, what to test?
>
> Randy Dunlop's libata-acpi patch might work for you.
> http://www.xenotime.net/linux/SATA/

I tried the 2.6.16-rc4 patches on 2.6.16 (one hunk did not apply in
libata.h, but I think I was able to fix it manually). Before suspend it
works well, after suspend it does not work. Seems that the timeout is
longer with the patch, though. I tried it several times; once it seemed
to have worked, but it was not reproducible (and it did not work any
longer after the next suspend), so I guess it could be just that I only
tried files already in cache. (Or alternatively, the patch has a success
rate of maybe 5%...)

"Just for fun" i tried the 2.6.15 patches on 2.6.15, but it did not even
boot.

BTW: It is an Intel AHCI controller.

Any other ideas/patches?

Michael
