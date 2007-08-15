From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/4] Store interrupt value
Date: Wed, 15 Aug 2007 04:15:49 -0400
Message-ID: <46C2B635.70104@garzik.org>
References: <20070809211800.022150464@intel.com> <20070809142341.817322f1.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41718 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbXHOIPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:15:52 -0400
In-Reply-To: <20070809142341.817322f1.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: htejun@gmail.com, akpm@linux-foundation.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Kristen Carlson Accardi wrote:
> Use a stored value for which interrupts to enable.  Changing this allows
> us to selectively turn off certain interrupts later and have them 
> stay off.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

applied, after adding "ahci: " prefix to subject line


