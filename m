Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB1C761A6
	for <linux-ide@archiver.kernel.org>; Thu, 30 Mar 2023 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjC3Mmz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Mar 2023 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjC3Mmy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2023 08:42:54 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE972BA
        for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2023 05:42:51 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230330124247epoutp03852400f5a232e0badd3ad8caa32e6a07~RMvXxF2c22955029550epoutp03H
        for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2023 12:42:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230330124247epoutp03852400f5a232e0badd3ad8caa32e6a07~RMvXxF2c22955029550epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680180167;
        bh=DR/RsVSd00a0Qv+7QOJeOhz+Wzx/TxisdfHO9U82/4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8G0PHaUeaA4DVzAS0z2NnlsRo7hrMIVhlIIJR/5KSuvTD8TwDQLIBSKVV9Hj8T0Y
         sCZeAtfb1YxJ4IhqQHJxht+ybuaY2LDIccZnQkVh60xcXSOgJxHmnK59Ojzcexmv7H
         5vVvAS/CSg11LkLMDf/JaNWyRmLdgRDHDLdhpYio=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230330124247epcas5p4cded337f62f9874ec68943d43ba0698f~RMvXc-VfJ1325613256epcas5p4S;
        Thu, 30 Mar 2023 12:42:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PnNP22Twrz4x9Pr; Thu, 30 Mar
        2023 12:42:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.C6.06765.2C385246; Thu, 30 Mar 2023 21:42:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230330111111epcas5p413bdef318b1d3f74263e86f4bd0aefa6~RLfYvZ3-A0091000910epcas5p4B;
        Thu, 30 Mar 2023 11:11:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230330111111epsmtrp266d03001c04014c226901926f409e6db~RLfYqWA1r1293812938epsmtrp2D;
        Thu, 30 Mar 2023 11:11:11 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-0e-642583c21f24
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.DC.18071.F4E65246; Thu, 30 Mar 2023 20:11:11 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
        [107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230330111110epsmtip2c2fc46e715fad1541b7da3f50cdf485d~RLfXn0Ice2296922969epsmtip2k;
        Thu, 30 Mar 2023 11:11:10 +0000 (GMT)
From:   Deepak Ukey <deepak.ukey@samsung.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        htejun@gmail.com, tj@kernel.org
Cc:     sathya.m@samsung.com, d.palani@samsung.com, prakash.bv@samsung.com
Subject: Re: [ata] : SATA device speed down after multiple power reset.
Date:   Thu, 30 Mar 2023 16:42:07 +0530
Message-Id: <1680174727-12152-1-git-send-email-deepak.ukey@samsung.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <5df4d4b2-459e-332b-d64d-cd5513f7f579@opensource.wdc.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmlu6hZtUUgy8fTS3efn3AZvH77Hlm
        iy3T/rBYHNvxiMni3owudoutlxewW/xafpTRgd1j56y77B6bVnWyeexsvc/q0bdlFaPH501y
        AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
        KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEK
        E7Izrt16yFQwS6ri1b+/zA2MraJdjJwcEgImEjPv/WHtYuTiEBLYzSix4t92VpCEkMAnRonD
        J5UgEt+AEpu3ssJ0LFk4gw0isZdRYtf0NywQThuTxOEPrYwgVWwC2hI7t68Cs0UEkiSe7f4L
        ZjMLuEkcWbkYzBYWcJdYOnk2E4jNIqAq8W76XLA4L1B8RW8HG8Q2BYkpD98zdzFycHAC9Xbu
        CwLZJSFwjF3i0MGtUDUuEnuProayhSVeHd/CDmFLSXx+t5cNpFdCIFtizbdYCLNE4uORGogK
        e4mLe/4ygYSZBTQl1u/ShwjLSkw9tY4J4mA+id7fT5gg4rwSO+bB2KoSi358YISwpSXmH9oB
        tdRD4v6xXmiAzmSU6Dr+jWkCo9wshBULGBlXMUqmFhTnpqcWmxYY56WWw6MsOT93EyM4nWl5
        72B89OCD3iFGJg7GQ4wSHMxKIryFxqopQrwpiZVVqUX58UWlOanFhxhNgaE3kVlKNDkfmFDz
        SuINTSwNTMzMzEwsjc0MlcR51W1PJgsJpCeWpGanphakFsH0MXFwSjUwyZYVhswoXarAwvd8
        1ReR5FuPGtv8LUIe+u+O9HhpLr1S80q2jpqWbMCmH1p1He//NhSWWfHE6oSHb5t4JtDr1OG7
        Psx3Np0PUAq+6V5XlJ3wvE7nt4rxtfAzf9l9BN1rexQC9m2M/PRyywKt1rbYgMrmvqMvnnz/
        9bcmM73L6pNNgSCTYfk7nYzopopnV+S9Czsfvp8YcCfjlLedb1OG+brdD844cLw5u3+VVETa
        ei9XWY/JPuLxMge/5v5QfBOscibYKbZi603GOt6t4fdiC+SSV63fNa2+an3Uk5ef9/plqz6y
        SVsvYLlSKoS/Xcd81u4vwrMi5x3KY6rSmsX5ZFuiWtqGVr49lmn8okosxRmJhlrMRcWJABcb
        kzLwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSvK5/nmqKwb+HvBZvvz5gs/h99jyz
        xZZpf1gsju14xGRxb0YXu8XWywvYLX4tP8rowO6xc9Zddo9NqzrZPHa23mf16NuyitHj8ya5
        ANYoLpuU1JzMstQifbsEroxrtx4yFcySqnj17y9zA2OraBcjJ4eEgInEkoUz2LoYuTiEBHYz
        StzqnsAIkZCWuNb/HcoWllj57zk7RFELk8SrjZfZQBJsAtoSO7evAiri4BARSJM4tCYZxGQW
        8JI4NIMPpEJYwF1i6eTZTCA2i4CqxLvpc8FG8gLFV/R2sEGMV5CY8vA9M0grp4CbROe+IJCw
        kICrxLFtk9kmMPItYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHHBamjsYt6/6
        oHeIkYmD8RCjBAezkghvobFqihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNT
        UwtSi2CyTBycUg1MPmbG2S+lvpy+V/ONU3HO9Z6Dpx4+z3v8QCByXc0VX5Mttoft9s606d6e
        d8enwrf1VLrc67DpqQwXVjssuMm1IqNkccLygPy+z+/fzPwjNN2Zb8Lle9E98yVW/XzC2Bi3
        /meuWtDNR3LzLO/FeAmvMZ5j1daifH3S6dKyqIbi3cLTqgyYLnxg8Jz2auU+kTS9TYJaR92Y
        gw6eZw2/uu1yinl0n9y6XyJbxJyUci9+3ctZ35fvaLmv6Oe8bp8ar+b7cxfmPboUUWFfubhs
        ouo1b//K43Vn9r+WWL6DT9JdzU/i/w+FZ9a+xtflNHufx744Gqh+4X/qe0l7AdMtgamfVhbU
        Fy57Z/fpxJsb3A7FSizFGYmGWsxFxYkAFptdGacCAAA=
X-CMS-MailID: 20230330111111epcas5p413bdef318b1d3f74263e86f4bd0aefa6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230330111111epcas5p413bdef318b1d3f74263e86f4bd0aefa6
References: <5df4d4b2-459e-332b-d64d-cd5513f7f579@opensource.wdc.com>
        <CGME20230330111111epcas5p413bdef318b1d3f74263e86f4bd0aefa6@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> On 2/23/23 19:51, Deepak Ukey wrote:
> > Hi All,
> > 
> > I have SATA SSD that I am using for robust device functionality testing.
> > I have a setup where SATA SSD is attached to AHCI controller and power 
> > to the device is given by power management unit.
> > 
> > For the particular test I am doing mutliple power on/off to the device,
> > it is similar to hot unplugged and plug operation. 
> > 
> > After the 4th iteration of power off and on to device, device link speed
> > is going down to next lower speed, i.e. if device link speed is 6Gbps then
> > it will reduce to 3Gbps.
> > 
> > I tried to debug the issue and found that ata_eh_speed_down function is
> > recording the error as ATA_EH_SPDN_SPEED_DOWN and limiting the speed to
> > next lower speed. Afterward SSD starts working on the next lower speed.
> > 
> > So can you please tell me why this specific functionality is added. Also 
> > is there any way to recover the speed to max speed so that SSD
> > performance should be intact. 
> 
> Please send a dmesg output of your test to see what is happening.

Thanks for the response. As you mentioned, we are cutting the power and
device is disappearing/appearing. Please find the below logs for the reference.

---------------------
[  226.463486] ata_eh_link_autopsy: IN
[  226.463492] ata_eh_link_autopsy: taking speed down action
[  226.463496] speed_down_verdict_cb: Returning zero
[  226.463497] speed_down_verdict_cb: Returning zero
[  226.463497] speed_down_verdict_cb: Returning zero
[  226.463498] speed_down_verdict_cb: Returning zero
[  226.463500] speed_down_verdict_cb: Returning zero
[  226.463501] speed_down_verdict_cb: Returning zero
[  226.463501] speed_down_verdict_cb: Returning zero
[  226.463502] speed_down_verdict_cb: Returning zero
[  226.463504] ata_eh_speed_down_verdict: ATA_EH_SPDN_SPEED_DOWN_1
[  226.463504] ata_eh_speed_down: Verdict:2
[  226.463506] ata_eh_speed_down: Calling limit Speed 8........
[  226.463507] sata_down_spd_limit: speed limit:0
[  226.463509] sata_down_spd_limit: Out speed limit:3
[  226.463511] ata4: limiting SATA link speed to 3.0 Gbps
[  226.463512] ata_eh_autopsy:IN
[  226.463514] ata_eh_reset: IN
[  230.669238] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  230.669505] ata4.00: supports DRM functions and may not be fully accessible
[  230.671982] ata4.00: supports DRM functions and may not be fully accessible
[  230.674234] ata4.00: configured for UDMA/133
---------------------------

But is there any way that we can recover the speed back to normal if device is
functioning properly after power cut for considerable amount of time.

> 
> The issue is likely that cutting the drive power is may be not handled the same
> way as unpluging the drive and replugging it (try to see if you get the same
> result or not). If that is the case, then the drive is simply
> disappearing/appearing and that is handled as an error. Too many of these and
> libata decides to lower the link speed to try to reduce the number of errors. So
> your test is probably not entirely identical to plug/unplug. Losing power is an
> error. Unplugging is not.
> 
> > 
> > Thanks & Regards,
> > Deepak Ukey
> > 
> > 
> 
> -- 
> Damien Le Moal
> Western Digital Research

Thank and regards,
Deeepak Ukey
