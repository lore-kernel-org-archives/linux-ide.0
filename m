From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata:Fix error handling in the function
 ahci_pci_reset_controller
Date: Mon, 21 Sep 2015 15:07:54 -0400
Message-ID: <20150921190754.GF13263@mtj.duckdns.org>
References: <1442633267-24297-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442633267-24297-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Sep 18, 2015 at 11:27:47PM -0400, Nicholas Krause wrote:
> This fixes error handling in the function ahci_pci_reset_controller
> to properly check if the call to ahci_reset_controller fails and
> if return -EIO to this function's caller rather then continuing
> with this function's intended work if the controller cannot be
> reset properly for this ahci pci based device.

Maybe... I don't know.  What do we gain by failing resume?  Reporting
is fine but what'd be the recovery action?

Thanks.

-- 
tejun
