Return-Path: <SRS0=ykyP=2J=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA50C43603
	for <linux-ide@archiver.kernel.org>; Thu, 19 Dec 2019 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F8F24679
	for <linux-ide@archiver.kernel.org>; Thu, 19 Dec 2019 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576788048;
	bh=G6F1dhHRABV7U/rYF+Ej8wgERKJXCUjVlWctqVctaDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=frTInKM2pkKOXQlmlw5sLkYiIPPote1vHdHvxmOwu7JT0C7TqLYf8YzJoCtVnlz5y
	 zi22xPC9l71LdamsDNrW//Ck6BQJEgVFatXPwwLCHHSEKPFx6ouHVObl4zNAsbUz/G
	 o+gzP2aM4ssgJW8Z6A10vB9OAtD1vcEWl+t9eeMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLSUkr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:40:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34078 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSUkr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Dec 2019 15:40:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so8799562otf.1;
        Thu, 19 Dec 2019 12:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=21W8yCf9pgOvoM3yR3esOgZJvdfXNs8UfWAasIANdTM=;
        b=FF0y9suBVaxKZAIiSkUNQP+cJUtIjFgP2QZeLTlyGbZyckKBEMxtOlUV4gQmokmIrr
         iA/9d9EoZnlp39j7OifkHfvoNKItVVYJsSZoWWSPpEOznxziF/2+wb0ssOF/Nb5Yfuod
         m4+ZRD+t3pwizwGVR4O16Ehz0m5FNJBuJY2fuNqeJ0bhGEBcBnb7biEse4NrTpmFU33w
         SLgjPA0qbXQzAEt0j9LyixUCf0GGusunaSTQf7mSIYJ1cwwnifyXL+yy/rzu+S926ked
         R1gutOFGiv1gRVtj8T6xUfuIkHSNoLD3ypn+q2pfXfpMv8joDCAzulRCqHeBJ4VvXMlI
         Mifw==
X-Gm-Message-State: APjAAAX6ykQOjtLOy0NqH6EmXgYKYdWAB1GCFYwaF6PF/A7/DsOexxEd
        xicdPHM60+PMIeFBmuqvjA==
X-Google-Smtp-Source: APXvYqzyysuiwVcJkga4GmqUpOaRIlI5ANtfdkURalSZyPAjYe+RtmcwxJL58ghpAoPbgGgPQXyz0Q==
X-Received: by 2002:a05:6830:1e10:: with SMTP id s16mr11211820otr.230.1576788046497;
        Thu, 19 Dec 2019 12:40:46 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id b5sm2526678otl.13.2019.12.19.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:40:45 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:40:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kishon@ti.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: Document BCM7216 SATA PHY
 compatible string
Message-ID: <20191219204043.GA6785@bogus>
References: <20191210200852.24945-1-f.fainelli@gmail.com>
 <20191210200852.24945-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210200852.24945-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, 10 Dec 2019 12:08:51 -0800, Florian Fainelli wrote:
> Define "brcm,bcm7216-sata-phy" as a new compatible string for the
> Broadcom SATA3 PHY.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
