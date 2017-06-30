From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_highbank: fix error return code in
 ahci_highbank_probe()
Date: Sat, 1 Jul 2017 00:21:19 +0300
Message-ID: <b73bd295-238a-c0b0-de14-5f5186600217@cogentembedded.com>
References: <20170630050306.GA17486@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34654 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbdF3VVX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 17:21:23 -0400
Received: by mail-lf0-f48.google.com with SMTP id l13so76897747lfl.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 14:21:22 -0700 (PDT)
In-Reply-To: <20170630050306.GA17486@embeddedgus>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/30/2017 08:03 AM, Gustavo A. R. Silva wrote:

> Propagate the return value of platform_get_irq on failure.

    Needs the same explanations as the sata_rcar patch.

> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
[...]

MBR, Sergei

