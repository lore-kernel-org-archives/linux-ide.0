From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v1] ata: sata_rcar: Handle return value of
 clk_prepare_enable
Date: Wed, 10 May 2017 12:02:37 +0300
Message-ID: <16092444-34a3-bfcb-81df-5ecd63b6ffcb@cogentembedded.com>
References: <1494325828-2725-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34306 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbdEJJCe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2017 05:02:34 -0400
Received: by mail-qt0-f180.google.com with SMTP id j29so21263417qtj.1
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2017 02:02:34 -0700 (PDT)
In-Reply-To: <1494325828-2725-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 5/9/2017 1:30 PM, Arvind Yadav wrote:

> Here, Clock enable can failed. So adding an error check for

    Maybe "here enabling the clock can fail"?

> clk_prepare_enable.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

    Other than that:

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

