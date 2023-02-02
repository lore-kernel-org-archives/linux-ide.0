Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20DAC05027
	for <linux-ide@archiver.kernel.org>; Thu,  2 Feb 2023 06:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBBGma (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Feb 2023 01:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBBGm3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2023 01:42:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56680820E1;
        Wed,  1 Feb 2023 22:42:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so554050wms.2;
        Wed, 01 Feb 2023 22:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDcYVndzbrv1IhY57IErydYh8H4ITxzj3QsSNm1fvUA=;
        b=AXaOSqmOyNDB0cPQs544EL34IAo7P7AeMOLwOz/4Fs8kngmdK+YZhXeluZdAfM322d
         qcKvYIebP5Mc+HTTt6X9TmYJj8YUTzC0FNOuwhziTDkNXEzBJKR76fywmbWYGYwxZ05P
         sY26q40Qp7g7ebwdOayLzfRrov4uWHu05aLmVxGTYgKNWdgprJmSu9o9wT0Hj0YCd1lK
         37DXLwrnb/SAC660mm8OFX4I8ZNQkzwWX7DZLVXe3CyIbBRDYgSXJ8ViXc+Bkx8hEcic
         vg/By/cGlo8syvUIxT0qYplS0Iev7dXbjLvquGRIYtr3zQXeUf+0mwOoC90LF9xraT4X
         xAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDcYVndzbrv1IhY57IErydYh8H4ITxzj3QsSNm1fvUA=;
        b=g2/IOe00fD4FtBXcq/SB+2s8SA8kcBw9Z3rcSCg3aXHqqVwdunjx1YN7jw2kYZIKo/
         u76td5cAdTSsE9De1T/K8Y+S14YJsiXwdmweFqsJbuD80KHo7TPNCdNZeFJBbXy7l0A8
         0o9m4eAOnw166wpSUuFgyh9jz39/cDhr4OUlIMvF895S5vs8TSIVJzbVAsCYtKYDu/70
         kWfBeRbgsIXf/voEbKaVcVoJ4VSgvHokW+5k5gvjGbwIdsBSRq9YDvIyRwHt8GEXhh29
         A5Zfbu5WP2ZD8ZcIvm3AvFeljlbZFfv3Hg4ZNxsG9e1G9J6+xDysDvLBapklGvI9DssL
         r41Q==
X-Gm-Message-State: AO0yUKUOEgZtpHAD/LLg6uMITeIuN0gHmOHRrrC36ROIM/68IYE7ZcfT
        gs3prcRARHqN/+WZ0gZ0t0s=
X-Google-Smtp-Source: AK7set+RF5RVbaknUR6I652giSlyDxqIgRU4c27KGqjBnEb9NkAcBImhZ9z6ul97LXr0y1n02I27bQ==
X-Received: by 2002:a05:600c:4f06:b0:3da:fd07:1e3 with SMTP id l6-20020a05600c4f0600b003dafd0701e3mr4566739wmq.22.1675320145722;
        Wed, 01 Feb 2023 22:42:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i22-20020a1c5416000000b003dc3f3d77e3sm3884532wmb.7.2023.02.01.22.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 22:42:25 -0800 (PST)
Date:   Thu, 2 Feb 2023 09:42:12 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ata: pata_hpt37x: fix potential forever loop
Message-ID: <Y9tbRLRgPZb5AQ+/@kadam>
References: <Y9py1vjPW5HgRwOR@kili>
 <98e8e8cb-53a3-c247-078e-85724079ecad@omp.ru>
 <eb44fe29-47bb-315e-c340-10918a6250f6@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb44fe29-47bb-315e-c340-10918a6250f6@omp.ru>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Feb 01, 2023 at 08:18:13PM +0300, Sergey Shtylyov wrote:
> On 2/1/23 5:59 PM, Sergey Shtylyov wrote:
> [...]
> >> This code accidentally reuses the "tries" iterator for both the inside
> >> and outside loops.  It could result in a forever loop if the "tries"
> >> variable gets reset to 0x1000 and never reaches 0x5000.
> 
>    Have you actually seen this happening?
> 

No, this is from static analysis.

drivers/ata/pata_hpt3x2n.c:390 hpt3xn_calibrate_dpll() warn: reusing outside iterator: 'tries'

You're right that this is a false positive.  I thought I had addressed
that particular type of false positive so the check wouldn't warn about
it but apparently I hadn't.  Sorry!

Thanks again for reviewing this.

regards,
dan carpenter

