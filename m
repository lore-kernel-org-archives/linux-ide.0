From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: libata: cdrw/dvdrom disabed after s2ram (2.6.24-rc2)
Date: Thu, 8 Nov 2007 18:22:18 +0000
Message-ID: <20071108182217.GA2685@srcf.ucam.org>
References: <4731C86B.1040704@infracomspa.it> <20071107121355.5eaf4496.akpm@linux-foundation.org> <47333CCF.1050403@infracomspa.it> <20071108094958.5c9b1b22.akpm@linux-foundation.org> <20071108180256.GB3491@havoc.gtf.org> <20071108101341.6c4f88d4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071108101341.6c4f88d4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, roppedisano@infracomspa.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Nov 08, 2007 at 10:13:41AM -0800, Andrew Morton wrote:

> I suspect it wold be best to disable the feature for the 2.6.24 release,
> then reenable it afterwards and keep doing this until the code is
> sufficiently stable.

GTF method execution failure currently looks like it's fatal, when it 
probably shouldn't be. I'll send a patch shortly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
