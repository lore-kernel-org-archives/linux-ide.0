From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: add pci quirk for JMB362
Date: Mon, 07 Jun 2010 16:08:26 -0400
Message-ID: <4C0D51BA.7000109@garzik.org>
References: <4C077C70.4030500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4C077C70.4030500@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Aries Lee <arieslee@jmicron.com>, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

On 06/03/2010 05:57 AM, Tejun Heo wrote:
> JMB362 is a new variant of jmicron controller which is similar to
> JMB360 but has two SATA ports instead of one.  As there is no PATA
> port, single function AHCI mode can be used as in JMB360.  Add pci
> quirk for JMB362.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Aries Lee<arieslee@jmicron.com>
> Cc: stable@kernel.org
> ---
> Although this is a pci quirk, I think it's better routed thorugh
> libata tree but either way it's a pretty trivial patch.
>
> Thanks.
>
>   drivers/pci/quirks.c    |    5 ++++-
>   include/linux/pci_ids.h |    1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)

applied
