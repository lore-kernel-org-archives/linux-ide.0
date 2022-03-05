Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C398C433F5
	for <linux-ide@archiver.kernel.org>; Sat,  5 Mar 2022 10:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiCEKUt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Mar 2022 05:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiCEKUs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Mar 2022 05:20:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B67E5BB;
        Sat,  5 Mar 2022 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646475565;
        bh=hyzDOtV7xvM79xMsBY7kHpNVdMXTGXVQSg16UMzGcDo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GYh0sjdwB7nmeHw57MWmGFYU7SbECk06LHZd14Y+5JB6Pz/W42ThKlPE9T0+uDPZH
         mMasXQdOwWOTtG8bszQMMpX6WIZ2Jiza6hxbUjbU57X1LJo9Ooi4Pd+G4BjrH34gjz
         puvhARUzf8JYUhuPjrUk5C9lXMa2IuWj+HJlOHlQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.220] ([80.245.79.220]) by web-mail.gmx.net
 (3c-app-gmx-bap19.server.lan [172.19.172.89]) (via HTTP); Sat, 5 Mar 2022
 11:19:25 +0100
MIME-Version: 1.0
Message-ID: <trinity-f8b1d1cb-0521-42b2-934d-9f822c86b623-1646475565023@3c-app-gmx-bap19>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Frank Wunderlich <linux@fw-web.de>,
        devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Aw: Re: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 5 Mar 2022 11:19:25 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-68e1ed73-5a31-42d1-838e-0a837e686c4a-1646474868401@3c-app-gmx-bap19>
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
 <Yh+0B+iKx1gJXXCk@robh.at.kernel.org>
 <trinity-1ca1f3fd-1eeb-4c8d-a7e2-65851eb8002b-1646291055736@3c-app-gmx-bs69>
 <CAL_JsqJMZ1mZ91SYZR03rMkK-ZqFd-tCwV6zOrNu5NmP6V+duA@mail.gmail.com>
 <trinity-68e1ed73-5a31-42d1-838e-0a837e686c4a-1646474868401@3c-app-gmx-bap19>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:+onrTpI7SK3F02AVIuUdj/i5gRLg5dijgmk6GNPu7j/ZIY+jH4jG068TuUEFfT54eBhg1
 hC7stUOUeNw2OYtiQmq98Indy7b5pHwERnor55k3iBDXYPfCgXSBz3d/wkD/BARsUQHrRNLaaAkQ
 o4qXqauAm4DHKy9WWFDmlCoJSM61WRl27GYayl22X3760Uae/RBrsGizW1WJWNbmz4aA1GxSNmlg
 0E7fZ7IHgpMg/OZvnq+DpGbJjzfix4NnEzXQnsS/2w/AXgpwacgen1ouN/Q/ejM7xKva0mDpy8QI
 Xk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:8v+5/R1XTUI=:9ppDbdAF8VlTCYdVSoceIz
 aHWpNLOnNS/qVbe7xTr8nI1EKM7S0RafcMZ2IesaJ2a5dZGAFw40OozY+CSCU4VbXkPImOp+l
 Ou8AasaCIk8iqiUp2u7OGSVAWyN58k9vij6U5JP+Pa79+vczR/2Eu0bEyh9g5Jv5OFUDWfniX
 /dh3OiECds1g1HFS9A1+MOxTIRCLh8iNANOkkj9FI4luiLljXhmFKSEGE/dKnuMqtHGSzPC3i
 G7LA1iaq23+DTnhnCwoQ8UvLZePW3IZu+IWZvVjol7/SvP2Qf1C7pfYg3SpEdXQ1awnL8ZzKB
 cqmrAwwyWA6Td3DcGugxdDdzZvCSts3jga5xKL+9bPsShv3skY2p8Xv6mSuiMEq/wiPku/sej
 pNc+m2HDlgh7+zn8tw8DBPZOrgu8zKWKsbyD36P3PLTbY+2hQjiSycGXBnqQbvV7rsAc6LV73
 b1+cLWPgOSTjJVRBKMakXp14L+Gc8CfLayDFUKdTXpsdg2jHjyihfouL63OgKuuJtVjFNrZDE
 dcIOWduudV+u10eubkLh1KAtmbWKJYQ/aJqjwZ7GtWvPpb03eVcztEc8vSRe3qJjylIiKc3kZ
 4OVM7sId5BgEvOayF67vwJmSdaY1Sun/RSsh64Vm4IOgbagOYPuIxNYsdIOfFS2BujfVP0bi0
 FOUEzJerDykSSiOqIBZbbfzH/PzL13D8yFoMVBJEePCmVCC2hWaZrrtFPOeLKWQATkUJ6+A9T
 fhIOJKgJHG7H1R0aue/9BpanHCOniFu/tu/X0cd+YtkGaZhDg+IjsAG4Gmc0X9TlCUQ6PtIhR
 VG8eV9+
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Take a look again of the mentioned calxeda=2E=2E=2E

it looks like it only uses the compatible "calxeda,hb-ahci" handled by
drivers/ata/sata_highbank=2Ec and seems not using the ahci-platform=2Ec

obj-$(CONFIG_SATA_HIGHBANK)	+=3D sata_highbank=2Eo libahci=2Eo

so imho the maximum 0x1 still should be right

regards Frank


> > Gesendet: Samstag, 05=2E M=C3=A4rz 2022 um 00:37 Uhr
> > Von: "Rob Herring" <robh@kernel=2Eorg>
>=20
> > There's a spec for it, so no need to look at what's used=2E Calxeda AH=
CI
> > had 5 ports IIRC=2E

