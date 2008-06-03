From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Tue, 3 Jun 2008 19:13:46 +0100
Message-ID: <20080603181346.GA5013@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <4845886E.2010505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4845886E.2010505@garzik.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 03, 2008 at 02:07:42PM -0400, Jeff Garzik wrote:

> It would be nice if you and Holger could work together to produce a 
> single patch[set]...  right now I have patches from both of you, and I 
> was sorta waiting on the thread to die down to see if competing patches 
> might merge into a single set

I think we were waiting for feedback from Tejun as to why removing the 
port freeze call fixed the hang I was seeing? Beyond that, Holger's 
latest patch looked good to me.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
