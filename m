From: Roland Dreier <rolandd@cisco.com>
Subject: Re: Another libata TODO item
Date: Wed, 24 Aug 2005 10:19:41 -0700
Message-ID: <52ll2rz1zm.fsf@cisco.com>
References: <430C10E7.9060502@pobox.com>
	<20050824074116.GF24513@infradead.org> <430C271E.7060006@pobox.com>
	<52d5o31fce.fsf@cisco.com> <430CA617.6090106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ams-iport-1.cisco.com ([144.254.224.140]:41646 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751233AbVHXRTu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Aug 2005 13:19:50 -0400
In-Reply-To: <430CA617.6090106@pobox.com> (Jeff Garzik's message of "Wed, 24
 Aug 2005 12:53:43 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

    Jeff> Look at net drivers.  Theres no real infrastructure beyond
    Jeff> bit tests and printks.  I wouldn't call that a subsystem,
    Jeff> so, I wouldn't call this one such either.

Well, scsi_logging.h isn't much of a subsystem either.

 - R.
