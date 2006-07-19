From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] The redefinition of ahci_start_engine()	andahci_stop_engine()
Date: Wed, 19 Jul 2006 16:47:34 -0400
Message-ID: <44BE9A66.9020103@pobox.com>
References: <1152769112.7132.327.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37516 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030301AbWGSUrm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 16:47:42 -0400
In-Reply-To: <1152769112.7132.327.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, hare@suse.de, axboe@suse.de, linux-ide@vger.kernel.org

applied patch 1

For the future, please make sure to follow rule #1 of 
http://linux.yyz.us/patch-format.html by including a subsystem name in 
your email subject lines, i.e.

ok:

	[PATCH 1/6] redefinition of ...

better:

	[PATCH 1/6] libata: redefinition of...

or:

	[PATCH 1/6] ahci: redefinition of...


