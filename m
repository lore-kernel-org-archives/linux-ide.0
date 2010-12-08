From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: questions regarding possible violation of AHCI spec in AHCI driver
Date: Tue, 07 Dec 2010 19:54:49 -0600
Message-ID: <4CFEE569.4030204@gmail.com>
References: <E18F441196CA634DB8E1F1C56A50A874319F70C1F2@IRVEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A874319F70C1F2@IRVEXCHCCR01.corp.ad.broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jian Peng <jipeng@broadcom.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

CCing linux-ide and Tejun.

On 12/07/2010 01:43 AM, Jian Peng wrote:
> Recently, while bringing up a new AHCI host controller, I found out that current AHCI driver (in 2.6.37-rc3) may violate AHCI spec in function libahci.c: ahci_start_engine().
>
>  From end of section 10.1.2 in AHCI 1.3 spec, it claims
>
> Software shall not set PxCMD.ST to '1' until it is determined that a functional device is present on the port
> as determined by PxTFD.STS.BSY = '0', PxTFD.STS.DRQ = '0', and PxSSTS.DET = 3h.
>
> It seems working well on most controller without this extra checking, but does cause problem in our new core. Since toggling PxCMD.SUD already initiated reset process at early time, and by the time of ahci_start_engine() got called, BSY bit may not be cleared yet, and forcing PxCMD.ST bit to 1 will cause problem for HW in this case.
>
> Since I do not know all history about AHCI driver, I really hope that AHCI driver and libata maintainer can comment on this.

Seems like a valid point to me, according to the spec. I'm guessing it 
just hasn't come up previously with other controllers?
