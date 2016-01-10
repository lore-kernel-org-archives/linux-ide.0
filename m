From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] drivers: ata: wake port before DMA stop for ALPM
Date: Sun, 10 Jan 2016 12:29:29 -0500
Message-ID: <20160110172929.GK3660@htj.duckdns.org>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-4-git-send-email-f.fainelli@gmail.com>
 <20160108163610.GS1898@mtj.duckdns.org>
 <5690444C.2090200@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5690444C.2090200@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Danesh Petigara <dpetigara@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com
List-Id: linux-ide@vger.kernel.org

Hello, Danesh.

On Fri, Jan 08, 2016 at 03:20:44PM -0800, Danesh Petigara wrote:
> ahci_set_lpm in it's current form cannot be used here as it also
> modifies the ALPE/ASP bits. The idea is to wake the link before DMA stop
> without changing the ALPM bits so the link can return to it's configured
> low power state when it's idle.
> 
> We could however update that function by introducing a new hints flag
> that allows us to skip unneeded logic for this scenario. ahci_set_lpm
> can then be called from ahci_stop_engine.

Yeah, please either update the function or factor the necessary part
out.

Thanks.

-- 
tejun
