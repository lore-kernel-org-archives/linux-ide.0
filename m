From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 13:44:03 +0100
Message-ID: <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20061204123854.GA28159@aepfle.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
>  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>  	unsigned long start, end, mask, offset;
>
> +	/*
> +	 * tell the core code that this ressource is unassigned
> +	 * fixes p630 winbond IDE with libata
> +	 */
> +	if (res->start == 0) {
> +		res->flags = 0;
> +		return;
> +	}
>  	if (res->flags & IORESOURCE_IO) {
>  		offset = (unsigned long)hose->io_base_virt - pci_io_base;

Please make this run on pSeries only; on a PowerMac for
example, it's totally normal that the first PCI legacy I/O
BAR in the system gets assigned 0.


Segher
