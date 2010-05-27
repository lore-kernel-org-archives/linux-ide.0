From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Thu, 27 May 2010 23:52:11 +0200
Message-ID: <4BFEE98B.3090303@kernel.org>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com> <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On 05/27/2010 10:22 AM, Kukjin Kim wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.

Just one small thing.

> +static struct ata_port_operations pata_s3c_port_ops = {
> +	.inherits		= &ata_sff_port_ops,
> +	.sff_check_status	= pata_s3c_check_status,
> +	.sff_tf_load		= pata_s3c_tf_load,
> +	.sff_tf_read		= pata_s3c_tf_read,
> +	.sff_data_xfer		= pata_s3c_data_xfer,
> +	.sff_exec_command	= pata_s3c_exec_command,
> +	.qc_prep		= ata_noop_qc_prep,
> +	.set_piomode		= pata_s3c_set_piomode,
> +};
> +
> +static struct ata_port_operations pata_s5p_port_ops = {
> +	.inherits		= &ata_sff_port_ops,
> +	.qc_prep		= ata_noop_qc_prep,
> +	.set_piomode		= pata_s3c_set_piomode,
> +};

You don't need to override .qc_prep to ata_noop_qc_prep() and can you
please base the patch against the current libata-dev#upstream?

Thanks.

-- 
tejun
