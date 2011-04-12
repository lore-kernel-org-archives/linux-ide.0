From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: sata link speed on amd hudson
Date: Tue, 12 Apr 2011 21:32:42 +0800
Message-ID: <1E8B869C0C6913418421A406C094DF7C011FF4A1@sshaexmb1.amd.com>
References: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com> <20110403092911.GA5998@liondog.tnic> <BANLkTik73+OOOUVS8UKt=6erGbhSRFW3eg@mail.gmail.com> <1E8B869C0C6913418421A406C094DF7C011FEC7C@sshaexmb1.amd.com> <BANLkTik4uWvRKG_BoTz2y__b4bGGb4pk+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:13493
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754952Ab1DLNdH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Apr 2011 09:33:07 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTik4uWvRKG_BoTz2y__b4bGGb4pk+Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gottfried Haider <gottfried.haider@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

Hi Gottfried,

> Can this bit be ignored/overwritten by the driver in theory?

I'm not quite sure, but anyway driver should not ignore/overwrite
it to modify the platform's policy, which was decided by OEM and
verified. We don't know any regression issue either.


> How would you go on contacting the BIOS people working for Lenovo?

Sorry, I don't have the contact window to Lenovo BIOS...


Thanks,
Shane


