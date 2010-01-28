From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Thu, 28 Jan 2010 05:54:46 +0530
Message-ID: <aacba7e1001271624r4111908ch7a54e315ede54bbb@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
	 <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
	 <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
	 <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>
	 <20100127010204.7976c38b@lxorguk.ukuu.org.uk>
	 <aacba7e1001261714n42a68824k62c411cd1e5d7893@mail.gmail.com>
	 <4B60C1C0.8050402@teksavvy.com>
	 <aacba7e1001271516k3bb82a0fq7e019b28f3b8972f@mail.gmail.com>
	 <72dbd3151001271541l7026389fgd2c91f9ee6502472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42233 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab0A1AYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jan 2010 19:24:47 -0500
In-Reply-To: <72dbd3151001271541l7026389fgd2c91f9ee6502472@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Rees <drees76@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

2010/1/28 David Rees <drees76@gmail.com>:
>
> badblocks <name of partition>
>
> See the man page for more details, but that should do a read test -
> may want to boot from a rescue disk or from another disk if possible
> to run the test.

The first "badblocks /dev/sda7" run went ahead with no output.

Now running "badblocks -nv /dev/sda7" on this unmounted 20gb partition
and it's taking a little while for the nondestructive read+write test but
so far again no output indicating errors - will post full output shortly.

---

Yes, I'd come across this one - ran just the plain command first on
hopefully the same disk "areas" which initially had Arch and Fedora
partitions which also exhibited the same problem but I blew them away
and repartitioned/reformatted as ext4 from my ubuntu installation.

I trust (based on the man page) that badblocks re-checks any blocks
marked away by formatting (i didnt select the 'check bad blocks' option
during formatting via gparted) so the problem is not hidden?
