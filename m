From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] libata-sff: remove dead code
Date: Wed, 07 May 2014 12:00:06 +0200
Message-ID: <1399456806.6659.20.camel@x220>
References: <1399204229.8729.15.camel@x220>
	 <1399411616.2458.45.camel@acox1-desk.ger.corp.intel.com>
	 <1399454604.6659.13.camel@x220>
	 <1399456196.2458.53.camel@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:54875 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598AbaEGKAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2014 06:00:09 -0400
In-Reply-To: <1399456196.2458.53.camel@acox1-desk.ger.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-05-07 at 10:49 +0100, Alan Cox wrote:
> Unless you are editing the config with out of tree changes. Which is
> possible which is why I said ask Dave. It's probably fine but best to be
> safe.

If you mean adding a "config NO_ATA_LEGACY" entry to some Kconfig file,
and setting that symbol during "make *config", that will obviously work.

But if you mean (hand) editing the .config, that wouldn't work, as the
line for CONFIG_NO_ATA_LEGACY would be dropped during "make *config",
wouldn't it?


Paul Bolle

