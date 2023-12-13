Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkaYmIf1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F8A7;
	Wed, 13 Dec 2023 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702491592; x=1734027592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HnMRtyfCaqa5qx++e5SRvsIJVqQa81BV0RtqDj1CTtk=;
  b=FkaYmIf1JfYsfqGyLCkdsTaoT6EY+CK3oQJns8y+lqGAxs1GymPiBRds
   T+/XeGqB9Ye7Vod6bym8Hc0gX7/KwTqQYOZI5fLb6sm+39rIKBMCTnpOB
   6M57V0EMwcS8XP1nNnJzeY+WRe4JHTO1LjqY4lsigdOUzTla3UItWALlH
   /rOUy0kxYRf91oM4dZwpLv37g3LY7cbQUkj4JagvqqtPkA4Ed5rKVBL70
   HmmUVrcGjJZEm1Drll/TQxyFkts3Dj/NpSjNQUpOzJqPp092XLBd1Z0uO
   GrgcRmUkZ0Nd+Xrt5MJIENL5DnKAA/rw2oWu+FKnV21yFES3Ncd41doLZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13704390"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="13704390"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808247705"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="808247705"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:19:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rDTpj-00000005bfy-2IrG;
	Wed, 13 Dec 2023 20:19:47 +0200
Date: Wed, 13 Dec 2023 20:19:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 22/40] ata: pata_ep93xx: add device tree support
Message-ID: <ZXn1w4hP4JitgdhS@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-22-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-22-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 11:20:39AM +0300, Nikita Shubin wrote:
> - add OF ID match table
> - drop platform DMA and filters
> - change DMA setup to OF, so we can defer probe

...

> +	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
> +	if (IS_ERR(drv_data->dma_rx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_rx_channel);
> +		return dev_err_probe(dev, ret, "rx DMA setup failed");
> +	}

See the comments to other patches about PTR_ERR_OR_ZERO() use and
returning dev_err_probe().

...

> +	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
> +	if (IS_ERR(drv_data->dma_tx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_tx_channel);
> +		dev_err_probe(dev, ret, "tx DMA setup failed");
> +		goto fail_release_rx;
>  	}

Ditto.

...

Seems like broken rebase or so as some of the latter changes in this file
should be done here.

-- 
With Best Regards,
Andy Shevchenko


