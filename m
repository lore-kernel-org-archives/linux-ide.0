Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51168C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2906820716
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686166;
	bh=toY0t9Rutk58k2rqYu8oieIPSWP4meuA9EgEfXZ0IJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ihg4ioDVmX7z28I603zK1i82/y/SF68NELLGKM3/UicvmOOTMSkpXSsMxevu6CavG
	 sWOMgbK4W89l2zw9CnPylaklAgO4F/pc05vFhwAP3E973uLj4FUVIOpihw6i4KVgID
	 Ybnm7veY6T9PLQrptawtP88ztNbdwQJgu51nz64s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgHQRml (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbgHQRmS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2020 13:42:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D7C061389
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2020 10:42:18 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id r19so8162132qvw.11
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2020 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z04zv+V+v6HQWKpvrvfgzyBU1S76Dh3iigE2cA+cjPw=;
        b=lG4ciHatUHQ8zP0sZuc7GvgJIECNOyg/0AE2EJSj4fHix9KXfapyMAzkgS5Gkub8z2
         Sc+vmZC//U5DDvbnRvJtqVzcvMash5CE66IFqFhnCfSnRQh1t3YyAF+HHmUaNvLggydX
         ZlMZ2JbgKCcYMkk+XYX3bf1mbf6n4oDNA3UPeNo3I9P9CcpkAIJ2PcYQT6N0tU1IWwuY
         krq52ktwmbkMe4THxd3sqehEDFmuaRJHeVi52PtXLXr8kd64ucJLwofR7uZk8hYO4k2+
         BqLA+f0QuXtL1i15jsSnkTlBx+0d5gnlEwLlTfNPPih1INTE8Vh0d2VWjzFibDzOjtro
         ZzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z04zv+V+v6HQWKpvrvfgzyBU1S76Dh3iigE2cA+cjPw=;
        b=ufTenukqDlSHG5V9JJrCpImk8KREHDiRcpdVbsdMM0aL8Cash5CBSoOjFl0YoXJ7ng
         sBt4rcZ4sGiz0NLx7q3VXjKjj8X5uK8pLh31306gC55LtybUeYsqA/N++gZ2nsnBrxKx
         pWqAD+gDPqE6Jsp2/Dog2jgssModETCtEkDWRwir4RNZRB/ICx6z89vhd1wwIXVxn8KZ
         7LoNPQLeV4LOcojpn+oAP/Hs2C4rsF5lruUpxWvoNkcjYdSKkxoOB5yc2ukkPW1H+thh
         8T5n6MIbw+xsT8wODIMpyqI7FD2CUDABHla3eYWYVBgo+/1yOJuPOpSSaill21TnLJnr
         fGnA==
X-Gm-Message-State: AOAM530HLec69dvmysKyGMNTUspVTrli/UQF5RLE8FeQN5GntIMAm3wV
        FZJmwH9eDo2BBn7Ywa9IKUc=
X-Google-Smtp-Source: ABdhPJxVg2ctAfHbePk0iqJTahmGOYqyluGU5gI/pitQazGNUI38H++Q5XseGp+O483u+vC4DlA3cA==
X-Received: by 2002:a0c:fa4c:: with SMTP id k12mr15113061qvo.40.1597686136973;
        Mon, 17 Aug 2020 10:42:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:56c6])
        by smtp.gmail.com with ESMTPSA id q68sm17782598qke.123.2020.08.17.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:42:16 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:42:15 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Akshat Jain <akshatzen@google.com>
Cc:     Vishakha Channapattan <vishakhavc@google.com>,
        linux-ide@vger.kernel.org, John Grass <jgrass@google.com>,
        Thieu Le <thieule@google.com>
Subject: Re: Question on ata_gen_passthru_sense interpretation of fixed
 format sense buffer
Message-ID: <20200817174215.GB4230@mtj.thefacebook.com>
References: <CACqKpR-5=bDwODQFfMY+o8-XJMCQmtLVAOiCEY8ApFwQr04A8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACqKpR-5=bDwODQFfMY+o8-XJMCQmtLVAOiCEY8ApFwQr04A8A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello,

On Mon, Aug 03, 2020 at 09:44:26AM -0700, Akshat Jain wrote:
> Hello Jens Tejun,
> I have a question regarding the ata_gen_passthru_sense function (libata-scsi.c).
> 
> This function while generating fixed format sense blocks, puts the
> INFORMATION field at offset 8 and COMMAND-SPECIFIC-INFORMATION at
> offset 16.
> While as per SCSI Primary commands - 4 specification, section 4.5.3
> Fixed format sense data Table 53, the INFORMATION field is at offset 3
> and COMMAND-SPECIFIC-INFORMATION is at offset 8.

Sorry about the late reply. I could have been easily mistaken and don't
think the path has been under any kind of scrutiny. The best way to proceed
would be submitting a patch referencing the spec cc'ing linux-ide and
linux-scsi. Have you guys got bitten by this or is this discovered through
code review?

Thanks.

-- 
tejun
