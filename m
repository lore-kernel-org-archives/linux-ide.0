From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: transport: Remove circular dependency at free
 time
Date: Mon, 6 Mar 2017 15:26:10 -0500
Message-ID: <20170306202610.GA26127@htj.duckdns.org>
References: <CAP8WD_ZJ9EgssJgTu8EOtKodtnfxO8tqhN6iAnuMHq2VQ7MoaQ@mail.gmail.com>
 <20170303170009.36744-1-gwendal@chromium.org>
 <20170306200952.GG19696@htj.duckdns.org>
 <ebcbf109-729f-bb2f-f65e-b16765776996@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:32820 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbdCGAwf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Mar 2017 19:52:35 -0500
Received: by mail-yw0-f182.google.com with SMTP id v76so34974058ywg.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Mar 2017 16:50:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ebcbf109-729f-bb2f-f65e-b16765776996@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, gregkh@linuxfoundation.org, linux-ide@vger.kernel.org

On Mon, Mar 06, 2017 at 11:11:53PM +0300, Sergei Shtylyov wrote:
> > The ata_tranport device objects actually do not need to explicitly
> 
>    Still tranport? :-/

Oops, fixed.

Thanks.

-- 
tejun
