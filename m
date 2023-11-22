Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ermd5uac"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BD273E;
	Wed, 22 Nov 2023 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700655941; x=1732191941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVCT4/npLTdjlg5tixDfLXiqiZYzc2CLBiSEe1vpvPk=;
  b=ermd5uacni5beL/NzTxmMZPHhVVGw66OOI/DJuc+ZTSQKj2FaTD6wvnz
   mMvO7iqWo/5ftFjob/G3vR25veQa3UTzmsuTxa44LzCO9MraeGFQsbzhl
   e2mUcMDdyO/VFyjFatVJOpQigMJCyT9QVBa4xlTgFLO6md/wImxI6J1R9
   2fOoxGgD3h02valP4mYxXECJASQk/xsrs8JJI+ivVGUPnAtmkK01miSlD
   mGrgNO4qZ4RmnDZ1Bo/TxbbJqJr7OR99tWXrXWI1yt/yGdMoNlhoCnDv5
   k0bG83k1pPjhDoDr8pSLYKb4045BD3bMVcseptJ2i2Fqea+GKpZIeSOq+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10704213"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="10704213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:25:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857709524"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="857709524"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:25:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r5mIS-0000000G5Rf-0h7d;
	Wed, 22 Nov 2023 14:25:36 +0200
Date: Wed, 22 Nov 2023 14:25:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 21/39] ata: pata_ep93xx: add device tree support
Message-ID: <ZV3zP65l91aq6hNw@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-21-d59a76d5df29@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-21-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 22, 2023 at 11:59:59AM +0300, Nikita Shubin wrote:
> - add OF ID match table
> - drop platform DMA and filters
> - change DMA setup to OF, so we can defer probe

...

> +	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
> +	if (IS_ERR(drv_data->dma_rx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_rx_channel);
> +		return dev_err_probe(dev, ret, "rx DMA setup failed");
> +	}

PTR_ERR_OR_ZERO() as suggested in another patch?

...

> +	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
> +	if (IS_ERR(drv_data->dma_tx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_tx_channel);
> +		dev_err_probe(dev, ret, "tx DMA setup failed");
> +		goto fail_release_rx;
>  	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


