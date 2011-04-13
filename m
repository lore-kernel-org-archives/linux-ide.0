From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: Re: sata link speed on amd hudson
Date: Wed, 13 Apr 2011 14:32:44 +0200
Message-ID: <BANLkTimqoMAUT84se3ZGCTMkn1+ZJWJTWA@mail.gmail.com>
References: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com>
 <20110403092911.GA5998@liondog.tnic> <BANLkTik73+OOOUVS8UKt=6erGbhSRFW3eg@mail.gmail.com>
 <1E8B869C0C6913418421A406C094DF7C011FEC7C@sshaexmb1.amd.com>
 <BANLkTik4uWvRKG_BoTz2y__b4bGGb4pk+Q@mail.gmail.com> <1E8B869C0C6913418421A406C094DF7C011FF4A1@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37676 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1DMMdE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Apr 2011 08:33:04 -0400
Received: by iwn34 with SMTP id 34so544439iwn.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2011 05:33:04 -0700 (PDT)
In-Reply-To: <1E8B869C0C6913418421A406C094DF7C011FF4A1@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org, "Petkov, Borislav" <Borislav.Petkov@amd.com>

Hi Shane,


>> Can this bit be ignored/overwritten by the driver in theory?
> I'm not quite sure, but anyway driver should not ignore/overwrite
> it to modify the platform's policy, which was decided by OEM and
> verified. We don't know any regression issue either.

I understand the reasoning, just want to make clear that the disk
performance I am seeing is way below what I had expected. Now I don't
know if there is SATA 3 Gbps to blame or not - but since both the
chipset and the drive claim to support it _and_ the drive's specs
would warrant 6 Gbps (afaics), I'd really want to give that a try.

running hdparm -t /dev/sda on a new Intel SSD 510 (120GB) gives here:
Timing buffered disk reads: 360 MB in 3.01 seconds = 119.66 MB/sec

The drive has an advertised sequential read performance of "up to 400
MB/s (6Gbps)" and a real-world test (on Anandtech) shows at least
232.1 MB/s of that..

Any suggestions?
