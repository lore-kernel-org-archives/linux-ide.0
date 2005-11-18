From: linux@horizon.com
Subject: sata_sil24 corruption FIXED by motherboard swap
Date: 17 Nov 2005 21:23:49 -0500
Message-ID: <20051118022349.12316.qmail@science.horizon.com>
References: <87f94c370511141530h1c2d64e6kdb512f54c3c7b981@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:39230 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750785AbVKRCX7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Nov 2005 21:23:59 -0500
In-Reply-To: <87f94c370511141530h1c2d64e6kdb512f54c3c7b981@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org
Cc: linux@horizon.com

For anybody who's been following my saga, what I thought was software
problems turned out to be a hardware problem with one PCI-express slot
on an Albatron K8NF4U motherboard.  (Whose support folks still haven't
gotten back to me...)

I swapped in a new motherboard this morning, and have been running disk
tests all afternoon with no problems.

My sincere apologies for the false alarm.
