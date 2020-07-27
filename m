Return-Path: <SRS0=uzjf=BG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE9C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 07:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE27F2075D
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 07:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDK8obBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgG0HUf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgG0HUf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2020 03:20:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED2C0619D2;
        Mon, 27 Jul 2020 00:20:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z188so728051pfc.6;
        Mon, 27 Jul 2020 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YJXjh4GmMEW7XN5/tplqsYhfZdl3H6taMH5axLntfAw=;
        b=EDK8obBOfKHNTjFkgxYJ9+5FEXC9QIaLLHJwM0UjYRXgbOW/WYsNnkfJKS0zWMKRBl
         5G+RoaiMjvm8LFeedDpWGTIR/HiNGJAhklG0TJk6dIgJOkeY9HZqlYV4DmrwKNByys3P
         Elrq6P9TpGDjVCIsjqjmlSQSNhqePcgaXZ2gp2jdGvOjgzFlD1EPa0Ew4mslTyOCTsbc
         RxP6CfefjoGYcqCDH7LsOEVFU1yVVSZIft1lpudYstiGuLQmnhN6Q+bMVFtx7HH+PYgn
         CJO0YLupfA5nXjCK/E5cpOjpZeLw9avWbMDPZSOU24yLLKwOvFteoZ0YEZYH5WRFPh6l
         NuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YJXjh4GmMEW7XN5/tplqsYhfZdl3H6taMH5axLntfAw=;
        b=bQ89a4W1VSSAR98Qlk6uc/1W4U3bX6i75C3XSoPKDsCZGUxEpJRiiS8uNfQVaCCYix
         +o64u82aVN4W6wi5t4MQ7zKw+6rSRz45FCKRpvU4nu7mNZ6Ost/A1FaHh4tJqNN68Xcm
         8o5fY/C4r3Unhsy0yQLa0Xkk0OEoBz7Da3/oIC/q6AJqmA9zzka61UWlT/T3eCK8mbMb
         F9Nd1NSvh1EAoFfJnL9+m59CyK3SUdHHN47+qmS7NBh0WBBcPq8AqGojeGtLJQYpaAkd
         W6o+UHwvfEIi18UPS4zijvIMDba8neidA8+toGG0v7Bg5BfCHAQ6mFiLgo64d7KdrMri
         CCPw==
X-Gm-Message-State: AOAM53374Du1DvFLjQ4RaWZ40xWhUtYegE/RmnRVLPPqbhpX8H0CHiJF
        fCnn5vxnpzSPtOn4l8Nm32I=
X-Google-Smtp-Source: ABdhPJzo4zlFjXMsAfOgM4X3zAg74cxBAhosgrhd7WC+wNNgCrrv4S9sv/p1zxTGJSCjmjnxOwQ/tg==
X-Received: by 2002:aa7:8e0c:: with SMTP id c12mr18974880pfr.38.1595834434715;
        Mon, 27 Jul 2020 00:20:34 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id lb13sm7971701pjb.9.2020.07.27.00.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:20:34 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:49:10 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] ata: use generic power management
Message-ID: <20200727071910.GA6368@gmail.com>
References: <20200724110630.1219882-1-vaibhavgupta40@gmail.com>
 <202007250808.yhgHBmpJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202007250808.yhgHBmpJ%lkp@intel.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, Jul 25, 2020 at 09:00:12AM +0800, kernel test robot wrote:
> Hi Vaibhav,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on block/for-next]
> [also build test WARNING on v5.8-rc6 next-20200724]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Vaibhav-Gupta/ata-use-generic-power-management/20200724-190929
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1d09ecf36175f7910ffedd6d497c07b5c74c22fb)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/ata/pata_triflex.c:186:36: warning: ISO C90 forbids mixing declarations and code [-Wdeclaration-after-statement]
>            static const struct ata_port_info info = {
>                                              ^
>    1 warning generated.
> 
> vim +186 drivers/ata/pata_triflex.c
> 
> 669a5db411d85a Jeff Garzik     2006-08-29  176  
> 669a5db411d85a Jeff Garzik     2006-08-29  177  static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
> 669a5db411d85a Jeff Garzik     2006-08-29  178  {
> 5acd74b592933f Vaibhav Gupta   2020-07-24  179  	/*
> 5acd74b592933f Vaibhav Gupta   2020-07-24  180  	 * We must not disable or powerdown the device.
> 5acd74b592933f Vaibhav Gupta   2020-07-24  181  	 * APM bios refuses to suspend if IDE is not accessible.
> 5acd74b592933f Vaibhav Gupta   2020-07-24  182  	 */
> 5acd74b592933f Vaibhav Gupta   2020-07-24  183  	dev->pm_cap = 0;
> 5acd74b592933f Vaibhav Gupta   2020-07-24  184  	dev_info(&dev->dev, "Disable triflex to be turned off by PCI CORE\n");
> 5acd74b592933f Vaibhav Gupta   2020-07-24  185  
> 1626aeb881236c Tejun Heo       2007-05-04 @186  	static const struct ata_port_info info = {
> 1d2808fd3d2d5d Jeff Garzik     2007-05-28  187  		.flags = ATA_FLAG_SLAVE_POSS,
> 14bdef982caeda Erik Inge Bolsø 2009-03-14  188  		.pio_mask = ATA_PIO4,
> 14bdef982caeda Erik Inge Bolsø 2009-03-14  189  		.mwdma_mask = ATA_MWDMA2,
> 669a5db411d85a Jeff Garzik     2006-08-29  190  		.port_ops = &triflex_port_ops
> 669a5db411d85a Jeff Garzik     2006-08-29  191  	};
> 1626aeb881236c Tejun Heo       2007-05-04  192  	const struct ata_port_info *ppi[] = { &info, NULL };
> 669a5db411d85a Jeff Garzik     2006-08-29  193  
> 06296a1e684bcd Joe Perches     2011-04-15  194  	ata_print_version_once(&dev->dev, DRV_VERSION);
> 669a5db411d85a Jeff Garzik     2006-08-29  195  
> 1c5afdf7a629d2 Tejun Heo       2010-05-19  196  	return ata_pci_bmdma_init_one(dev, ppi, &triflex_sht, NULL, 0);
> 669a5db411d85a Jeff Garzik     2006-08-29  197  }
> 669a5db411d85a Jeff Garzik     2006-08-29  198  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Fixed in v2. Will float v2 after few more checks.

Thanks
Vaibhav Gupta
