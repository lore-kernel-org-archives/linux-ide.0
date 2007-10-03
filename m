From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: Sata Sil3512 bug?
Date: Wed, 03 Oct 2007 12:31:17 +0400
Message-ID: <47035355.2040405@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxnt.info ([212.158.162.2]:57852 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbXJCJH0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 05:07:26 -0400
In-Reply-To: <200710030726.l937QXuV026661@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: MisterE2002@zonnet.nl, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:

>>
>> I'm thinking of replacing both 3512 controllers with a Promise SATA300
>> TX4. Do you know if there are problems with this device?
> 
> (please don't top-post)
> 
> There are no known data-corruption issues with Promise SATA cards.
> However, some of them, especially the 2nd generation SATA300 TX4,
> are known to trigger intermittent error interrupts (that are dealt
> with but may cause a speed reduction) in some systems. We're still
> scratching our heads on that issue.
> 

But see this thread:

http://marc.info/?l=linux-ide&m=119122463403033&w=2
http://www.spinics.net/lists/linux-ide/msg14868.html

Personally I would not recommend Promise SATA300 TX4 at the moment.

-- 

./lxnt


