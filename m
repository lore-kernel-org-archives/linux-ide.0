From: "Milo Medin " <mmedin@m2znetworks.com>
Subject: RE: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 17:13:34 -0700
Message-ID: <002101c8d658$4e9bf950$ebd3ebf0$@com>
References: <023701c8d4dd$d737fa10$85a7ee30$@com> <485F6830.1040000@pobox.com> <028401c8d549$7dfab390$79f01ab0$@com> <48609E28.8040300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exsmtp012-2.exch012.intermedia.net ([64.78.20.46]:35795 "HELO
	exsmtp012-2.exch012.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753365AbYFYANj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 20:13:39 -0400
In-Reply-To: <48609E28.8040300@pobox.com>
Content-Language: en-us
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <mlord@pobox.com>, 'Milo Medin' <medin@m2znetworks.com>
Cc: linux-ide@vger.kernel.org

Thanks.  Just to confirm, non highpoint 88SX7042 based cards don't have this issue right?  This seems silly for them to do such a thing, but some people like their management tools...

Thanks
Milo


-----Original Message-----
From: Mark Lord [mailto:mlord@pobox.com] 
Sent: Tuesday, June 24, 2008 12:12 AM
To: Milo Medin
Cc: linux-ide@vger.kernel.org
Subject: Re: FW: ICH10R PMP support

Milo Medin wrote:
> Mark, thanks very much for the reply.  Sounds like the 88SX7042 is a good solution.  A couple more questions:
> 
> 1) There seems to be talk on the mailing list about a bug where on highpoint controllers using this chip the controller corrupts some data on non-raid disk members.  I assume this is caused by the specific firmware on highpoint controllers using this chip, and that if I use a non highpoint version of the 88SX7042 that I won't see this problem.
..

The firmware on the Highpoint RAID cards unconditionally overwrites
sectors on any attached drives, before booting any O/S.

Never plug a drive that already has data on it into any Highpoint RAID card.
But for new drives, just partition around the firmware areas and you'll be fine.
There are notes (and a WARNING) in the driver source code regarding those.
Avoid sectors 1..63 (cannot boot from this controller as a result),
and avoid the final (full!) GB of each drive.

> 2) You said this is the best marvell solution for Linux at this time.  Is there a better SATA controller that I should be thinking about other than the 88SX7042?  I know the ICH9R's had good performance, but no FIS switching for PMP's.
..

Dunno.  I think everyone in the biz is going to AHCI style controllers now.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

