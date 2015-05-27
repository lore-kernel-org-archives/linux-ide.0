From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] ahci: Move interrupt enablement code to separate
 functions
Date: Wed, 27 May 2015 14:09:20 -0400
Message-ID: <20150527180920.GR7099@htj.duckdns.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
 <1432713693-4282-2-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34536 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbE0SJZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2015 14:09:25 -0400
Content-Disposition: inline
In-Reply-To: <1432713693-4282-2-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

Hello,

On Wed, May 27, 2015 at 10:01:31AM +0200, Robert Richter wrote:
> +static int ahci_init_intx(struct pci_dev *pdev, unsigned int n_ports,
> +			struct ahci_host_priv *hpriv)
> +{
>  	pci_intx(pdev, 1);
> +
>  	return 0;
>  }

Let's please not factor out the above as a separate function.  An one
lin function which always returns 0 doesn't really serve any purpose.

Thanks.

-- 
tejun
