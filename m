From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Wed, 27 Jan 2010 17:44:16 -0500
Message-ID: <4B60C1C0.8050402@teksavvy.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>	 <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>	 <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>	 <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>	 <20100127010204.7976c38b@lxorguk.ukuu.org.uk> <aacba7e1001261714n42a68824k62c411cd1e5d7893@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:22741 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756200Ab0A0WoS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jan 2010 17:44:18 -0500
In-Reply-To: <aacba7e1001261714n42a68824k62c411cd1e5d7893@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Rees <drees76@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

Vishal Rao wrote:
> http://pastebin.ubuntu.com/347122/
> 
> I'm running Ubuntu Lucid 10.04 alphas at the moment and note that even
> if I "successfully reproduce" the problem on my alternate hardware, its
> still the same particular disk which can't disprove that it's simply a
> single defective piece - the only thing stuck in my mind is Win7rc working
> fine so far while various other Linux distros have exhibited the same problem.
..

The errors in that log indicate bad media.
So the question is, can you demonstrate Win7rc NOT having the same
errors when accessing the SAME (logical) sectors ?

-ml
