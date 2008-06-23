From: "Milo Medin" <medin@m2znetworks.com>
Subject: RE: FW: ICH10R PMP support
Date: Mon, 23 Jun 2008 08:54:59 -0700
Message-ID: <028401c8d549$7dfab390$79f01ab0$@com>
References: <023701c8d4dd$d737fa10$85a7ee30$@com> <485F6830.1040000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exsmtp012-2.exch012.intermedia.net ([64.78.20.46]:21534 "HELO
	exsmtp012-2.exch012.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754922AbYFWPzH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 11:55:07 -0400
In-Reply-To: <485F6830.1040000@pobox.com>
Content-Language: en-us
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org

Mark, thanks very much for the reply.  Sounds like the 88SX7042 is a good solution.  A couple more questions:

1) There seems to be talk on the mailing list about a bug where on highpoint controllers using this chip the controller corrupts some data on non-raid disk members.  I assume this is caused by the specific firmware on highpoint controllers using this chip, and that if I use a non highpoint version of the 88SX7042 that I won't see this problem.

2) You said this is the best marvell solution for Linux at this time.  Is there a better SATA controller that I should be thinking about other than the 88SX7042?  I know the ICH9R's had good performance, but no FIS switching for PMP's.

Thanks again...

Milo


-----Original Message-----
From: Mark Lord [mailto:mlord@pobox.com] 
Sent: Monday, June 23, 2008 2:09 AM
To: Milo Medin
Cc: linux-ide@vger.kernel.org
Subject: Re: FW: ICH10R PMP support

Milo Medin wrote:
> Mark, Tejun suggested I query you about your thoughts re: the Marvell 88SX7042 or the 88SE6145 SATA controllers when connected with FIS based port multipliers? 
> 
> Based on Intel's announcements last year for the ICH10R where they claimed they were going to implement FIS support for port multipliers, I had planned on rebuilding a Linux based NAS system using a P45 board and ICH10R, but it seems they didn't end up implementing FIS support in the ICH10 series after all (nice of them to neglect to mention that to the community after announcing that feature in the roadmap).  
> 
> So now I'm looking for a different solution.  I currently use SI3132 based SATA controllers, but they seem to have some performance issues, and folks seem to be reporting good performance with at least the 88SX7042 part under windows, hence the question.
..

I don't know anything about the 88SE6145 (isn't that an AHCI clone?),
but the 7042 chip under Linux is *now* a very safe (and good) bet.

It has full kernel support for hot-plug, PMP with FIS-based switching,
and employs a decent host command queue mechansim.  I believe all of the
errata workarounds are now in place for this chip.

Performance is about as good as it gets under Linux,
though there's still another microsecond or so to be shaved
away from the IRQ handling in the next cycle.

Message-Switched-Interrupts (MSI) is there, but not fully supported yet.
This also will likely get cleaned up in the next cycle.

The 7042 is the best of the Marvell chips, for Linux.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

