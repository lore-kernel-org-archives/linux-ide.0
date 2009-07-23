From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 14:11:13 -0400
Message-ID: <4A68A7C1.2030302@pobox.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com> <4A67FF56.5040708@kernel.org> <4A6807A8.30403@pobox.com> <20090723072518.GA3545@sli10-desk.sh.intel.com> <4A68A6D1.4090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33178 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbZGWSL1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 14:11:27 -0400
In-Reply-To: <4A68A6D1.4090508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Tejun Heo <tj@kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Seems reasonable to me, though we may want to print something out during 
> device identification to indicate that we're using AA (like we do for 
> ATAPI AN).

Agreed -- the user needs some indication, somewhere, that this feature 
is enabled.

	Jeff


