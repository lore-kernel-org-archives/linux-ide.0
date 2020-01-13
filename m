Return-Path: <SRS0=yvY0=3C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B3AC33CAF
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 22:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C9320CC7
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578955986;
	bh=oCwqlQnFH8P7dUM4myakN3iHVtlhaPt6WwUh+Q5T3zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NavWRDlziMHpeUzkXp3VBZbXG6AFpawjuCY/VdzoE0PwUjPNO8ddWfvc3IyVxw9K7
	 K6UJ4cuBJjnUjKhiQHQYJqQnL6M1fJi+X3fFsspjl7O5Q36TPYlDtpKdXQH6VnA2Mg
	 j/QVpv1niNXsnsafMLQvJnAc4TIdt169rC/yZmLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAMWxF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:53:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41164 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgAMWxF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 17:53:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so10647052otc.8
        for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2020 14:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uDkx2r+nuwFxUKoOrf7KVMmZfrPFwS8DDF7iAYkk30E=;
        b=LBBVivBPR8yBNK5qA+skTASVZ+bXpyXH+TkkqpSrnPfzWJz3DQwJIEguWqrCUhkUT3
         B/5zeW9WZGgB7LvoAmoOKb/Rz6c42LT0/SaJsFyZB4hWI6L7VtlyMkpCXzARbJ98FqsT
         WP3CxqZ7fK9a6PlS7Eb21ErFSVJvc5hBjarIx7P68qaVYff8D4g+ipAA5SHEQOvecLvi
         EG81XGlHeBRC14TQViI9Keshdd8f5grdOjUrEd96x/wpea697ZRIt95+cOkYbEuvC8Ff
         fDggXO8QuQuDLzT5JRZA5v/YTfg21zSkrJ5DTJEGlMe1aNAdkQxnZ/e/Muc6bCnamddR
         5kYQ==
X-Gm-Message-State: APjAAAW9TrDKSdIMK/GcockZVYBrvy2ZaY4ZWzakGydrn0TfQTvsk23V
        +UJjr1JVNU6GYqbUOkH83lgL6/E=
X-Google-Smtp-Source: APXvYqxhWmU/UWs2NZqeKDPdNs4MAgFPZQ6ZBmK7EMDVi2wT5EatjbhWX2QDTioONKBUgtwrjRocWA==
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr15238906oti.180.1578955984466;
        Mon, 13 Jan 2020 14:53:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q13sm4655842otc.5.2020.01.13.14.53.03
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:53:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:53:03 -0600
Date:   Mon, 13 Jan 2020 16:53:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4] dt-bindings: Create DT bindings for SATA controllers
Message-ID: <20200113225303.GA18742@bogus>
References: <20200112111751.21984-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112111751.21984-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, 12 Jan 2020 12:17:51 +0100, Linus Walleij wrote:
> I need to create subnodes for drives connected to SATA
> host controllers, and this needs to be supported
> generally, so create a common YAML binding for
> "sata" that will support subnodes with ports.
> 
> This has been designed as a subset of
> ata/ahci-platform.txt with the bare essentials and
> should be possible to extend or superset to cover the
> common bindings.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Drop any master/slave terminology: SATA has one drive
>   per port or up to 15 drives behind a multiplexer.
> - Drop RFC notation, this feels pretty finished.
> ChangeLog v2->v3:
> - Split off into its own RFC patch
> - Only support sata-port@ in this binding
> - Opt to support devices 0..14 on the sata-port in
>   line with ahci-platforn.txt not modeling the port
>   multiplier in the device tree at all.
> ChangeLog v1->v2:
> - Use ide@ and sata@ as node names.
> - Use ide-port@ and sata-port@ for the ports toward the
>   drives, rather than letting the subnodes be the drives
>   themselves.
> ---
>  .../devicetree/bindings/ata/sata-common.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/sata-common.yaml
> 

Applied, thanks.

Rob
