From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: ahci_start_engine compliant to AHCI spec
Date: Sat, 23 Apr 2011 16:40:44 +0200
Message-ID: <BANLkTinYzLJAPdpNsZYuDML0eszgw00JcQ@mail.gmail.com>
References: <1303541890-14528-1-git-send-email-jipeng2005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303541890-14528-1-git-send-email-jipeng2005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Apr 23, 2011 at 8:58 AM, Jian Peng <jipeng2005@gmail.com> wrote:
> At the end of section 10.1 of AHCI spec (rev 1.3), it states
>
> Software shall not set PxCMD.ST to 1 until it is determined that
> a functoinal device is present on the port as determined by
> PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h
>
> Even though most AHCI host controller works without this check,
> specific controller will fail under this condition.
>
> Signed-off-by: Jian Peng <jipeng2005@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
