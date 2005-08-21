From: Mark Lord <mlord@pobox.com>
Subject: Re: A note on libata passthru patch
Date: Sun, 21 Aug 2005 17:44:27 -0400
Message-ID: <4308F5BB.8040506@pobox.com>
References: <4308F40E.3010109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:4748 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751155AbVHUVoe
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Aug 2005 17:44:34 -0400
In-Reply-To: <4308F40E.3010109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I'm certain there are lots of vendor-specific commands
that might assume exclusive bus access, if not exclusive
host access.  All of this makes a reasonable case for
having libata stop other host activity before/while
performing any passthru command.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

