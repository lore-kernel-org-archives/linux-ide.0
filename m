From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata: rcar_sata: Reset SATA PHY when Salvator-X board
 resumes
Date: Sat, 30 Dec 2017 13:28:19 +0300
Message-ID: <cc623a4c-86fd-8437-a2f5-b7d15e5651ee@cogentembedded.com>
References: <1512585925-4251-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35130 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdL3K2W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 30 Dec 2017 05:28:22 -0500
Received: by mail-lf0-f42.google.com with SMTP id h5so6446340lfj.2
        for <linux-ide@vger.kernel.org>; Sat, 30 Dec 2017 02:28:21 -0800 (PST)
In-Reply-To: <1512585925-4251-1-git-send-email-ykaneko0929@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org

Hello!

On 12/6/2017 9:45 PM, Yoshihiro Kaneko wrote:

> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>

    Please use "sata_rcar: " prefix for the subject.

> Because power of Salvator-X board is cut off in suspend,
> it needs to reset SATA PHY state in resume.
> Otherwise, SATA partition could not be accessed anymore.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
[...]

MBR, Sergei
