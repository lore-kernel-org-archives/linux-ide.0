From: Ian Oliver <lists@foxhill.co.uk>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Thu, 13 Oct 2005 21:37:07 +0100
Message-ID: <VA.00001a56.00ccc058@foxhill.co.uk>
References: <1128595485.5964.41.camel@localhost.localdomain>
Reply-To: linux-ide@vger.kernel.org
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.tidymail.co.uk ([217.146.107.7]:26824 "EHLO
	relay2.tidymail.co.uk") by vger.kernel.org with ESMTP
	id S964801AbVJMUhU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Oct 2005 16:37:20 -0400
Received: from ioliver.adsl.wizards.co.uk ([217.146.109.248] helo=foxhill.co.uk)
	(from_AS 16353)
	by relay2.tidymail.co.uk with esmtpa
	(Exim 4.52)
	id 1EQ9pA-0004Y9-Pb
	for linux-ide@vger.kernel.org; Thu, 13 Oct 2005 20:37:12 +0000
In-Reply-To: <1128595485.5964.41.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In article <1128595485.5964.41.camel@localhost.localdomain>, Erik 
Slagter wrote:
> That's not really a solution ;-) It looks you're also a victim of the
> promise problem.

For sale, 4x Promise TX2 (20375 based) cards, some light bullet damage 
that should polish out. :-)

To elaborate, my fix of pulling two of the cards just made the problem 
occur less often. But when the machine did eventually lock solid again, 
it then needed to resync the raid 5 on reboot. As soon as the smart 
demon kicked in with this level of activity, the machine locked solid. 
I rebooted with the raid arrays pulled, disabled all things "smart", 
and then rebooted.

I could then boot, enjoy a working server, and open some wine. Quite 
close to the bottom of the bottle, the sodding thing locked again. It's 
now running with only one raid array, which is now re-cabled to the SiL 
3114 and is rebuilding rather nicely (and far faster than on the 
Promise cards)

Assuming that all is sweetness and light, I will, 1) Order another SiL 
card, 2) Subject the Promise cards to physical abuse, 3) Move on to 
whisky, in no particular order.

For the record, this is with Ubuntu 5.04 (Hoary) with all repo updates 
as of last weekend.

Regards

Ian



