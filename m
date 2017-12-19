From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V4 10/26] Drivers: ide: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 09:13:47 -0500 (EST)
Message-ID: <20171219.091347.2290443745330245044.davem@davemloft.net>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
        <1513661883-28662-11-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513661883-28662-11-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@codeaurora.org
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 19 Dec 2017 00:37:46 -0500

> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Replace pci_get_bus_and_slot() with pci_get_domain_bus_and_slot()
> and extract the domain number from struct pci_dev.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: David S. Miller <davem@davemloft.net>
