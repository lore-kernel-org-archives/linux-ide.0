From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
Date: Wed, 22 Nov 2006 10:04:20 +0100
Message-ID: <1164186260.31358.717.camel@laptopd505.fenrus.org>
References: <1164149498.27730.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:16330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161995AbWKVJE1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Nov 2006 04:04:27 -0500
In-Reply-To: <1164149498.27730.17.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 14:51 -0800, Jason Gaston wrote:
> This patch adds the Intel ICH9 AHCI controller DID's for SATA support.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

there was some discussion about a generic class match for ahci...
would these devices be matched by that?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

