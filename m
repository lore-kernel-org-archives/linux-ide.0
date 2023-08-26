Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B562CC83F15
	for <linux-ide@archiver.kernel.org>; Sat, 26 Aug 2023 11:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjHZLdh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 26 Aug 2023 07:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHZLdI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 26 Aug 2023 07:33:08 -0400
X-Greylist: delayed 1257 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 04:33:05 PDT
Received: from mail.sowerbutts.com (mail.sowerbutts.com [IPv6:2001:8b0:3b1:dead::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53FE54
        for <linux-ide@vger.kernel.org>; Sat, 26 Aug 2023 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sowerbutts.com; s=igor; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XwySiPTA+U1lcMHL3hjcBoYLBd3hpG/N3CL7Y9tK44A=; b=N9vgwwlqGC4J1N3wlb14H2i9wA
        iO/fxafqjo0XyfdZaa+89TSJy1o4YHSk40HwSYVwsIYKSva8c/awimOhuvM8354Hc0eESPh0aSTBh
        uYzulfwhXOU5guDf1uKrDi82NFKBPzUY5dua/7xuT78EHojr7mtpbyWJNKFoFpeY05cXb/FrQAIqg
        j0eFV2lzyZIWyB722mnj2EXsYEtpSfuspRXa5gcKKjDmWFbTRYGtt+jfSPwSd2KZyL8xVbZ0cx9sD
        lIKLNBD0I3iSEUkhJsMTK3i9Z/xPB81pVBF4dw+m9ehpMBUHNkzh1xcSizTjJFA3kzCMfXeIKqEa2
        y1mAvupA==;
Received: from [2001:8b0:3b1:cafe:2292:e7dd:dea3:4ff6] (helo=sowerbutts.com)
        by mail.sowerbutts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <will@sowerbutts.com>)
        id 1qZrCz-001OHf-36;
        Sat, 26 Aug 2023 12:12:01 +0100
Date:   Sat, 26 Aug 2023 12:12:01 +0100
From:   William R Sowerbutts <will@sowerbutts.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, rz@linux-m68k.org, geert@linux-m68k.org
Subject: Re: [PATCH v5 0/2] Q40 IDE fixes
Message-ID: <ZOneAWSqU2hRVbJ2@sowerbutts.com>
References: <20230825011335.25808-1-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825011335.25808-1-schmitzmic@gmail.com>
X-URL:  http://sowerbutts.com/
X-Hatstand: Voltron
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I have tested this on my Q40 and I am pleased to report that it works 
(including the feature to selectively byteswap drives)

Thanks!

Will

On Fri, Aug 25, 2023 at 01:13:33PM +1200, Michael Schmitz wrote:
>Version 5 of the pata_falcon bugfix patch for Q40 support.
>
>Review comments from Sergey, Damien and Geert have been addressed.
>
>Cheers,
>
>   Michael
>
>

_________________________________________________________________________
William R Sowerbutts                                  will@sowerbutts.com
"Carpe post meridiem"                               http://sowerbutts.com
         main(){char*s=">#=0> ^#X@#@^7=",c=0,m;for(;c<15;c++)for
         (m=-1;m<7;putchar(m++/6&c%3/2?10:s[c]-31&1<<m?42:32));}  

