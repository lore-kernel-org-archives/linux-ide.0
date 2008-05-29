From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 23:37:57 +0900
Message-ID: <483EBFC5.7020406@gmail.com>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org> <20080529141421.GC9268@homac.suse.de> <20080529143541.GA24013@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756136AbYE2Oih@vger.kernel.org>
In-Reply-To: <20080529143541.GA24013@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> On Thu, May 29, 2008 at 04:14:21PM +0200, Holger Macht wrote:
>> On Thu 29. May - 15:02:13, Matthew Garrett wrote:
>>> No, I'm seeing an identical hang. Mainline works fine.
>> Maybe you could also try this on top of Tejun's patch?
> 
> No luck there either, I'm afraid.

That means device isn't being detached or something afterwards triggers
hotplug event on the detached port.  Can you please sprinkle printks
around and see what ata_acpi_handle_hotplug() does?

Thanks.

-- 
tejun
