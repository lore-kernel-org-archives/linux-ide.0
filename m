From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 5/6] AHCI: Check MRSM bit when multiple MSIs enabled
Date: Thu, 05 Sep 2013 18:32:36 +0400
Message-ID: <52289604.50202@cogentembedded.com>
References: <cover.1378383792.git.agordeev@redhat.com> <4bc31d6ccf3f84399b977fe8ed4fe77aadfa1c79.1378383792.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4bc31d6ccf3f84399b977fe8ed4fe77aadfa1c79.1378383792.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

Hello.

On 09/05/2013 04:54 PM, Alexander Gordeev wrote:

> Do not trust the hardware and always check if MSI
> Revert to Single Message mode was enforced. Fall
> back to the single MSI mode in case it did. Not
> doing so might screw up the interrupt handling.

> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>   drivers/ata/ahci.c |   16 ++++++++++++++++
>   drivers/ata/ahci.h |    1 +
>   2 files changed, 17 insertions(+), 0 deletions(-)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a6bb618..af5d535 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1091,6 +1091,14 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
>   {}
>   #endif
>
> +static int ahci_get_mrsm(struct ahci_host_priv *hpriv)
> +{
> +	void __iomem *mmio = hpriv->mmio;
> +	u32 ctl = readl(mmio + HOST_CTL);
> +
> +	return (ctl & HOST_MRSM);

    Parens not needed here, in case you'll respin this once more.

WBR, Sergei
