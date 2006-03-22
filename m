From: Ian Oliver <lists@foxhill.co.uk>
Subject: Re: Problems with multiple Promise SATA150 TX4 cards
Date: Wed, 22 Mar 2006 17:26:35 GMT
Message-ID: <VA.00001c03.000fc5fe@foxhill.co.uk>
References: <43D66681.708@dgreaves.com>
Reply-To: linux-ide@vger.kernel.org
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.tidymail.co.uk ([217.146.107.7]:54963 "EHLO
	relay2.tidymail.co.uk") by vger.kernel.org with ESMTP
	id S1751022AbWCVR0i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Mar 2006 12:26:38 -0500
Received: from ioliver.adsl.wizards.co.uk ([217.146.109.248] helo=foxhill.co.uk)
	(from_AS 16353)
	by relay2.tidymail.co.uk with esmtpa
	(Exim 4.52)
	id 1FM76R-0007vf-5d
	for linux-ide@vger.kernel.org
	(return-path <lists@foxhill.co.uk>); Wed, 22 Mar 2006 17:26:35 +0000
In-Reply-To: <43D66681.708@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In article <43D66681.708@dgreaves.com>, David Greaves wrote:
> PS Of course it may just be a slew of people with PSU problems...

I fixed my Promise lockup problems (DriveStatusError when hammering the 
drivers and the odd lock solid) by ditching the 4x two-port Promise 
SATA  cards and fitting 2x four-port SiL cards. Same PSUs.

Regards

Ian



