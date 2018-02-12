From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH/RFT v3] sata_rcar: Reset SATA PHY when Salvator-X board
 resumes
Date: Mon, 12 Feb 2018 09:22:59 -0800
Message-ID: <20180212172259.GE695913@devbig577.frc2.facebook.com>
References: <1517771931-17157-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33032 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbeBLRXE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2018 12:23:04 -0500
Content-Disposition: inline
In-Reply-To: <1517771931-17157-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-ide@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Mon, Feb 05, 2018 at 04:18:51AM +0900, Yoshihiro Kaneko wrote:
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

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
