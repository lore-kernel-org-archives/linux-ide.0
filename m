From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 5
Date: Wed, 03 Oct 2007 16:27:13 -0400
Message-ID: <4703FB21.2040906@garzik.org>
References: <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org> <20071002184958.GC31251@srcf.ucam.org> <47029423.6030605@garzik.org> <4702AC3B.2010004@garzik.org> <20071002212028.GA967@srcf.ucam.org> <4702B6C5.2070903@garzik.org> <20071003002416.GA3906@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071003002416.GA3906@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> Modern laptops with hotswap bays still tend to utilise a PATA interface
> on a SATA bridge, generally with the host controller in some legacy
> emulation mode rather than AHCI. This means that the existing hotplug
> code in libata is unable to work. The ACPI specification states that
> these devices can send notifications when hotswapped, which avoids the
> need to obtain notification from the controller. This patch uses the
> existing libata-acpi code and simply registers a notification in order
> to trigger a rescan whenever the firmware signals an event.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> ---
> 
> Diffed against #upstream. Fairly sure I've got it right this time...

indeed you did sir :)  applied, thanks

