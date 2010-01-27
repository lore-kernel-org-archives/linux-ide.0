From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Wed, 27 Jan 2010 06:44:10 +0530
Message-ID: <aacba7e1001261714n42a68824k62c411cd1e5d7893@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
	 <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
	 <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
	 <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>
	 <20100127010204.7976c38b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:54349 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab0A0BOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 20:14:11 -0500
In-Reply-To: <20100127010204.7976c38b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Rees <drees76@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

2010/1/27 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> It could even be a Linux side bug or some kind of complicated Linux
> timing thing. That *has* happened before with the older IDE stack, so we
> need to be cautious, collect reports and try to see patterns before
> jumping to conclusions - unless the vendor advises us otherwise.

Good, I'm hoping you folks have better clout in soliciting responses from
users and vendors. In the mean time that I'm going to take a couple of
days to find the time to test on a different machine, here is a month-old
output of "dmesg | grep ata1" if it helps any:

http://pastebin.ubuntu.com/347122/

I'm running Ubuntu Lucid 10.04 alphas at the moment and note that even
if I "successfully reproduce" the problem on my alternate hardware, its
still the same particular disk which can't disprove that it's simply a
single defective piece - the only thing stuck in my mind is Win7rc working
fine so far while various other Linux distros have exhibited the same problem.
