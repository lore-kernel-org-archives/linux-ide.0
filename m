From: Mark Lord <mlord@pobox.com>
Subject: Re: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 03:11:36 -0400
Message-ID: <48609E28.8040300@pobox.com>
References: <023701c8d4dd$d737fa10$85a7ee30$@com>
 <485F6830.1040000@pobox.com> <028401c8d549$7dfab390$79f01ab0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbYFXHLx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 03:11:53 -0400
In-Reply-To: <028401c8d549$7dfab390$79f01ab0$@com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Milo Medin <medin@m2znetworks.com>
Cc: linux-ide@vger.kernel.org

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
