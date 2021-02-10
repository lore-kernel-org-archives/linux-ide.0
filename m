Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C5C433E0
	for <linux-ide@archiver.kernel.org>; Wed, 10 Feb 2021 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE6664D92
	for <linux-ide@archiver.kernel.org>; Wed, 10 Feb 2021 20:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhBJUUo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:20:44 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:35001 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhBJUU0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Feb 2021 15:20:26 -0500
Received: by mail-oo1-f49.google.com with SMTP id t196so805673oot.2;
        Wed, 10 Feb 2021 12:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdUAMoXuKZ+5xDWH+zZnA9Uz3pPWgYxEKaaqaCeEKjY=;
        b=WeiY3hYTli4St2lkKxJ4ZwXh7U48mJDKYHCdkSudPcsU/fT13b7o7/3wxQFhA4zvd8
         jt5vD90Mn7esL94kFTjQio6/DDhUd4q6q/vUJm81BCjBzeRh4NkF5kE/N0zFMQu4No1N
         IGMU1Ebr1/qqkZHrOWxndZpiMM9xBSB09qHLwMmVXxoIQNk3xC9IDrTI5q2MwlMc2XLr
         G2lMF3KqfCrI/7r43SGVHqCQbzgOE5zYN2lJeey1WlZ7+DZkin98yZ5+xSaTfzoba646
         rD5wZHGaj9TKOpld7Z92eTN+VHDZRukZyquY2cstpAcJmpDTVIghkNB5cAy5U4kozBKY
         r35w==
X-Gm-Message-State: AOAM530G77eInWDSUjGTNtbj/UWKGw1x5LA9aOFAkfPA7uHWoN8gtbBR
        o/JKHDvcI8FSCZ5SYOGSm4u9lD7Ucw==
X-Google-Smtp-Source: ABdhPJy1IN1Yh7dpt4SPnBNScBJGDEEHZOoTyNAsC9iWUzaC3NzgrIrAvS3HBzaqBAE96xk4D9VJbg==
X-Received: by 2002:a4a:d155:: with SMTP id o21mr3323924oor.72.1612988385714;
        Wed, 10 Feb 2021 12:19:45 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s123sm588610oos.3.2021.02.10.12.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:19:45 -0800 (PST)
Received: (nullmailer pid 2691900 invoked by uid 1000);
        Wed, 10 Feb 2021 20:19:43 -0000
Date:   Wed, 10 Feb 2021 14:19:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        p.zabel@pengutronix.de, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, robh+dt@kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: ata: ahci: ceva: Update
 documentation for CEVA Controller
Message-ID: <20210210201943.GA2691845@robh.at.kernel.org>
References: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
 <1612807436-5238-2-git-send-email-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612807436-5238-2-git-send-email-piyush.mehta@xilinx.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 08 Feb 2021 23:33:55 +0530, Piyush Mehta wrote:
> This patch updates the documentation for the CEVA controller for adding
> the optional properties for 'phys' and 'resets'.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-ceva.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
