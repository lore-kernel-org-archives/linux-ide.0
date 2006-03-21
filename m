From: "martin schneebacher" <masc@operamail.com>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G -- SATA
Date: Tue, 21 Mar 2006 17:25:47 +0100
Message-ID: <20060321162547.D6F51CA0A4@ws5-11.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Michael Schierl <schierlm@gmx.de>, Mark Lord <liml@rtr.ca>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

hi!

> ----- Original Message -----
> From: "Michael Schierl" <schierlm@gmx.de>
> To: "Mark Lord" <liml@rtr.ca>
> Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G -- SATA
> Date: 	Tue, 21 Mar 2006 16:37:03 +0100
> > Randy Dunlop's libata-acpi patch might work for you.
> > http://www.xenotime.net/linux/SATA/
> 
> I tried the 2.6.16-rc4 patches on 2.6.16 (one hunk did not apply in
> libata.h, but I think I was able to fix it manually). Before suspend it
> works well, after suspend it does not work. Seems that the timeout is
> longer with the patch, though. I tried it several times; once it seemed
> to have worked, but it was not reproducible (and it did not work any
> longer after the next suspend), so I guess it could be just that I only
> tried files already in cache. (Or alternatively, the patch has a success
> rate of maybe 5%...)
> 
> "Just for fun" i tried the 2.6.15 patches on 2.6.15, but it did not even
> boot.
> 
> BTW: It is an Intel AHCI controller.
> 
> Any other ideas/patches?

have you ever tried the sata_pm patch from http://tpctl.sourceforge.net/tmp/sata_pm.2.6.15-rc6.patch ?
i have a intel SATA ICH6M interface and it works fine with this patch.

bye...masc.



-- 
_______________________________________________
Surf the Web in a faster, safer and easier way:
Download Opera 8 at http://www.opera.com

Powered by Outblaze
