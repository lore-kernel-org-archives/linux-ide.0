From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: [opensuse-kernel] SSD / filesystem / TRIM
Date: Tue, 31 Aug 2010 08:51:02 -0400
Message-ID: <AANLkTinBG0CjPZe1+ViHp9ir95sPvJ=XADT2a3LdbF3i@mail.gmail.com>
References: <4C759825.60503@web.de>
	<AANLkTimrOOPExu+hU9wNubT3wgJWwUxMwjREn2p=x-qT@mail.gmail.com>
	<4C7A2949.8070606@web.de>
	<AANLkTinNt83RYu+ssRHzLT=E+Nk5kTk4Q+sfxQk5SP4+@mail.gmail.com>
	<4C7CF740.9040907@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59988 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab0HaMvD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2010 08:51:03 -0400
Received: by gyd8 with SMTP id 8so2497278gyd.19
        for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 05:51:03 -0700 (PDT)
In-Reply-To: <4C7CF740.9040907@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Thomas Hertweck <Thomas.Hertweck@web.de>, opensuse-kernel@opensuse.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Aug 31, 2010 at 8:36 AM, Mark Lord <kernel@teksavvy.com> wrote:
> On 10-08-30 03:14 PM, Greg Freemyer wrote:
>>
>> Mark, any thoughts why it didn't work. =A0Have you added anything
>> relevant to hdparm since v.9.28 that would help?
>
>
> It probably failed because it couldn't cope with the long trimlist
> that was fed to it. =A0That's the drive's fault, really.
>
> But the latest hdparm/wiper from sourceforge should fare better,
> as it now defaults to assuming the SSD cannot handle long trim lists.
>
> Cheers

Mark,

Does hdparm v.9.30 have any known kernel dependencies that would keep
it from working with 2.6.31?

Or any other known issues that would argue against opensuse pushing it
out as a software update for 11.2 and 11.3?

Or at least putting it in a OBS repo so people using wiper.sh/hdparm
can use the latest if they load if from the repo..

Thanks
Greg



--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
CNN/TruTV Aired Forensic Imaging Demo -
=A0=A0 http://insession.blogs.cnn.com/2010/03/23/how-computer-evidence-=
gets-retrieved/

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
