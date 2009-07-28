From: Jerome Vuarand <jerome.vuarand@gmail.com>
Subject: Re: SiI3124 + SiI3726 pm
Date: Tue, 28 Jul 2009 17:01:25 +0200
Message-ID: <89d273ba0907280801g1a6ee884u4e14eb65ab90fa13@mail.gmail.com>
References: <89d273ba0605242046x3d19dd06h74885048f229d519@mail.gmail.com>
	<89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com>
	<44753B78.4090802@gmail.com> <c70ff3ad0605251329m34af33bfj3ace5d5f9b32af38@mail.gmail.com>
	<44761994.2050303@gmail.com> <89d273ba0907271103s787b5f06t514c219d4a551d53@mail.gmail.com>
	<4A6E64A2.3010902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:42194 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbZG1PBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2009 11:01:47 -0400
Received: by ewy26 with SMTP id 26so91147ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2009 08:01:45 -0700 (PDT)
In-Reply-To: <4A6E64A2.3010902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, saeed bishara <saeed.bishara@gmail.com>

2009/7/28 Tejun Heo <htejun@gmail.com>:
> Jerome Vuarand wrote:
>> A few months ago I updated my kernel since it now supports port
>> multipliers without patch, and the issue of a supplementary port on
>> the SiI3727 port multiplier rose again. Since I completely forgot
>> about that 3 year old issue, I started exploring the web again befor=
e
>> remembering that thread.
>
> Hmm... this is supposed to be worked around by now.  Can you please
> post boot log w/o the patch using 2.6.30?

Yes, actually when about to apply the patch, I realized the 6th port
is actually recognized as the PMP SEMB. I guess the datasheet is
somewhat incorrect on that precise page, since it mentions the SEMB
device in other sections. The wiki is somewhat terse about PMP support
(for example it's not very clear what drivers and controller
combination support PMPs), and afaict there is no mention of SEMB
support status (I don't think my PMPs have something connected to the
I=C2=B2C port of the SiI3726, but that may be helpful to other people).

I moved all my disks to some spare PMP and all my disk detection
problems are gone. I guess some of them are really damaged (also I had
some power issue within my SATA enclosure).

Sorry for the noise :-)
