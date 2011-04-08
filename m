From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: sata link speed on amd hudson
Date: Fri, 8 Apr 2011 11:38:26 +0800
Message-ID: <1E8B869C0C6913418421A406C094DF7C011FEC7C@sshaexmb1.amd.com>
References: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com> <20110403092911.GA5998@liondog.tnic> <BANLkTik73+OOOUVS8UKt=6erGbhSRFW3eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:36082
	"EHLO AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757408Ab1DHDxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Apr 2011 23:53:41 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTik73+OOOUVS8UKt=6erGbhSRFW3eg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gottfried Haider <gottfried.haider@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-ide@vger.kernel.org, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

Hi Gottfried,

> I uploaded the files to http://sukzessiv.net/x120e - please
> let me know if you need any additional info or testing.

> ahci 0000:00:11.0: AHCI 0001.0200 32 slots 1 ports 3 Gbps

http://marc.info/?l=linux-ide&m=128990190301535&w=2
http://marc.info/?l=linux-ide&m=128996215115401&w=2

Most likely your issue is same as the one above.

To limit max SATA speed to 3 Gbps is decided by platform vendor
like Lenovo, though our south bridge silicon can support 6 Gbps.

BTW, do you find any BIOS option which can enable 6Gbps? suppose
the answer is "no"...


Thanks,
Shane

