From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: libata-passthrough problem.
Date: Sun, 13 Nov 2005 20:17:53 +0000
Message-ID: <43779F71.2080000@superbug.demon.co.uk>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <4376786F.2090503@pobox.com> <43767D75.6090204@rtr.ca> <43775815.2090204@superbug.demon.co.uk> <43777183.5030208@rtr.ca> <437771FB.3020704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:49165 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750710AbVKMVRp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Nov 2005 16:17:45 -0500
In-Reply-To: <437771FB.3020704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> And again, as an attachment, for people with modern mail clients.
> 
> Cheers
> 

Thank you

I have tested the patch against 2.6.15-rc1, and it seems to work fine.
Notice the different model numbers and serial numbers below, when before 
they were identical.


# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
	Model Number:       ST3300831AS
	Serial Number:      3NF0A9CQ
	Firmware Revision:  3.01

# hdparm -I /dev/sdb

/dev/sdb:

ATA device, with non-removable media
	Model Number:       ST3160023AS
	Serial Number:      3JS2ZRPZ
	Firmware Revision:  3.18

