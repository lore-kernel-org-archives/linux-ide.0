From: Mark Lord <liml@rtr.ca>
Subject: Re: [rfc/patch] libata -- port configurable delays
Date: Fri, 13 May 2005 21:51:32 -0400
Message-ID: <428559A4.1060300@rtr.ca>
References: <20050513185850.GA5777@kvack.org> <4284FC6E.7060300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60172 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262675AbVENBva
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 May 2005 21:51:30 -0400
In-Reply-To: <4284FC6E.7060300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

PIIX chips should be fine w.r.t. unnecessary delays (or lack thereof).

I recall only one situation WAY BACK in time that had an issue with
continuous banging, but don't remember anything of the details
other than that this was circa 1995 or so.

Cheers
