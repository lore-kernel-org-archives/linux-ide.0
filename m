From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: Re: sata link speed on amd hudson
Date: Fri, 8 Apr 2011 12:18:37 +0200
Message-ID: <BANLkTik4uWvRKG_BoTz2y__b4bGGb4pk+Q@mail.gmail.com>
References: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com>
 <20110403092911.GA5998@liondog.tnic> <BANLkTik73+OOOUVS8UKt=6erGbhSRFW3eg@mail.gmail.com>
 <1E8B869C0C6913418421A406C094DF7C011FEC7C@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35586 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1DHKS7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 06:18:59 -0400
Received: by iwn34 with SMTP id 34so3327362iwn.19
        for <linux-ide@vger.kernel.org>; Fri, 08 Apr 2011 03:18:58 -0700 (PDT)
In-Reply-To: <1E8B869C0C6913418421A406C094DF7C011FEC7C@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org, "Petkov, Borislav" <Borislav.Petkov@amd.com>

Hi Shane,


>> ahci 0000:00:11.0: AHCI 0001.0200 32 slots 1 ports 3 Gbps
>
> http://marc.info/?l=linux-ide&m=128990190301535&w=2
> http://marc.info/?l=linux-ide&m=128996215115401&w=2
>
> Most likely your issue is same as the one above.
>
> To limit max SATA speed to 3 Gbps is decided by platform vendor
> like Lenovo, though our south bridge silicon can support 6 Gbps.

Can this bit be ignored/overwritten by the driver in theory?
How would you go on contacting the BIOS people working for Lenovo?

> BTW, do you find any BIOS option which can enable 6Gbps? suppose
> the answer is "no"...

nope, there is none.

thanks,
Gottfried
