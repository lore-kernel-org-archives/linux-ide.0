From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: sata_rcar: Use of_device_get_match_data() helper
Date: Wed, 4 Oct 2017 15:51:25 +0300
Message-ID: <aabae5a7-24d6-3ef5-a92f-dcddff78a8c9@cogentembedded.com>
References: <1507119187-12297-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45675 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdJDMvb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2017 08:51:31 -0400
Received: by mail-lf0-f43.google.com with SMTP id d17so13286683lfe.2
        for <linux-ide@vger.kernel.org>; Wed, 04 Oct 2017 05:51:30 -0700 (PDT)
In-Reply-To: <1507119187-12297-1-git-send-email-geert+renesas@glider.be>
Content-Language: en-MW
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On 10/04/2017 03:13 PM, Geert Uytterhoeven wrote:

> Use the of_device_get_match_data() helper instead of open coding.
> Note that the sata_rcar driver is used with DT only, so there's always a
> valid match.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
