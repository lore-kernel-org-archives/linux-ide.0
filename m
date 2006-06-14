From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/7] sata_nv: implement irq manipulation methods
Date: Tue, 13 Jun 2006 21:00:54 -0400
Message-ID: <448F5FC6.60807@pobox.com>
References: <11502342644086-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56744 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932389AbWFNBA5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2006 21:00:57 -0400
In-Reply-To: <11502342644086-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add four irq manipulation callbacks to nv_host_desc and implement
> those methods for nf2/3 and ck804.  These methods will be used by new
> irq_handler, EH and hotplug support.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_nv.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 87 insertions(+), 0 deletions(-)
> 
> d47f98a5ada7fb993f659f4ba1eb496457122455
> diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
> index f370044..93e74aa 100644
> --- a/drivers/scsi/sata_nv.c
> +++ b/drivers/scsi/sata_nv.c
> @@ -77,6 +77,16 @@ enum {
>  	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
>  };
>  
> +static u8 nf2_get_irq_mask(struct ata_host_set *host_set);
> +static void nf2_set_irq_mask(struct ata_host_set *host_set, u8 mask);
> +static u8 nf2_get_irq_status(struct ata_host_set *host_set);
> +static void nf2_clr_irq_status(struct ata_host_set *host_set);
> +
> +static u8 ck804_get_irq_mask(struct ata_host_set *host_set);
> +static void ck804_set_irq_mask(struct ata_host_set *host_set, u8 mask);
> +static u8 ck804_get_irq_status(struct ata_host_set *host_set);
> +static void ck804_clr_irq_status(struct ata_host_set *host_set);
> +
>  static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
>  static irqreturn_t nv_interrupt (int irq, void *dev_instance,
>  				 struct pt_regs *regs);
> @@ -133,6 +143,10 @@ static const struct pci_device_id nv_pci
>  struct nv_host_desc
>  {
>  	enum nv_host_type	host_type;
> +	u8   (*get_irq_mask) (struct ata_host_set *host_set);
> +	void (*set_irq_mask) (struct ata_host_set *host_set, u8 mask);
> +	u8   (*get_irq_status) (struct ata_host_set *host_set);
> +	void (*clr_irq_status) (struct ata_host_set *host_set);

NAK this train of thought.  We don't need new mini-API hooks like this, 
when you could just implement nf2_xxx() and ck804_xxx() hooks at a 
higher level.  Rather than growing "stealth nf2 checks" like this:

+static void nv_freeze (struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host_desc *host_desc = host_set->private_data;
+	int shift = ap->port_no * NV_INT_PORT_SHIFT;
+	u8 mask;
+
+	if (!host_desc->get_irq_mask) {
+		ata_bmdma_freeze(ap);
+		return;
+	}

you should implement nf2_freeze() and nv_freeze() separately (or 
nf2_freeze and ck804_freeze, whatever).

Another example of adding a test, where adding a hook would be better:

  static void nv_host_stop (struct ata_host_set *host_set)
  {
+	struct nv_host_desc *host_desc = host_set->private_data;
+
+	/* disable SATA space for CK804 */
+	if (host_desc->host_type == CK804) {
+		struct pci_dev *pdev = to_pci_dev(host_set->dev);
+		u8 regval;
+
+		pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+		regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+		pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	}

Thoughout _every_ single patch, one sees old-vs-ck804 differences.  Your 
patches highlight these differences with every single irq_stat_valid 
test, for example.

I think it is better for testing a long term maintainability if your 
patches create separate hooks for old and ck804 hardware.  I think 
you'll find that it makes implementing EH and hotplug stuff much easier, 
and it will aid the integration of ADMA support down the road.  A first 
step is probably splitting the interrupt handler into nv_xxx and 
ck804_xxx versions, then proceeding your 7-patch set, keeping in mind 
the "hook preferred over 'if'" model.

	Jeff



