From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Fri, 21 Nov 2008 20:37:47 +0300
Message-ID: <4926F1EB.8090506@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4391 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756669AbYKURhq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 12:37:46 -0500
In-Reply-To: <49261BE5.2010406@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Hello.

David Daney wrote:

> As part of our efforts to get the Cavium OCTEON processor support
> merged (see: http://marc.info/?l=linux-mips&m=122704699515601), we
> have this CF driver for your consideration.

> Most OCTEON variants have *no* DMA or interrupt support on the CF
> interface so for these, only PIO is supported.  Although if DMA is
> available, we do take advantage of it.

> The register definitions are part of the chip support patch set
> mentioned above, and are not included here.

> At this point I would like to get feedback on the patch and would
> expect that it would merge via the linux-mips tree along with the rest
> of the chip support.

> Thanks,

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> new file mode 100644
> index 0000000..e8712c0
> --- /dev/null
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -0,0 +1,942 @@
[...]
> +/**
> + * Handle an I/O request.
> + *
> + * @cf:         Device to access
> + * @lba_sector: Starting sector
> + * @num_sectors:
> + *                   Number of sectors to transfer
> + * @buffer:     Data buffer
> + * @write:      Is the a write. Default to a read
> + */
> +static unsigned int octeon_cf_data_xfer(struct ata_device *dev,
> +                    unsigned char *buffer,
> +                    unsigned int buflen,
> +                    int rw)
> +{
> +    struct ata_port *ap        = dev->link->ap;
> +    struct octeon_cf_data *ocd    = ap->dev->platform_data;
> +    void __iomem *data_addr        = ap->ioaddr.data_addr;
> +    unsigned int words;
> +    unsigned int count;
> +
> +    /*
> +     * Odd lengths are not supported. We should always be a
> +     * multiple of 512.
> +     */
> +    BUG_ON(buflen & 1);
> +    if (ocd->is16bit) {
> +        words = buflen / 2;
> +        if (rw) {
> +            count = 16;
> +            while (words--) {
> +                iowrite16(*(uint16_t *)buffer, data_addr);
> +                buffer += sizeof(uint16_t);
> +                /*
> +                 * Every 16 writes do a read so the
> +                 * bootbus FIFO doesn't fill up.
> +                 */
> +                if (--count == 0) {
> +                    ioread8(ap->ioaddr.altstatus_addr);
> +                    count = 16;
> +                }
> +            }
> +        } else {
> +            while (words--) {
> +                *(uint16_t *)buffer = ioread16(data_addr);
> +                buffer += sizeof(uint16_t);
> +            }
> +        }
> +    } else {
> +        /* 8-bit */
> +        words = buflen;
> +        if (rw) {
> +            count = 16;
> +            while (words--) {
> +                iowrite8(*buffer, data_addr);

    About the 8-bit mode: you need to issue the Set Features command with 
opcode 1 to enable that mode -- libata currently doesn't do that, so it won't 
work I suppose...

MBR, Sergei
