From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] AHCI: fix Null pointer dereference in achi_host_active()
Date: Mon, 22 Jul 2013 17:28:22 -0400
Message-ID: <20130722212822.GB16776@mtj.dyndns.org>
References: <51E53300.6010000@cogentembedded.com>
 <1374041439-34122-1-git-send-email-xtfeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374041439-34122-1-git-send-email-xtfeng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaotian Feng <xtfeng@gmail.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Xiaotian.

Thanks for the fix.  A couple comments below.

On Wed, Jul 17, 2013 at 02:10:39PM +0800, Xiaotian Feng wrote:
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ahci_port_priv *pp = host->ports[i]->private_data;
> +		const char *desc;
>  
> +		if (ata_port_is_dummy(host->ports[i]))
> +			desc = dev_driver_string(host->dev);
> +		else
> +			desc = pp->irq_desc;

I think it'd be better to branch on pp.  ie. do "if (pp) desc =
pp->... " instead and then add a comment saying "pp is NULL for
dummies".

Thanks!

-- 
tejun
