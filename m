From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/29] PCI, libata: remove find_bridge in acpi_bus_type
Date: Tue, 25 Sep 2012 12:23:10 -0400
Message-ID: <5061DA6E.3040008@pobox.com>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org> <1348561590-28067-10-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1348561590-28067-10-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 09/25/2012 04:26 AM, Yinghai Lu wrote:
> The struct member is not used anymore, remove it.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org
> ---
>   drivers/ata/libata-acpi.c |    6 ------
>   1 files changed, 0 insertions(+), 6 deletions(-)

Acked-by: Jeff Garzik <jgarzik@redhat.com>
