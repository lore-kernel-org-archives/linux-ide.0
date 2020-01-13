Return-Path: <SRS0=yvY0=3C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F7FC33CAF
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 23:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF110207FF
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 23:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578956538;
	bh=wCn4/894KniO2ftSZq/2Wivodp6I96UmXRF8C4cmB2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b1JHJBzLzY4Fo9vPWw7n8O8DdtAmc7Ho+QSen3A31AOO4iEs2L+/ogHloiT9dUebv
	 aC8Yc6fYZG+vQqf2eaLED8+ih5QqKzF9KMu3Mpqpw/CGqFLOJzaB41l7AaOXSNmT07
	 6u2RVOiJSqYHD5lxNNxshAsMFR0DRXrv98VfRL9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAMXCS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:02:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35096 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgAMXCS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 18:02:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so10029426oik.2
        for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2020 15:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18X4W8z+4oQOA0zZ9sp8Kgk/QX1t7Hw3G5i41pFALn8=;
        b=PfcN001/8gm0E5tATZqeUzbNfvcisDdtHsb3EoMzZzUcBcHMLZd6knKVJHj3GJj9vT
         JY+N/ROVND9mjmfBpIi/Ke7livnZIIZCThYRpIA3w2KS4wFM9k3u8jghyW44f8gOLLhP
         S4QxK7weh3DL9oMgRn2rOVEhmGTUR9mUsPphOiwOFmwvOCRrSs+nCEcSGH3Rw2PJdY79
         NS2/BXTkPFiUkVYTFVWnlK0IsstV+FQ9wT9pyAsqNBoDg3UgzZNcXBuiXeu6dLtmCD2G
         J35Y5vXGppCJrm0fkcnOJOCxggulGP4c/LMU87hFd/JtkkFnws/48FTnzz7KcFbiTdUZ
         RGsg==
X-Gm-Message-State: APjAAAVu1BgsXcCaFusLtPrLd6YfDzyoDrhjrN2QSn1ZWwgmbNogNUOL
        cqeCmidyG2cVaw4CvVBSnpbyaEA=
X-Google-Smtp-Source: APXvYqzrjzw/ebBkaWlW+xsDOh7JGkEznOd1/3Cnnwn9ysU0VeBQ8XSdsjTCSvqGkmWtgdzzEKf3sQ==
X-Received: by 2002:aca:3354:: with SMTP id z81mr15003559oiz.129.1578956537149;
        Mon, 13 Jan 2020 15:02:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t9sm4642665otm.76.2020.01.13.15.02.16
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:02:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:02:15 -0600
Date:   Mon, 13 Jan 2020 17:02:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v3] dt-bindings: Convert Faraday FTIDE010 to DT schema
Message-ID: <20200113230215.GA32053@bogus>
References: <20200110081411.9806-1-linus.walleij@linaro.org>
 <20200110081411.9806-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110081411.9806-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 10 Jan 2020 09:14:11 +0100, Linus Walleij wrote:
> This uses the new pata-common.yaml schema to
> convert the Faraday FTIDE010 to DT schema.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rebase on the new common binding for just PATA
>   controllers.
> ChangeLog v1->v2:
> - Rename the node for the example controller to "ide@"
> - Rename the drives to ports, so ide-port@0 etc instead of
>   drive@0.
> ---
>  .../bindings/ata/faraday,ftide010.txt         | 38 --------
>  .../bindings/ata/faraday,ftide010.yaml        | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.yaml
> 

Applied, thanks.

Rob
