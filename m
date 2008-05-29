From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 14:22:53 +0100
Message-ID: <20080529132253.GA22309@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080528143857.GB5585@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

Hm. This deadlocks my Thinkpad when I pull a device from the internal 
bay.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
