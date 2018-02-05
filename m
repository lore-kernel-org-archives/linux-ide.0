From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RFT v3] sata_rcar: Reset SATA PHY when Salvator-X board
 resumes
Date: Mon, 5 Feb 2018 11:33:24 +0300
Message-ID: <1ca78555-fea3-3fea-090d-66dca48dc4ea@cogentembedded.com>
References: <1517771931-17157-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:40601 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbeBEIdX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2018 03:33:23 -0500
Received: by mail-lf0-f41.google.com with SMTP id h92so40498598lfi.7
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2018 00:33:23 -0800 (PST)
In-Reply-To: <1517771931-17157-1-git-send-email-ykaneko0929@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org

Hello!

On 2/4/2018 10:18 PM, Yoshihiro Kaneko wrote:

> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> 
> Because power of Salvator-X board is cut off in suspend,
> it needs to reset SATA PHY state in resume.
> Otherwise, SATA partition could not be accessed anymore.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
> [reinit phy in sata_rcar_resume() function on R-Car Gen3 only]
> [factor out SATA module init sequence]
> [fixed the prefix for the subject]
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
[...]

    OK, this one seems better.

MBR, Sergei
