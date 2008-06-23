From: Mark Lord <mlord@pobox.com>
Subject: Re: FW: ICH10R PMP support
Date: Mon, 23 Jun 2008 05:09:04 -0400
Message-ID: <485F6830.1040000@pobox.com>
References: <023701c8d4dd$d737fa10$85a7ee30$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYFWJJV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 05:09:21 -0400
In-Reply-To: <023701c8d4dd$d737fa10$85a7ee30$@com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Milo Medin <medin@m2znetworks.com>
Cc: linux-ide@vger.kernel.org

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
