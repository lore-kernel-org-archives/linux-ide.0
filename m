From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 15:33:02 +0200
Message-ID: <20080529133302.GA9268@homac.suse.de>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080529132253.GA22309@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Thu 29. May - 14:22:53, Matthew Garrett wrote:
> Hm. This deadlocks my Thinkpad when I pull a device from the internal 
> bay.

Can you please give a bit more details? Does your userspace react on the
eject request? I tested with Thinkpads, too.

 - Holger

