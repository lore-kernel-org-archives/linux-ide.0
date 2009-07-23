From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Fri, 24 Jul 2009 05:52:32 +0900
Message-ID: <4A68CD90.5000404@kernel.org>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com> <4A67FF56.5040708@kernel.org> <4A6807A8.30403@pobox.com> <20090723072518.GA3545@sli10-desk.sh.intel.com> <4A68A6D1.4090508@gmail.com> <4A68A7C1.2030302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42403 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbZGWUuW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 16:50:22 -0400
In-Reply-To: <4A68A7C1.2030302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Robert Hancock wrote:
>> Seems reasonable to me, though we may want to print something out
>> during device identification to indicate that we're using AA (like we
>> do for ATAPI AN).
> 
> Agreed -- the user needs some indication, somewhere, that this feature
> is enabled.

Also, the return value from ata_dev_set_feature() needs to be checked.
AC_ERR_DEV can be ignored.  Other errors should probably set
inhinit-AA bit and fail the current recovery trial.

Thanks.

-- 
tejun
