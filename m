From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc (drivers/ide/ppc/pmac.c)
Date: Tue, 16 Aug 2005 14:11:24 -0400
Message-ID: <C2F63384-9CC2-4979-956B-8CB5DA77F4AE@mac.com>
References: <E1E13vT-0008G7-R1@arda.LT-P.net> <20050808085703.GE18551@verge.net.au> <20050814005430.2e26e627@arda.LT-P.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout.mac.com ([17.250.248.46]:16893 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030276AbVHPSLj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 14:11:39 -0400
In-Reply-To: <20050814005430.2e26e627@arda.LT-P.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LT-P <LT-P@LT-P.net>
Cc: Horms <horms@debian.org>, 321442@bugs.debian.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Aug 13, 2005, at 18:54:30, LT-P wrote:
> Le lun 08 ao=FB 2005 17:57:04 CEST, Horms <horms@debian.org> a =E9cri=
t:
>> Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolves =20
>> your
>> problem. If it does, then the following patch should fix Kconfig
>> so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_PMAC
>> to be enabled. It should patch cleanly against Debian's 2.6.8 and
>> Linus' current Git tree.
> It seems to solve the problem, thanks.
> Sometimes, I feel like I am the only person in the world to compile =20
> the kernel on
> powerpc... :)

Actually, I ran into this same bug a day or so ago when updating to =20
2.6.13-rc6,
it's just I noticed the error, fixed my config, then recompiled and =20
forgot
about it completely until now :-D.  Thanks for the bug report, though!

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you =20
looked at
it in the right way, did not become still more complicated.
   -- Poul Anderson



