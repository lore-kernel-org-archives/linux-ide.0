Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646928;
	b=4TafBpHfg9dOAPoPz+sc/RNdIT+nuBxqoaH/89mhiEgGjV158XfgYJLelJyrBqBDUVQl
	 snioXjIK6vhiYcxI+vxFccalpxOhYO0XxIdl+AYjY1+fk8Ar5wW904cyWgDXgOnFRIQDW
	 lM2KLt1Cl/JJIEutKtcirit7iKZ+LqrvE87sHidP0resKZFLe7M6cUgYdeUBtgrTyxewx
	 hRw+Bkrtq++MbWW4tKdxbGknq1YD+DjlZNlhPhWpX0bSf1pn+p5GcNqjXOLsfqPghlLF+
	 D6A4Seapm1WL8j/6eZC0G0nj+1G9/TSGM5W71kS8PhUhWNR9/UKlYRlFmT5VN83AJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YDsDCXLkXL3cNo22jNaL7+utbyOJuM3+sdQzz79cB1A=;
	b=48GaTgYZkvYp7+KxO7ifS5KZ81o04NGrjMA61Cj+sOJTX5gojHQepr55OFcNoQPjHpwG
	 kO9bUX1Wil9j9002Rm0QaQTU+KupUCbxKfESGuo61rGPZwG5FtIub4bZEpalNHn2ZtD01
	 0qaX12eKChgDEDBRC2rmulAlwPnbBE6WTH4NvB7wvQH4DNOKWZ/ZKOpP6BP5wASoJU0I2
	 hBOctmhVx8w8rS823CmV9NwfNcz3R3vpH2BxiwTt1KB1CyCJGw84/iLQCPUrzmctZHwsI
	 3Uu80pxb9SlnypZBgBhbLKN/0/oqpUkTxfI1BL+KGsHwOLjArj/xKJR0Wm8VG6DU2QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHhUDsm3;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B4606A6B6
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 22:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17B4606A6B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHhUDsm3
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso2716142a91.2
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795646926; x=1796251726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YDsDCXLkXL3cNo22jNaL7+utbyOJuM3+sdQzz79cB1A=;
        b=lHhUDsm3vzYxbrG0XKMHpULVIRUum6mQ2gyPAuoK9IQgAQ94X3IXkwhla9s9ac0/ar
         zxJESCPJbraVYEhyqdQzsE4Vhp48XYK8zEeYSQjwUPqKPKvOCqX3GPwMWe82PhP8uHMj
         O1jOXSnR9sTWpVtbFr6ptxyGM3tIOGbh3leES2Rh3ziQe4x1WnMDk88dXg1um6Fgu446
         IHiVmFt4YKFpBhn3n/D8e3a3jHsSDkHXpPTa0P5f4HvsGDmJfRcyzd0L1VF+Ppah8klJ
         MLICsutSRHytfv9zlJCgUL8z/5nvc678T4dYuYzY2AKebt4yVd8XOs5T6scTQbPnaUQ0
         o+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646926; x=1796251726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDsDCXLkXL3cNo22jNaL7+utbyOJuM3+sdQzz79cB1A=;
        b=K8fi0PCvs8XvXGExltSgnT/O1xSRoIGWTCS+iBWGhtV8qhubdNOfZhIy6hyYykNODA
         ExM4VjaDTDTJ4U8hse5+WEfT6cAUbintIC9f4ZbEi82vXrCRzpW+7N00VtbGxRwwiTE+
         L7FtQspgUIriFpsowAQNj4nfqlfqZ0+vNKo7wTwnlNAgazElWNNMIlouFiHciWNLMdXM
         fbSs9pTBdx89pgKjA8XFcPSazEApmeAFCRPhGE8hVtp04rcBCEAmNvS0hr2W7yQkUK5j
         8QyWW9Ytocga6vVvKj1FWp7wQzrFyl5tl3a78aCU/dsarPfkal7YyMSToa00lin/SllD
         aCew==
X-Forwarded-Encrypted: i=1; AL+hErGZyqxw8jRTr9R+WLbzSvyd//gEdN0xpi492tG4+3ovnz2fqZc14lxhp/8aeKEGzA8MSVN7kfHqmIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XdSwcRDinkw/ENomI9onhNYwfEcMVMCsXh1YTyVyZJEAMDOAF
	1YXdNFlBe2bVTGKCXf2UD25WjL+fnTHfH9pGBNmDlSFTVn3s35t2IUEK
X-Gm-Gg: AZFdTZd0Xfe3xXXtvCXftIYFqI5UpNXtlV+eIkBD8frGrKYKNWEr6ZX5Qv4K+7UquH7
	ey6pmg8COcMSgzoMucgjhb+StVy1uXF+YbMQX8NQVTRfW7floFPWn5eB+Fh5F4g7ms+iHvIvzGB
	hdD05ZhLq139IxV3E4Xnh5RJAuEGds12Cnea1v5cGKnEsPgsubX/U/Pyj2BDgv0hu+jMYjqM9GO
	29X+uep3m9FyHHgmMETgQIxBp1BfJBOY5q0yMUbdi7UZSo1qSQR94uY6ALeVzwoO4XGNZyNlqmu
	VE3ARfOs5xybSO/ulxtA8A6DZXVju75Um2FOEokx4cD8lJxaJCTs//zoVN/2D/BEgsmXLQCdIrR
	CweC87R11lnp5Rnvr2S8meiWoFnVvQAZJmFbF7F3fc+gXmoe2c+1e+rtl1S+a+xUYZBmGM1EoKC
	jpusncgrRBxjS/N4OqBhanabuU84MoGZ8tobKXG8LCkdzoiDLH8dpl80KuCIBdlSI6jIpoKrCal
	TCmch+kl1CPpM1BX/cR9FrXrBl05t9D1S8wJMl/eZFTlTvOi4Xbyao3ohml7V2KJpcipouiNRsw
	lAJkyAsK6uA1o2suWsDadGg5ZZU=
X-Received: by 2002:a17:90b:134e:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3b41c96764dmr18868042a91.49.1795646925992;
        Wed, 25 Nov 2026 14:48:45 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm13819382a91.10.2026.11.25.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:48:45 -0800 (PST)
Date: Thu, 26 Nov 2026 06:48:37 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Niklas Cassel <cassel@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aksh Garg <a-garg7@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rhys Tumelty <rhys@tumelty.co.uk>, 
	Manikandan K Pillai <mpillai@cadence.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Hans Zhang <18255117159@163.com>, Yao Zi <me@ziyao.cc>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration
 PHYs
Message-ID: <awdjOLoxBpS6t1KN@inochi.infowork>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
 <awcFIJlCOxB7nXNz@ryzen>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awcFIJlCOxB7nXNz@ryzen>

On Wed, Nov 25, 2026 at 04:56:16PM +0100, Niklas Cassel wrote:
> Hello Inochi,
> 
> On Wed, Nov 25, 2026 at 12:36:39PM +0800, Inochi Amaoto wrote:
> > The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
> > impedance calibration. Store these calibration PHYs in a bulk array
> > and acquire them by name with devm_phy_bulk_get().
> > 
> > Initialize both calibration PHYs before powering them on in lane order,
> > then keep the SATA PHY initialization, mode selection and power-on
> > separate. Use the bulk helpers to release the calibration PHYs after
> > SATA startup and to unwind failures without repeating power-off after
> > a failed bulk power-on.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/ata/ahci_imx.c | 57 ++++++++++++++++--------------------------
> >  1 file changed, 21 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index 6aaa18e29abc..18faa033e44f 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -25,6 +25,8 @@
> >  
> >  #define DRV_NAME "ahci-imx"
> >  
> > +#define NUM_CALIPHY		2
> > +
> >  enum {
> >  	/* Timer 1-ms Register */
> >  	IMX_TIMER1MS				= 0x00e0,
> > @@ -66,8 +68,7 @@ struct imx_ahci_priv {
> >  	struct clk *ahb_clk;
> >  	struct regmap *gpr;
> >  	struct phy *sata_phy;
> > -	struct phy *cali_phy0;
> > -	struct phy *cali_phy1;
> > +	struct phy_bulk_data cali_phys[NUM_CALIPHY];
> >  	bool no_device;
> >  	bool first_time;
> >  	u32 phy_params;
> > @@ -428,30 +429,20 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
> >  	 * Initialize the first two lane PHYs here, although only the
> >  	 * third lane PHY is used by SATA.
> >  	 */
> > -	ret = phy_init(imxpriv->cali_phy0);
> > +	ret = phy_bulk_init(NUM_CALIPHY, imxpriv->cali_phys);
> >  	if (ret) {
> >  		dev_err(dev, "cali PHY init failed\n");
> >  		return ret;
> >  	}
> > -	ret = phy_power_on(imxpriv->cali_phy0);
> > +	ret = phy_bulk_power_on(NUM_CALIPHY, imxpriv->cali_phys);
> >  	if (ret) {
> >  		dev_err(dev, "cali PHY power on failed\n");
> > -		goto err_cali_phy0_exit;
> > -	}
> > -	ret = phy_init(imxpriv->cali_phy1);
> > -	if (ret) {
> > -		dev_err(dev, "cali PHY1 init failed\n");
> > -		goto err_cali_phy0_off;
> > -	}
> > -	ret = phy_power_on(imxpriv->cali_phy1);
> > -	if (ret) {
> > -		dev_err(dev, "cali PHY1 power on failed\n");
> > -		goto err_cali_phy1_exit;
> > +		goto err_cali_phy_exit;
> 
> This changes the order the calibration PHYs are brought up in.
> 
> The commit message describes the new order:
> 
>   "Initialize both calibration PHYs before powering them on in lane
>   order"
> 
> but doesn't say that it differs from the current sequence. Could the
> commit message mention the change, and why it is safe for the shared
> calibration?
> 

According to the document, there is no initialization order requirement
mentioned, so I thought it will be safe to change that since the
document shows that the calibration is independent in section 19.3.3.5.

> The cover letter mentions that the PHY timing requirements were checked
> against the documentation. Has the new sequence also been tested on
> i.MX8QM hardware?
> 

I does not check it on real hardware, the only thing I find is the
document.

> 
> >  	}
> >  	ret = phy_init(imxpriv->sata_phy);
> >  	if (ret) {
> >  		dev_err(dev, "sata PHY init failed\n");
> > -		goto err_cali_phy1_off;
> > +		goto err_cali_phy_off;
> >  	}
> >  	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
> >  	if (ret) {
> > @@ -465,10 +456,8 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
> >  	}
> >  
> >  	/* The cali_phy# can be turned off after SATA PHY is initialized. */
> > -	phy_power_off(imxpriv->cali_phy1);
> > -	phy_exit(imxpriv->cali_phy1);
> > -	phy_power_off(imxpriv->cali_phy0);
> > -	phy_exit(imxpriv->cali_phy0);
> > +	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
> > +	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
> >  
> >  	/* RxWaterMark setting */
> >  	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
> > @@ -480,14 +469,10 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
> >  
> >  err_sata_phy_exit:
> >  	phy_exit(imxpriv->sata_phy);
> > -err_cali_phy1_off:
> > -	phy_power_off(imxpriv->cali_phy1);
> > -err_cali_phy1_exit:
> > -	phy_exit(imxpriv->cali_phy1);
> > -err_cali_phy0_off:
> > -	phy_power_off(imxpriv->cali_phy0);
> > -err_cali_phy0_exit:
> > -	phy_exit(imxpriv->cali_phy0);
> > +err_cali_phy_off:
> > +	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
> > +err_cali_phy_exit:
> > +	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
> >  
> >  	return ret;
> >  }
> > @@ -839,19 +824,19 @@ static const struct scsi_host_template ahci_platform_sht = {
> >  
> >  static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
> >  {
> > +	int ret;
> > +
> >  	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
> >  	if (IS_ERR(imxpriv->sata_phy))
> >  		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
> >  				     "Failed to get sata_phy\n");
> >  
> > -	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
> > -	if (IS_ERR(imxpriv->cali_phy0))
> > -		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
> > -				     "Failed to get cali_phy0\n");
> > -	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
> > -	if (IS_ERR(imxpriv->cali_phy1))
> > -		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
> > -				     "Failed to get cali_phy1\n");
> > +	imxpriv->cali_phys[0].id = "cali-phy0";
> > +	imxpriv->cali_phys[1].id = "cali-phy1";
> > +
> > +	ret = devm_phy_bulk_get(dev, NUM_CALIPHY, imxpriv->cali_phys);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get cali_phy\n");
> 
> phy_bulk_get() already reports which PHY failed:
> 
> drivers/phy/phy-core.c:phy_bulk_get() {
>     ...
>         for (i = 0; i < num_phys; i++) {
>                 phys[i].phy = phy_get(dev, phys[i].id);
> 
>                 ret = PTR_ERR_OR_ZERO(phys[i].phy);
>                 if (ret) {
>                         phys[i].phy = NULL;
> 
>                         dev_err_probe(dev, ret, "Failed to get phy: (%s)\n",
>                                       phys[i].id);
>                         goto err;
>                 }
>         }
>     ...
> }
> 
> so a missing cali-phy1 entry in phy-names now prints two errors, and the
> second one doesn't name the PHY.
> 
> A plain "return ret;" should be enough here.
> 
> 

Thanks, I will fix it.

Regards,
Inochi
