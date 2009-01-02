From: Tejun Heo <tj@kernel.org>
Subject: Re: Frozen drives when using SiI3726
Date: Fri, 02 Jan 2009 12:28:40 +0900
Message-ID: <495D89E8.2020307@kernel.org>
References: <20E60A0E-48E9-4942-851D-E20C012F5B89@ibink.com>	 <495894AB.8010404@kernel.org> <da824cf30812291120x1ed3f554lb7bdfe25427cecb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51071 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbZABD2v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 22:28:51 -0500
In-Reply-To: <da824cf30812291120x1ed3f554lb7bdfe25427cecb3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Tim Nufire <linux_ide_tim@ibink.com>, linux-ide@vger.kernel.org

Hello, Grant.

Grant Grundler wrote:
>> Also, the timeout is one of the most generic failure mode there is.
>> It can be triggered by virtually anything including transmission
>> failure, power quality issues, drive problems and whatnot.  So, it's
>> impossible to tell what went wrong with the provided information.
> 
> Tejun,
> The only other possible major issue not listed above I can think of is
> Sil3276 firmware rev. The data sheet (*) "EEPROM Speicifications"
> on Page 20 says the firmware is versioned.
> But the data sheet doesn't specify how to read it.

I haven't seen firmware related transmission failures yet but it's not
like I have lots of 3726s with different revision firmwares.

> Can you ask Silicon Image to publish how to read the firmware rev?

IIRC, you can read it from the steelvine management utility.  You'll
probably need a Windows installation tho.

> Also SATA_PMP_GSCR_REV  (Spec compliance, not FW rev) seems
> to be used twice:
> 
> include/linux/ata.h:
> #define sata_pmp_gscr_rev(gscr)         (((gscr)[SATA_PMP_GSCR_REV] >>
> 8) & 0xff)
> 
> drivers/ata/libata-pmp.c:sata_pmp_spec_rev_str()
> 
> Would it make sense to rename one or the other so they match?
> The difference is one returns a string and the other a u8 value.
> Both take the same parameter.

No, spec_rev_str() returns spec compliance string (lower bits) while
gscr_rev() returns revision level of port multiplier (whatever that
means).

Thanks.

-- 
tejun
