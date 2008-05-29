From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 14:40:19 +0100
Message-ID: <20080529134019.GA22738@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <20080529133302.GA9268@homac.suse.de> <20080529133201.GA22476@srcf.ucam.org> <20080529133921.GB9268@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756202AbYE2Nkv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080529133921.GB9268@homac.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

Running with init=/bin/bash, I still get it. The only kernel output I 
get is libata telling me that the device is disabled, and the machine is 
dead after that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
