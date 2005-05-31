From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] SATA NCQ #3
Date: Tue, 31 May 2005 20:29:18 +0400
Message-ID: <429C90DE.3000106@tls.msk.ru>
References: <20050531124659.GB1530@suse.de> <429C86AD.4050605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261958AbVEaQhY@vger.kernel.org>
In-Reply-To: <429C86AD.4050605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
[]
>  
>  struct ahci_host_priv {
>  	unsigned long		flags;
> +	unsigned int		have_msi; /* is PCI MSI enabled? */

BTW, can `have_msi' be just another bit in the `flags' field?

/mjt
