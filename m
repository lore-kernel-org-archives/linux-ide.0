From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] hook ACPI _PSx method to IDE power on/off
Date: Thu, 2 Aug 2007 13:31:45 +0100
Message-ID: <20070802123145.GA30304@srcf.ucam.org>
References: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 02, 2007 at 02:14:08PM +0800, Shaohua Li wrote:
> ACPI spec defines the sequence of IDE power on/off:

Most distributions seem to be using the libata PATA code now - any plans 
to implement it there as well?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
