Return-Path: <SRS0=b2kW=2V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09AC2D0C2
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EAD206D9
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577817873;
	bh=riXcoydcyPoxgkVe8tAVNRG3RFVXH6/h9LqbmhayhjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aEHyKJtbg0eiYyrUU+9ZmlwbIuxwHld5bImKDVWs/9wqkF2m5Yzivpd74x2JQJ187
	 FPqkPAhOvXINloBm2HN1gFXhvsB3bHTK+I9dL/Gb7oADOQkJ2evvbXtll3NJx1crx0
	 SW26MTti/nr0gBhaWRHLXBpOjUayiHXuVEybAdpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLaSoc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Dec 2019 13:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfLaSoc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 31 Dec 2019 13:44:32 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702CD206D9;
        Tue, 31 Dec 2019 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577817871;
        bh=riXcoydcyPoxgkVe8tAVNRG3RFVXH6/h9LqbmhayhjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a3SDFHuDqg2DCCB2Q0X8BaYq8y19qdPTiLDvhBiBjlHBY5C77eokc4FFBB6clAomZ
         Gu/3FW9D0FxEb1QtoCY3GCipOZr0/t8uFu+74JrmigdHY8maPcdi9RSc1/egCylhza
         7qtWv6/2Iw1anU9C/SaBUrfaUSeFAVLjIJxuF188=
Received: by mail-qt1-f180.google.com with SMTP id l12so32033405qtq.12;
        Tue, 31 Dec 2019 10:44:31 -0800 (PST)
X-Gm-Message-State: APjAAAWjWiQa8FqZifv/J1/Hc+CzXaeGcrX6neLhVZCct/IZtBdcBbBe
        4+PoxtULBlSH76APVTUApq+wq925c/Ij4frNug==
X-Google-Smtp-Source: APXvYqwuXd/iB7mnz6sRuN1D722obsAkIzZeKSerej+GtzsT+NMn+IL6WwSpo9TnuKp7aqFc+cJ7Y327syIQMQJLlRM=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr53751443qtq.143.1577817870653;
 Tue, 31 Dec 2019 10:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20191231172458.25984-1-linus.walleij@linaro.org>
In-Reply-To: <20191231172458.25984-1-linus.walleij@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Dec 2019 11:44:19 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKcuV1dKuTD7iYdyHA3fqv3ENBVj7RXQuT+yMja4tJpxA@mail.gmail.com>
Message-ID: <CAL_JsqKcuV1dKuTD7iYdyHA3fqv3ENBVj7RXQuT+yMja4tJpxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Create DT bindings for [PS]ATA controllers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Dec 31, 2019 at 10:25 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> I need to create subnodes for drives connected to PATA
> or SATA host controllers, and this needs to be supported
> generally, so create a common YAML binding for
> "pata-controller" or "sata-controller" that will support
> subnodes with drives.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/ata/pata-sata-common.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/pata-sata-common.yaml
>
> diff --git a/Documentation/devicetree/bindings/ata/pata-sata-common.yaml b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> new file mode 100644
> index 000000000000..d94aa20a29e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/pata-sata-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Parallel and Serial AT attachment controllers
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  This document defines device tree properties common to most Parallel
> +  (PATA) and Serial (SATA) AT attachment storage devices. It doesn't
> +  constitue a device tree binding specification by itself but is meant to
> +  be referenced by device tree bindings.
> +
> +  The PATA/SATA controller device tree bindings are responsible for
> +  defining whether each property is required or optional.
> +
> +properties:
> +  $nodename:
> +    pattern: "^[ps]ata-controller(@.*)?$"
> +    description:
> +      Specifies the host controller node.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^drive@[0-1]$":
> +    description: |
> +      DT nodes for drives connected on the PATA or SATA host. The master drive
> +      will have ID number 0 and the slave drive will have ID number 1.
> +    type: object

See ata/ahci-platform.txt. We already have child nodes defined as
ports which is essentially a drive (though IIRC SATA can have a mux).
Arguably, we could have both ports and then a drive child under that,
but I've never seen a case of a drive needing DT properties (that
would imply a non-standard connector). So either split this into
separate IDE/PATA and SATA schemas or extend this to work with SATA
ports.

Also, you might consider if you need a regulator property for IDE.

> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +        description:
> +          The ID number of the drive, 0 for the master and 1 for the slave.

Why do you need to describe the drives in DT for IDE? They are
discoverable, right? And unlike SATA, the power to master and slave is
shared.

Rob
