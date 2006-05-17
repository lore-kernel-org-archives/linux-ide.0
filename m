From: Michael Schierl <schierlm@gmx.de>
Subject: AHCI suspend works for me! (was: [ANNOUNCE] libata: new EH, NCQ,
 hotplug and PM patches against stable kernel)
Date: Wed, 17 May 2006 14:48:28 +0200
Message-ID: <446B1B9C.5090003@gmx.de>
References: <20060512132437.GB4219@htj.dyndns.org>	 <e4coc8$onk$1@sea.gmane.org> <4469E8CF.9030506@garzik.org>	 <4469EC4A.30908@gmx.de> <1147829339.7273.97.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:9418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932544AbWEQMs3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 08:48:29 -0400
In-Reply-To: <1147829339.7273.97.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

zhao, forrest schrieb:
>> And - what SATA ACPI patches?
>>
>> I have quite alot of patches related to sata and/or acpi (collected from
>> different mailing lists) here on hard disk but don't know which ones are
>> broken, outdated, etc. Most only apply on a 2.6.15 or 2.6.14-rc kernel...
>>
>> If more recent patches are only available via git, I'd need some good
>> GIT tutorial first...
>>
>> TIA, and sorry for stealing your time,
>>
>> Michael
> Michael,
> 
> I ported a patch from OpenSUSE for AHCI suspend/resume. You may find the
> patch at:
> y

I cannot see any patch in this mail...

However, the patch linked there "indirectly",

http://www.spinnaker.de/linux/c1320/sata-resume-2.6.16.5.patch

applies well on vanilla 2.6.16 (although not on top of the "new EH"
patch) and is the first one that really works (as far as I tested it).

I tested it on a minimal kernel (no network no sound no nothing); I'll
build a new "non-minimal" kernel now :) If I run into any problems; I'll
tell you.

Thank you.

Michael
