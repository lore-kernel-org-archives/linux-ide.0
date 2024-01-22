Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239E16426
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909180; cv=none; b=oEdQDRbbFdxpJYvUpCD+y67Pa3itPj6O4zCs0HbGoaiQyKEs2l9slQHDWbObPSrbJluhAa7JmurTIt0pPVSFPjswjLlOjYTsbFhrbuqyMyQs0ep2kWL8Uoom7bXCQDo4vHNOe+MXJSTcleuqP+rq1hMhKnqQWrxufw52tPgUSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909180; c=relaxed/simple;
	bh=1YLwKg5BKYoqNToyVapYiHQayIoXv4396d7rUHJb7vU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nSvg+cUp5cuPEIdPbwahhhrwgHT+ZEHKtHT9xfKr07Dn89Ybzfhs4oi9C+HZ3uAbNRLx4S045JWRs4gjndDTgXWKD0OpOpIlxtEbSrC8La5soRHIjkaJgxNSL/1JL9AwihsB+Id2tvK3qw+XRhv+iw5cE6/OfkGpucHwINojkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWur+iBH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWur+iBH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76626170so33106545e9.2
        for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2024 23:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705909176; x=1706513976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WWozvUtTyFqrcPplojVaddKZbkwJqSzUWQNGORnmds=;
        b=WWur+iBHH+HO6jb6jRwkOvICUhK9eThe5qxoDi6y0wo3EEF0xCiDiKcjlYGjvyeklr
         oImXXih0WpRr6l4LEBOgOxhtWs4JZVF7LPKtab5+HEBwZwtzvZXtOdstH081xZZdrnmM
         a4+bMVIvS0UgA9Sduhf20Y9KrTVf3TyGgCTsy4o6ghD2yN2WsYby5t84Ib6y7Rx7l+2v
         b19RguKrPu61Iz3J5SduuwsqxwDFjbKnsz/cLwHDBCngCi0R1j6AKkQkYdDL4MuiNpFd
         Yr1LD913hLU7J3n89EYSTeKQkUoVI8J3RJL4lzi40iWfVzeM1Z69wXJ1mjis609dCTAm
         BV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909176; x=1706513976;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WWozvUtTyFqrcPplojVaddKZbkwJqSzUWQNGORnmds=;
        b=IEcILdD3yczj/pn0sQj5UU/nRy8XFifIeT9dW5kVr/B6a8lMpty5mVBJqT+fLRv7Vm
         B77g1jOeF/Mu9+/F6DkOpYRnZaj8v5dorPyxMHyGKyFDC3kpnQi3tX3S7y2T6sgj3PKL
         nlU+2pozJjJt/lqffSBGkoyr+XOtcgD7W/boYp7xpMkzeId4zdYUDVzikLUHGQ7xC2+D
         74diftE/Kefvg86GAEt0Pn+LGP3KqLqwCmJ0dkyvoEt9srQJVIwPj8YowN1UF7Yk6Dm4
         WtctGL2rgt8BAUX2OewNTnLIOld3po5VkKCu6rig+2ROQpXLHLjwTnwz6Bz2Q+rbEHsZ
         CptA==
X-Gm-Message-State: AOJu0Yx8hTevWm3KQVyon0dZWOXJF7fUINA/wvJ/maq5nQgfo2WMw0A4
	JePATotWC7mTRo5GID43vNFCfvLTKr/9OnCjXaLEQQ4F4UJxkTU0CEiJwvfpn60=
X-Google-Smtp-Source: AGHT+IF3f9HEyXHgZMkSmfxAJedCIp1k/7JyOqsL7kRQv+oTlau4JKHccMmhzoOsz3uboEZQdHAsIQ==
X-Received: by 2002:a05:600c:4e13:b0:40e:b086:f007 with SMTP id b19-20020a05600c4e1300b0040eb086f007mr108892wmq.51.1705909176062;
        Sun, 21 Jan 2024 23:39:36 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm37716986wmq.12.2024.01.21.23.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:39:35 -0800 (PST)
Date: Mon, 22 Jan 2024 10:39:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dlemoal@kernel.org, cassel@kernel.org, richardcochran@gmail.com,
	piyush.mehta@xilinx.com, axboe@kernel.dk, michal.simek@amd.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com,
	Piyush Mehta <piyush.mehta@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Message-ID: <7f18c22c-df5d-4eac-b67a-84c5802b8734@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>

Hi Radhey,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radhey-Shyam-Pandey/ata-ahci_ceva-fix-error-handling-for-Xilinx-GT-PHY-support/20240119-031129
base:   linus/master
patch link:    https://lore.kernel.org/r/1705604904-471889-2-git-send-email-radhey.shyam.pandey%40amd.com
patch subject: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY support
config: i386-randconfig-141-20240120 (https://download.01.org/0day-ci/archive/20240122/202401220603.dgjTZ08O-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401220603.dgjTZ08O-lkp@intel.com/

smatch warnings:
drivers/ata/ahci_ceva.c:335 ceva_ahci_probe() error: uninitialized symbol 'i'.

vim +/i +335 drivers/ata/ahci_ceva.c

a73ed35052ca85 Suneel Garapati      2015-06-09  192  static int ceva_ahci_probe(struct platform_device *pdev)
a73ed35052ca85 Suneel Garapati      2015-06-09  193  {
a73ed35052ca85 Suneel Garapati      2015-06-09  194  	struct device_node *np = pdev->dev.of_node;
a73ed35052ca85 Suneel Garapati      2015-06-09  195  	struct device *dev = &pdev->dev;
a73ed35052ca85 Suneel Garapati      2015-06-09  196  	struct ahci_host_priv *hpriv;
a73ed35052ca85 Suneel Garapati      2015-06-09  197  	struct ceva_ahci_priv *cevapriv;
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  198  	enum dev_dma_attr attr;
b1600f5880a13f Piyush Mehta         2024-01-19  199  	int rc, i;

i needs to be initialized to zero here.

a73ed35052ca85 Suneel Garapati      2015-06-09  200  
a73ed35052ca85 Suneel Garapati      2015-06-09  201  	cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
a73ed35052ca85 Suneel Garapati      2015-06-09  202  	if (!cevapriv)
a73ed35052ca85 Suneel Garapati      2015-06-09  203  		return -ENOMEM;
a73ed35052ca85 Suneel Garapati      2015-06-09  204  
a73ed35052ca85 Suneel Garapati      2015-06-09  205  	cevapriv->ahci_pdev = pdev;
a73ed35052ca85 Suneel Garapati      2015-06-09  206  
9a9d3abe24bb6b Piyush Mehta         2021-02-08  207  	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
9a9d3abe24bb6b Piyush Mehta         2021-02-08  208  								  NULL);
fa4b42b2a968dc Piyush Mehta         2021-03-05  209  	if (IS_ERR(cevapriv->rst))
fa4b42b2a968dc Piyush Mehta         2021-03-05  210  		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
fa4b42b2a968dc Piyush Mehta         2021-03-05  211  			      "failed to get reset\n");
9a9d3abe24bb6b Piyush Mehta         2021-02-08  212  
16af2d65842d34 Kunihiko Hayashi     2018-08-22  213  	hpriv = ahci_platform_get_resources(pdev, 0);
a73ed35052ca85 Suneel Garapati      2015-06-09  214  	if (IS_ERR(hpriv))
a73ed35052ca85 Suneel Garapati      2015-06-09  215  		return PTR_ERR(hpriv);
a73ed35052ca85 Suneel Garapati      2015-06-09  216  
9a9d3abe24bb6b Piyush Mehta         2021-02-08  217  	if (!cevapriv->rst) {
a73ed35052ca85 Suneel Garapati      2015-06-09  218  		rc = ahci_platform_enable_resources(hpriv);
a73ed35052ca85 Suneel Garapati      2015-06-09  219  		if (rc)
a73ed35052ca85 Suneel Garapati      2015-06-09  220  			return rc;

i is uninitialized on this path.

9a9d3abe24bb6b Piyush Mehta         2021-02-08  221  	} else {
9a9d3abe24bb6b Piyush Mehta         2021-02-08  222  		rc = ahci_platform_enable_clks(hpriv);
9a9d3abe24bb6b Piyush Mehta         2021-02-08  223  		if (rc)
9a9d3abe24bb6b Piyush Mehta         2021-02-08  224  			return rc;
9a9d3abe24bb6b Piyush Mehta         2021-02-08  225  		/* Assert the controller reset */
9a9d3abe24bb6b Piyush Mehta         2021-02-08  226  		reset_control_assert(cevapriv->rst);
9a9d3abe24bb6b Piyush Mehta         2021-02-08  227  
9a9d3abe24bb6b Piyush Mehta         2021-02-08  228  		for (i = 0; i < hpriv->nports; i++) {
9a9d3abe24bb6b Piyush Mehta         2021-02-08  229  			rc = phy_init(hpriv->phys[i]);
b1600f5880a13f Piyush Mehta         2024-01-19  230  			if (rc) {
b1600f5880a13f Piyush Mehta         2024-01-19  231  				while (--i >= 0)
b1600f5880a13f Piyush Mehta         2024-01-19  232  					phy_exit(hpriv->phys[i]);
b1600f5880a13f Piyush Mehta         2024-01-19  233  				goto disable_clks;
b1600f5880a13f Piyush Mehta         2024-01-19  234  			}
9a9d3abe24bb6b Piyush Mehta         2021-02-08  235  		}
9a9d3abe24bb6b Piyush Mehta         2021-02-08  236  
9a9d3abe24bb6b Piyush Mehta         2021-02-08  237  		/* De-assert the controller reset */
9a9d3abe24bb6b Piyush Mehta         2021-02-08  238  		reset_control_deassert(cevapriv->rst);
9a9d3abe24bb6b Piyush Mehta         2021-02-08  239  
9a9d3abe24bb6b Piyush Mehta         2021-02-08  240  		for (i = 0; i < hpriv->nports; i++) {
9a9d3abe24bb6b Piyush Mehta         2021-02-08  241  			rc = phy_power_on(hpriv->phys[i]);
9a9d3abe24bb6b Piyush Mehta         2021-02-08  242  			if (rc) {
9a9d3abe24bb6b Piyush Mehta         2021-02-08  243  				phy_exit(hpriv->phys[i]);
b1600f5880a13f Piyush Mehta         2024-01-19  244  				goto disable_phys;
9a9d3abe24bb6b Piyush Mehta         2021-02-08  245  			}
9a9d3abe24bb6b Piyush Mehta         2021-02-08  246  		}
9a9d3abe24bb6b Piyush Mehta         2021-02-08  247  	}
a73ed35052ca85 Suneel Garapati      2015-06-09  248  
a73ed35052ca85 Suneel Garapati      2015-06-09  249  	if (of_property_read_bool(np, "ceva,broken-gen2"))
a73ed35052ca85 Suneel Garapati      2015-06-09  250  		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
a73ed35052ca85 Suneel Garapati      2015-06-09  251  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  252  	/* Read OOB timing value for COMINIT from device-tree */
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  253  	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  254  					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  255  		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  256  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  257  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  258  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  259  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  260  	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  261  					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  262  		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  263  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  264  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  265  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  266  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  267  	/* Read OOB timing value for COMWAKE from device-tree*/
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  268  	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  269  					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  270  		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  271  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  272  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  273  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  274  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  275  	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  276  					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  277  		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  278  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  279  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  280  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  281  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  282  	/* Read phy BURST timing value from device-tree */
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  283  	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  284  					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  285  		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  286  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  287  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  288  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  289  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  290  	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  291  					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  292  		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  293  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  294  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  295  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  296  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  297  	/* Read phy RETRY interval timing value from device-tree */
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  298  	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  299  					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  300  		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  301  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  302  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  303  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  304  
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  305  	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  306  					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  307  		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
b1600f5880a13f Piyush Mehta         2024-01-19  308  		rc = -EINVAL;
b1600f5880a13f Piyush Mehta         2024-01-19  309  		goto disable_phys;
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  310  	}
fe8365bbf8ac58 Anurag Kumar Vulisha 2017-08-21  311  
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  312  	/*
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  313  	 * Check if CCI is enabled for SATA. The DEV_DMA_COHERENT is returned
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  314  	 * if CCI is enabled, so check for DEV_DMA_COHERENT.
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  315  	 */
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  316  	attr = device_get_dma_attr(dev);
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  317  	cevapriv->is_cci_enabled = (attr == DEV_DMA_COHERENT);
3bc867de85b5bf Anurag Kumar Vulisha 2017-08-21  318  
a73ed35052ca85 Suneel Garapati      2015-06-09  319  	hpriv->plat_data = cevapriv;
a73ed35052ca85 Suneel Garapati      2015-06-09  320  
a73ed35052ca85 Suneel Garapati      2015-06-09  321  	/* CEVA specific initialization */
a73ed35052ca85 Suneel Garapati      2015-06-09  322  	ahci_ceva_setup(hpriv);
a73ed35052ca85 Suneel Garapati      2015-06-09  323  
a73ed35052ca85 Suneel Garapati      2015-06-09  324  	rc = ahci_platform_init_host(pdev, hpriv, &ahci_ceva_port_info,
a73ed35052ca85 Suneel Garapati      2015-06-09  325  					&ahci_platform_sht);
a73ed35052ca85 Suneel Garapati      2015-06-09  326  	if (rc)
a73ed35052ca85 Suneel Garapati      2015-06-09  327  		goto disable_resources;
a73ed35052ca85 Suneel Garapati      2015-06-09  328  
a73ed35052ca85 Suneel Garapati      2015-06-09  329  	return 0;
a73ed35052ca85 Suneel Garapati      2015-06-09  330  
a73ed35052ca85 Suneel Garapati      2015-06-09  331  disable_resources:
a73ed35052ca85 Suneel Garapati      2015-06-09  332  	ahci_platform_disable_resources(hpriv);
b1600f5880a13f Piyush Mehta         2024-01-19  333  
b1600f5880a13f Piyush Mehta         2024-01-19  334  disable_phys:
b1600f5880a13f Piyush Mehta         2024-01-19 @335  	while (--i >= 0) {
                                                               ^^^

b1600f5880a13f Piyush Mehta         2024-01-19  336  		phy_power_off(hpriv->phys[i]);
b1600f5880a13f Piyush Mehta         2024-01-19  337  		phy_exit(hpriv->phys[i]);
b1600f5880a13f Piyush Mehta         2024-01-19  338  	}
b1600f5880a13f Piyush Mehta         2024-01-19  339  
b1600f5880a13f Piyush Mehta         2024-01-19  340  disable_clks:
b1600f5880a13f Piyush Mehta         2024-01-19  341  	ahci_platform_disable_clks(hpriv);
b1600f5880a13f Piyush Mehta         2024-01-19  342  
a73ed35052ca85 Suneel Garapati      2015-06-09  343  	return rc;
a73ed35052ca85 Suneel Garapati      2015-06-09  344  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

