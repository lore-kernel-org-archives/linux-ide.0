From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] Move various PCI IDs to header file
Date: Fri, 05 May 2006 16:09:19 +0200
Message-ID: <445B5C8F.80302@sgi.com>
References: <20060504180614.X88573@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:51672 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751548AbWEEOJ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 May 2006 10:09:27 -0400
In-Reply-To: <20060504180614.X88573@chenjesu.americas.sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>

Brent Casavant wrote:
> Move various QLogic, Vitesse, and Intel storage
> controller PCI IDs to the main header file.
> 
> Signed-off-by: Brent Casavant <bcasavan@sgi.com>

Acked-by: Jes Sorensen <jes@sgi.com>

After all I tend to get the blame for the qla1280 driver.

Cheers,
Jes
