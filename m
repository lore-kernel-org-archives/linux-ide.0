From: Mark Lord <liml@rtr.ca>
Subject: Re: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 17:38:36 -0400
Message-ID: <4328985C.4000207@rtr.ca>
References: <43277485.6030802@yahoo.de>	 <1126690298.4248.44.camel@localhost.localdomain>	 <4327FB2C.5000207@yahoo.de>	 <1126694013.4248.49.camel@localhost.localdomain>	 <4327FEE7.7020707@yahoo.de>  <43281B5E.2090702@bouton.name> <1126702271.4248.56.camel@localhost.localdomain> <43284126.8040007@rtr.ca> <432843E5.1060209@bouton.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:25836 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932774AbVINVii
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 17:38:38 -0400
In-Reply-To: <432843E5.1060209@bouton.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lionel Bouton <lionel-subscription@bouton.name>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

Lionel Bouton wrote:
> Mark Lord wrote the following on 14.09.2005 17:26 :
>> These flash sticks, along with CF and SD cards, all include
>> built-in controllers that do automatic wear-leveling.
> 
> Do they all have such controllers now? Last time I checked, low quality 
> parts didn't have them and it wasn't easy to verify which ones did.

Pretty much all of them use NAND flash, which comes with 1-3%
bad blocks from the factory.  So the onboard controllers already
have to deal with *that* issue, and the same remapping logic is
normally extended to allow them to do wear leveling as well.

Wear leveling is imperfect, in that they devices can only include
sectors *known* by the *device* to be inactive, so as files are
written and deleted many sectors are removed from the wear rotation
until the next time they are logically rewritten (or until a CFA ERASE
command, which Linux never does.  Sad.).

Cannot say for sure whether 100% of controllers are adequately intelligent,
but that kind of control logic is pretty pervasive these days.
It would be a very rare device indeed that lacks it.

Cheers
