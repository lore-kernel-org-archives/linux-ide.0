From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2] sata/mvebu: use #ifdef around suspend/resume code
Date: Mon, 12 Oct 2015 15:40:25 +0200
Message-ID: <20151012154025.422ebc7e@free-electrons.com>
References: <7247630.qs4EYWgH4t@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7247630.qs4EYWgH4t@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Dear Arnd Bergmann,

On Mon, 12 Oct 2015 15:34:55 +0200, Arnd Bergmann wrote:
> The newly added suspend/resume implementation for ahci_mvebu causes
> a link error when CONFIG_PM_SUSPEND is disabled:
> 
> ERROR: "ahci_platform_suspend_host" [drivers/ata/ahci_mvebu.ko] undefined!
> ERROR: "ahci_platform_resume_host" [drivers/ata/ahci_mvebu.ko] undefined!
> 
> This adds the same #ifdef here that exists in the ahci_platform driver
> which defines the above functions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d6ecf1581488 ("ata: ahci_mvebu: add suspend/resume support")

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
