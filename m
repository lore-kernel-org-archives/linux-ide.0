Return-Path: <SRS0=lGRw=WR=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98FC3A5A1
	for <linux-ide@archiver.kernel.org>; Wed, 21 Aug 2019 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5746F2339F
	for <linux-ide@archiver.kernel.org>; Wed, 21 Aug 2019 21:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566423958;
	bh=ukHBHcfodN82aCRcZOWNPuV1/Hmqhlz5uNRIQY83vb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XX0VWdrKBsBU2O1ZVtNK6I3N7ArB/qlyNvxhOB2WWGeCmPvp6S9vUXXFl9pY6tbth
	 DNsWLH1mQyY01GFJiQ1veWAfrbwxlFqe2TLqxQ1KbclRL3QKUsu+n70vUeFM08wJUT
	 86glnMo+nbXqM8yzA9TH8PhdFAOB+nbfFHKkHLrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfHUVp5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:45:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37822 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfHUVp5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Aug 2019 17:45:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id b25so2813347oib.4;
        Wed, 21 Aug 2019 14:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlELz4WXoNyx1fC6jRJuCL/0KkGNNJXIdrw589z2kEo=;
        b=fXsBkCPA80lIbwj1eNE5du2ySTXW/jKc55bvGLC/Ss1tDclkwAxRNH0PLbcxjx0bHZ
         aADaUfGvv1sovBsq/8iqKLCpqYMUVjcwPooi4ZAcZnKJBB8AISTR2AlCv1L19m97pyGp
         5hqfuUlv2vPM2XgkWEKrEahJvB3nFxh7yI1HvgdQML81/Pol+tZoaGQg9UinjZB203kl
         WgeWTu5pwJ97/5Ouc39Gy3lKp07MilcERX4qWJthzKmneGSI/b/pll1OPbCRzgZ/EWG4
         qcfCHdiWH0iibRJvOnjZTZxE9qtV+xzbcyieTFSPh14Y5ayW3QLWfxKWj2lWh9FyyeWp
         JmYQ==
X-Gm-Message-State: APjAAAWNsS/AK66j5p+VkaqCy+7eVJFjwslOu2ngPo3D3ilXy9svW3nE
        d/TyyV9X035TC+SpDLcMUg==
X-Google-Smtp-Source: APXvYqwrC7IpZwWire9CqKO08aGc9TxMXLjCkOrqCfjQjiZqfVwhI8DLA/qwjbfEUFW4XjHKtEP7lA==
X-Received: by 2002:aca:f481:: with SMTP id s123mr1570648oih.109.1566423956094;
        Wed, 21 Aug 2019 14:45:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm6679680oij.35.2019.08.21.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:45:55 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:45:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH] dt-bindings: ata: sata_rcar: Rename bindings
 documentation file
Message-ID: <20190821214554.GA8691@bogus>
References: <20190809215131.877-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809215131.877-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri,  9 Aug 2019 14:51:31 -0700, Simon Horman wrote:
> Rename the bindings documentation file for Renesas SATA controller
> from sata_rcar.txt to renesas,rcar-sata.txt
> 
> This is part of an ongoing effort to name bindings documentation files for
> Renesas IP blocks consistently, in line with the compat strings they
> document.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on v5.3-rc1
> ---
>  .../devicetree/bindings/ata/{sata_rcar.txt => renesas,rcar-sata.txt}      | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/ata/{sata_rcar.txt => renesas,rcar-sata.txt} (100%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
